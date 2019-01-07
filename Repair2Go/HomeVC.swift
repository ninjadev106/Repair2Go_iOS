//
//  ViewController.swift
//  Repair2Go
//
//  Created by mobile on 12/22/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import ContactsUI

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
    
    public func displayMenuItemScreen(_ screen: TargetScreen) {
        switch screen {
        case .spec_offer:
            print("")
        case .addcontacts:
            let contactsVC = self.storyboard?.instantiateViewController(withIdentifier: "AddContactVC") as! AddContactVC
            self.present(contactsVC, animated: true, completion: nil)
        case .aboutus:
            print("")
        case .route:
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RouteVC") as! RouteVC
            self.present(controller, animated: true, completion: nil)
        case .openhours:
            print("")
        case .appointment:
            let appointmentVC = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentVC") as! AppointmentVC
            self.present(appointmentVC, animated: true, completion: nil)
        default:
            print("")
        }
    }


}

