
//
//  AppointmentVC.swift
//  Repair2Go
//
//  Created by mobile on 1/1/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit
import MessageUI

class AppointmentVC: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet var textName: UITextField!
    @IBOutlet var textEmail: UITextField!
    @IBOutlet var textPhone: UITextField!
    @IBOutlet var textModel: UITextField!
    @IBOutlet var textDescription: UITextField!
    @IBOutlet var textDate: UITextField!
    @IBOutlet var buttonSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.buttonSend.layer.cornerRadius = self.buttonSend.frame.height/2
        self.buttonSend.clipsToBounds = true
        self.buttonSend.isEnabled = false
        self.buttonSend.backgroundColor = UIColor.gray
    }
    
    @IBAction func onTappedBtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTappedBtnSend(_ sender: Any) {
        
        /*
         Name: xxxx
         Phone: iPhone 6+
         Type/Model: iPhone 6+
         Description: xxxx
         Data: xxxx-xx-xx
        */
        
        if MFMailComposeViewController.canSendMail() {
            var message = "Name: " + self.textName.text!
            message += ("\nMail: " + self.textEmail.text!)
            message += ("\nPhone: " + self.textPhone.text!)
            message += ("\nType/Model: " + self.textModel.text!)
            message += ("\nDescription: " + self.textDescription.text!)
            message += ("\nDate: " + self.textDate.text!)

            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@repair2go.nl"])
            mail.setMessageBody(message, isHTML: false)
            mail.setSubject("Repair request")
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
        
        
        /*
        let session = MCOSMTPSession.init()
        session.hostname = "smtp.gmail.com"
        session.port = 465
        session.username = "xxx@gmail.com"
        session.password = "xxx"
        session.authType = MCOAuthType.saslPlain
        session.connectionType = MCOConnectionType.TLS
        session.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "Rool", mailbox: "thanglvan@gmail.com")]
        builder.header.from = MCOAddress(displayName: self.textName.text, mailbox: "lnoslr106@yandex.com")
        builder.header.cc = [MCOAddress(displayName: "Matt R", mailbox: "lnoslr106@yandex.com")]
        builder.header.subject = "My message"
        builder.htmlBody = "Yo Rool, this is a test message!"
        
        let rfc822Data = builder.data()
        let sendOperation = session.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(error)")
            } else {
                NSLog("Successfully sent email!")
            }
        }
        */
        
    }
    
    func onTextChanged() {
        if textName.text?.isEmpty ?? true {
            self.buttonSend.isEnabled = false
            self.buttonSend.backgroundColor = UIColor.gray
            return
        }
        
        if textEmail.text?.isEmpty ?? true {
            self.buttonSend.isEnabled = false
            self.buttonSend.backgroundColor = UIColor.gray
            return
        }

        if textPhone.text?.isEmpty ?? true {
            self.buttonSend.isEnabled = false
            self.buttonSend.backgroundColor = UIColor.gray
            return
        }

        if textModel.text?.isEmpty ?? true {
            self.buttonSend.isEnabled = false
            self.buttonSend.backgroundColor = UIColor.gray
            return
        }
        
        if textDescription.text?.isEmpty ?? true {
            self.buttonSend.isEnabled = false
            self.buttonSend.backgroundColor = UIColor.gray
            return
        }
        
        if textDate.text?.isEmpty ?? true {
            self.buttonSend.isEnabled = false
            self.buttonSend.backgroundColor = UIColor.gray
            return
        }
        
        self.buttonSend.isEnabled = true
        self.buttonSend.backgroundColor = UIColor(red: 43.0/255, green: 174.0/255, blue: 1, alpha: 1.0)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        onTextChanged()
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            if result == MFMailComposeResult.sent {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
