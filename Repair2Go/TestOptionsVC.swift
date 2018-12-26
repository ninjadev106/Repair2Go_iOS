//
//  TestOptionsVC.swift
//  Repair2Go
//
//  Created by mobile on 12/24/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class TestOptionsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
