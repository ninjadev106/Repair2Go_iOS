//
//  OpenhoursVC.swift
//  Repair2Go
//
//  Created by mobile on 1/1/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit

class OpenhoursVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTappedBtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTappedBtnCall(_ sender: Any) {
        if let url = URL(string: "tel://\(0640901124)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
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
