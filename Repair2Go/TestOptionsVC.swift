//
//  TestOptionsVC.swift
//  Repair2Go
//
//  Created by mobile on 12/24/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import DeviceKit

enum TestResult: Int {
    case failed
    case none
    case success
}

class TestOptionsVC: UIViewController {

    @IBOutlet weak var lblDeviceModel: UILabel!
    @IBOutlet weak var lblDeviceName: UILabel!
    @IBOutlet weak var lblOSVersion: UILabel!
    @IBOutlet weak var lblStorage: UILabel!
    @IBOutlet weak var lblBattery: UILabel!
    
    @IBOutlet weak var imageTouchTestResult: UIImageView!
    @IBOutlet weak var imageMicTestResult: UIImageView!
    @IBOutlet weak var imageCameraTestResult: UIImageView!
    @IBOutlet weak var imageLCDTestResult: UIImageView!
    @IBOutlet weak var imageGPSTestResult: UIImageView!
    @IBOutlet weak var imageVibrateTestResult: UIImageView!
    @IBOutlet weak var imageFlashTestResult: UIImageView!
    @IBOutlet weak var imageSensorTestResult: UIImageView!

    public static var touchTestResult = TestResult.none
    public static var micTestResult = TestResult.none
    public static var cameraTestResult = TestResult.none
    public static var lcdTestResult = TestResult.none
    public static var gpsTestResult = TestResult.none
    public static var vibrateTestResult = TestResult.none
    public static var flashTestResult = TestResult.none
    public static var sensorTestResult = TestResult.none

    override func viewDidLoad() {
        super.viewDidLoad()

        let device = Device()
        lblDeviceModel.text = "\(device)"
        lblDeviceName.text = "\(device.name)"
        lblOSVersion.text = "iOS " + "\(device.systemVersion)"
        lblBattery.text = "\(device.batteryLevel)%"
        
        let totalDiskSpace = UIDevice.current.totalDiskSpaceInGB
        let usedDiskSpace = UIDevice.current.usedDiskSpaceInGB
        let total: Double = Double(UIDevice.current.totalDiskSpaceInBytes)
        let used: Double = Double(UIDevice.current.usedDiskSpaceInBytes)
        let percent: Double = used / total * 100
        let roundedPercent = Double(round(10*percent)/10)
        lblStorage.text = usedDiskSpace + "/" + totalDiskSpace + " (" + String(roundedPercent) + "%)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTestResult(TestOptionsVC.touchTestResult, target: imageTouchTestResult)
        updateTestResult(TestOptionsVC.micTestResult, target: imageMicTestResult)
        updateTestResult(TestOptionsVC.cameraTestResult, target: imageCameraTestResult)
        updateTestResult(TestOptionsVC.lcdTestResult, target: imageLCDTestResult)
        updateTestResult(TestOptionsVC.gpsTestResult, target: imageGPSTestResult)
        updateTestResult(TestOptionsVC.vibrateTestResult, target: imageVibrateTestResult)
        updateTestResult(TestOptionsVC.flashTestResult, target: imageFlashTestResult)
        updateTestResult(TestOptionsVC.sensorTestResult, target: imageSensorTestResult)
    }

    func updateTestResult(_ result: TestResult, target: UIImageView){
        switch result {
        case .failed:
            target.image = UIImage(named: "uncheck")
        case .success:
            target.image = UIImage(named: "check")
        case .none:
            target.image = UIImage(named: "")
        }
    }
    
    @IBAction func onTappedBtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTappedBtnCamera(_ sender: Any) {
        let cameraVC = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") as! CameraVC
        cameraVC.modalPresentationStyle = .fullScreen
        self.present(cameraVC, animated: true, completion: nil)
    }
    
    @IBAction func onTappedBtnTouch(_ sender: Any) {
        let touchVC = self.storyboard?.instantiateViewController(withIdentifier: "TouchTestVC") as! TouchTestVC
        touchVC.modalPresentationStyle = .fullScreen
        self.present(touchVC, animated: true, completion: nil)
    }
    
    @IBAction func onTappedBtnMicrophone(_ sender: Any) {
        let microphoneVC = self.storyboard?.instantiateViewController(withIdentifier: "MicrophoneVC") as! MicrophoneVC
        microphoneVC.modalPresentationStyle = .fullScreen
        self.present(microphoneVC, animated: true, completion: nil)
    }
    
    @IBAction func onTappedBtnLCD(_ sender: Any) {
        let lcdTestVC = self.storyboard?.instantiateViewController(withIdentifier: "LcdTestVC") as! LcdTestVC
        lcdTestVC.modalPresentationStyle = .fullScreen
        self.present(lcdTestVC, animated: true, completion: nil)
    }
    
    @IBAction func onTappedBtnGPS(_ sender: Any) {
        let gpsTestVC = self.storyboard?.instantiateViewController(withIdentifier: "GPSTestVC") as! GPSTestVC
        gpsTestVC.modalPresentationStyle = .fullScreen
        self.present(gpsTestVC, animated: true, completion: nil)
    }
    
    @IBAction func onTappedBtnTorch(_ sender: Any) {
        let flashLightVC = self.storyboard?.instantiateViewController(withIdentifier: "FlashLightVC") as! FlashLightVC
        flashLightVC.modalPresentationStyle = .fullScreen
        self.present(flashLightVC, animated: true, completion: nil)
    }
    
    @IBAction func onTappedBtnVibrate(_ sender: Any) {
        let vibrateVC = self.storyboard?.instantiateViewController(withIdentifier: "VibrateVC") as! VibrateVC
        vibrateVC.modalPresentationStyle = .fullScreen
        self.present(vibrateVC, animated: true, completion: nil)
    }
    
    @IBAction func onTappedBtnSensor(_ sender: Any) {
        let sensorTestVC = self.storyboard?.instantiateViewController(withIdentifier: "SensorTestVC") as! SensorTestVC
        sensorTestVC.modalPresentationStyle = .fullScreen
        self.present(sensorTestVC, animated: true, completion: nil)
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

extension UIDevice {
    func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }
    
    //MARK: Get String Value
    var totalDiskSpaceInGB:String {
        return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var freeDiskSpaceInGB:String {
        return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var usedDiskSpaceInGB:String {
        return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var totalDiskSpaceInMB:String {
        return MBFormatter(totalDiskSpaceInBytes)
    }
    
    var freeDiskSpaceInMB:String {
        return MBFormatter(freeDiskSpaceInBytes)
    }
    
    var usedDiskSpaceInMB:String {
        return MBFormatter(usedDiskSpaceInBytes)
    }
    
    //MARK: Get raw value
    var totalDiskSpaceInBytes:Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
        return space
    }
    
    /*
     Total available capacity in bytes for "Important" resources, including space expected to be cleared by purging non-essential and cached resources. "Important" means something that the user or application clearly expects to be present on the local system, but is ultimately replaceable. This would include items that the user has explicitly requested via the UI, and resources that an application requires in order to provide functionality.
     Examples: A video that the user has explicitly requested to watch but has not yet finished watching or an audio file that the user has requested to download.
     This value should not be used in determining if there is room for an irreplaceable resource. In the case of irreplaceable resources, always attempt to save the resource regardless of available capacity and handle failure as gracefully as possible.
     */
    var freeDiskSpaceInBytes:Int64 {
        if #available(iOS 11.0, *) {
            if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                return space ?? 0
            } else {
                return 0
            }
        } else {
            if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
                let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
                return freeSpace
            } else {
                return 0
            }
        }
    }
    
    var usedDiskSpaceInBytes:Int64 {
        return totalDiskSpaceInBytes - freeDiskSpaceInBytes
    }
    
}
