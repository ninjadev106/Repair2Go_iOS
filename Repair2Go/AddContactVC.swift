//
//  AddContactVC.swift
//  Repair2Go
//
//  Created by Le Van Thang on 1/7/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit
import AddressBookUI
import ContactsUI

class AddContactVC: UIViewController, CNContactViewControllerDelegate {

    @IBOutlet var viewContact: UIView!
    
    var addContactViewController: CNContactViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = CNMutableContact()

        /*
         
         
         Repair2Go
         Adress: Haarlemmerstraat 193
         2312 DP, Leiden Zuid-Holland
         0800-1421 Whatsapp: 0640901124
         Mail: info@repair2go.nl
         web: www.Repair2Go.nl
         
        */
        a.familyName = "Repair2Go"
        a.givenName = ""
        a.contactType = .organization
        a.imageData = UIImage(named: "avatar")!.pngData()
        
        let workPhone = CNLabeledValue(label: "Phone", value: CNPhoneNumber(stringValue: "0640901124"))
        a.phoneNumbers = [workPhone]

        let workEmail = CNLabeledValue(label:"Email", value:"info@repair2go.nl" as NSString)
        a.emailAddresses = [workEmail]
        
        let workSite = CNLabeledValue(label:"Site", value:"www.Repair2Go.nl" as NSString)
        a.urlAddresses = [workSite]
        
        // Address
        let address = CNMutablePostalAddress()
        address.street = "Haarlemmerstraat 193 2312 DP"
        address.city = "Leiden Zuid"
        address.state = ""
//        address.postalCode = "0800-1421"
        address.country = "Holland"
        let workAddress = CNLabeledValue<CNPostalAddress>(label:"Address", value:address)
        a.postalAddresses = [workAddress]
        
        addContactViewController = CNContactViewController.init(forUnknownContact: a) // iOS Editor
        addContactViewController.delegate = self
        addContactViewController.contactStore = CNContactStore()
        viewContact.addSubview(addContactViewController.view)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addContactViewController.view.frame = self.viewContact.bounds
    }
    
    @IBAction func onCloseButton(_ sender: Any?){
        self.dismiss(animated: true, completion: nil)
    }
}
