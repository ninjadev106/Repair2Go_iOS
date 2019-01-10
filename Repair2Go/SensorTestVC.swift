//
//  SensorTestVC.swift
//  Repair2Go
//
//  Created by mobile on 12/26/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class SensorTestVC: UIViewController {
    
    @IBOutlet weak var testView: UIView!
    
    let device = UIDevice.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activateProximitySensor()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        device.isProximityMonitoringEnabled = false
    }
    
    func activateProximitySensor() {
        device.isProximityMonitoringEnabled = true
        if device.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector(proximityChanged), name: UIDevice.proximityStateDidChangeNotification, object: device)
        }
    }
    
    @objc func proximityChanged(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            print("\(device) detected!")
            if device.proximityState {
                testView.backgroundColor = UIColor.red
            } else {
                testView.backgroundColor = UIColor.green
            }
        }
    }
    
    @IBAction func onTappedBtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTappedOk(_ sender: Any) {
        TestOptionsVC.sensorTestResult = .success
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTappedFailed(_ sender: Any) {
        TestOptionsVC.sensorTestResult = .failed
        
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
