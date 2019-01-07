//
//  FlashLightVC.swift
//  Repair2Go
//
//  Created by mobile on 12/26/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import AVFoundation

class FlashLightVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }
            
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    @IBAction func onTappedBtnFlashlight(_ sender: Any) {
        toggleFlash()
    }
    
    @IBAction func onTappedBtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTappedOk(_ sender: Any) {
        TestOptionsVC.flashTestResult = .success
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTappedFailed(_ sender: Any) {
        TestOptionsVC.flashTestResult = .failed
        
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
