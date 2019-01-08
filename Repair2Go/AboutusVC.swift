//
//  AboutusVC.swift
//  Repair2Go
//
//  Created by mobile on 1/7/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit

class AboutusVC: UIViewController {
    @IBOutlet weak var imgLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgLogo.layer.cornerRadius = imgLogo.bounds.height / 2
        imgLogo.layer.masksToBounds = true
    }
    
    @IBAction func onTappedBtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTappedBtnWebsite(_ sender: Any) {
        guard let url = URL(string: "https://www.repair2go.nl") else { return }
        UIApplication.shared.open(url)
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
