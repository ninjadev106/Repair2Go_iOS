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
            let aboutusVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutusVC") as! AboutusVC
            self.present(aboutusVC, animated: true, completion: nil)
        case .route:
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RouteVC") as! RouteVC
            self.present(controller, animated: true, completion: nil)
        case .openhours:
            let openhoursVC = self.storyboard?.instantiateViewController(withIdentifier: "OpenhoursVC") as! OpenhoursVC
            self.present(openhoursVC, animated: true, completion: nil)
        case .appointment:
            let appointmentVC = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentVC") as! AppointmentVC
            self.present(appointmentVC, animated: true, completion: nil)
        case .privacy:
            let alertController = UIAlertController(title: "Privacy Poli", message: "The processing of personal data, such as the name, address, e-mail address, or telephone number of a data subject shall always be in line with the General Data Protection Regulation (GDPR), and in accordance with the country-specific data protection regulations applicable to the Repair2Go.", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            self.present(alertController, animated: true, completion: nil)
        default:
            print("")
        }
    }


}

