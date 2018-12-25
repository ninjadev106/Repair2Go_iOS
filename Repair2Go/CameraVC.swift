//
//  TestOptionsVC.swift
//  Repair2Go
//
//  Created by mobile on 12/23/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import Photos
import AVFoundation
import SnapKit

class CameraVC: UIViewController {
    @IBOutlet weak var cameraContainerView: UIView!
    @IBOutlet weak var btnCamera: UIButton!
    
    // MARK: State
    var blurView: UIVisualEffectView!
    var session: AVCaptureSession!
    var captureQueue: OperationQueue!
    var capturePreviewView: UIView!
    var capturePreviewLayer: AVCaptureVideoPreviewLayer!
    var photoOutput: AVCapturePhotoOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialise the capture queue
        captureQueue = OperationQueue()
        
        // Initialise the blur effect used when switching between cameras
        let effect = UIBlurEffect(style: .light)
        blurView = UIVisualEffectView(effect: effect)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Enable live camera when opening current view controller
        enableCapture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        // Initialize capture setting to 0 when leaving this view controller
        captureQueue.cancelAllOperations()
        capturePreviewLayer.removeFromSuperlayer()
        for input in session.inputs {
            session.removeInput(input)
        }
        for output in session.outputs {
            session.removeOutput(output)
        }
        session.stopRunning()
        session = nil
        
    }
    
    func enableCapture() {
        if (session != nil) { return }
        // setup camera
        let operation = captureOperation()
        operation.completionBlock = {
            self.operationCompleted()
        }
        operation.queuePriority = .veryHigh
        captureQueue.addOperation(operation)
    }
    
    func captureOperation() -> BlockOperation {
        let operation = BlockOperation {
            
            // setup capture session
            self.session = AVCaptureSession()
            self.session.sessionPreset = AVCaptureSession.Preset.photo
            
            // setup input device
            let device = AVCaptureDevice.default(for: AVMediaType.video)
            
            //            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession.init(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
            //            var device = AVCaptureDevice.default(for: AVMediaType.video)
            //            for currentDevice in deviceDiscoverySession.devices {
            //                if (currentDevice.position == .front) {
            //                    device = currentDevice
            //                }
            //            }
            
            // Prepare the input
            let input: AVCaptureDeviceInput?
            do {
                input = try AVCaptureDeviceInput(device: device!)
            } catch {
                input = nil
            }
            
            if (input == nil) { return }
            
            // Attach the input
            self.session.addInput(input!)
            
            // Turn on point autofocus for middle of view
            do {
                try device?.lockForConfiguration()
            } catch {
                return
            }
            
            if (device?.isFocusModeSupported(.autoFocus))! {
                device?.focusPointOfInterest = CGPoint(x: 0.5, y: 0.5)
                device?.focusMode = .continuousAutoFocus
            }
            
            device?.unlockForConfiguration()
            
            // Configure live preview
            self.capturePreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
            DispatchQueue.main.async {
                self.capturePreviewLayer.frame = self.cameraContainerView.bounds
            }
            self.capturePreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.capturePreviewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            
            // Configure output
            self.photoOutput = AVCapturePhotoOutput()
            self.photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            self.session.addOutput(self.photoOutput!)
        }
        
        return operation
    }
    
    func operationCompleted() {
        DispatchQueue.main.async {
            if (self.session == nil) { return }
            guard self.currentDevice() != nil else { return }
            
            self.capturePreviewView = UIView(frame: CGRect.zero)
            self.cameraContainerView.addSubview(self.capturePreviewView)
            self.capturePreviewView.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            self.capturePreviewView.layer.addSublayer(self.capturePreviewLayer)
            self.session.startRunning()
        }
    }
    
    // Get CurrentDevice
    func currentDevice() -> AVCaptureDevice? {
        if (session == nil) { return nil }
        guard let inputDevice = session.inputs.first as? AVCaptureDeviceInput else { return nil }
        return inputDevice.device
    }
    
    // Get FrontCamera
    func frontCamera() -> AVCaptureDevice? {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession.init(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        for device in deviceDiscoverySession.devices {
            let device = device
            if (device.position == .front) {
                return device
            }
        }
        return nil
    }
    
    
    @IBAction func btnFlipCameraTapped(_ sender: Any) {
        
        if (session == nil) { return }
        session.stopRunning()
        
        // Input Switch
        let operation = BlockOperation {
            var input = self.session.inputs.first as! AVCaptureDeviceInput
            
            let newCamera: AVCaptureDevice
            
            if (input.device.position == .back) {
                newCamera = self.frontCamera()!
            } else {
                newCamera = AVCaptureDevice.default(for: AVMediaType.video)!
            }
            
            // Remove previous camera, and add new
            self.session.removeInput(input)
            
            do {
                try input = AVCaptureDeviceInput(device: newCamera)
            } catch {
                return
            }
            self.session.addInput(input)
        }
        operation.completionBlock = {
            DispatchQueue.main.async {
                if (self.session == nil) { return }
                self.session.startRunning()
                self.blurView.removeFromSuperview()
            }
        }
        operation.queuePriority = .veryHigh
        
        // Add blur to avoid flickering
        self.blurView.isHidden = false
        self.capturePreviewView.addSubview(self.blurView)
        
        self.blurView.snp.makeConstraints({ (make) in
            
            make.edges.equalToSuperview()
        })
        
        // Flip Animation
        UIView.transition(with: self.capturePreviewView, duration: 0.5, options: [.transitionFlipFromLeft, .allowAnimatedContent], animations: nil) { (finished) in
            self.btnCamera.isEnabled = true
            self.captureQueue.addOperation(operation)
        }
        
    }
    
    @IBAction func onTappedBtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
