//
//  VibrateVC.swift
//  Repair2Go
//
//  Created by mobile on 12/26/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import AudioToolbox

class VibrateVC: UIViewController {

    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        //set timer
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(doVibrate), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    @objc func doVibrate(_ timer: Timer) {
       AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
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
