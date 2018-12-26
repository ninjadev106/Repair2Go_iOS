//
//  LCDTestVC.swift
//  Repair2Go
//
//  Created by mobile on 12/24/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class LcdTestVC: UIViewController {

    var timer: Timer!
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.red
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(colorChange), userInfo: nil, repeats: true)
        
    }
    
    @objc func colorChange(_ timer: Timer) {
        counter += 1
        var remainer = 0
        remainer = counter % 6
        switch remainer {
        case 0:
            self.view.backgroundColor = UIColor.red
        case 1:
            self.view.backgroundColor = UIColor.green
        case 2:
            self.view.backgroundColor = UIColor.blue
        case 3:
            self.view.backgroundColor = UIColor.yellow
        case 4:
            self.view.backgroundColor = UIColor.white
        case 5:
            self.view.backgroundColor = UIColor.black
        default:
            print("Do nothing")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
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
