//
//  ViewController.swift
//  Repair2Go
//
//  Created by mobile on 12/22/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStatusBar()
        
    }
    
    func setStatusBar() {
//        UIApplication.shared.statusBarStyle = .default
        UINavigationBar.appearance().clipsToBounds = true
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.white
    }


}

