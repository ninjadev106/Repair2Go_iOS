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
    }
    
    @IBAction func onTappedBtnGPS(_ sender: Any) {
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
