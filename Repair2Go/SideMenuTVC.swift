//
//  SideMenuTVC.swift
//  Repair2Go
//
//  Created by mobile on 12/23/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import SideMenu

enum TargetScreen: Int {
    case spec_offer
    case addcontacts
    case aboutus
    case route
    case openhours
    case appointment
}

class SideMenuTVC: UITableViewController {
    
    let menulist = ["Special offer!", "Add to contacts", "About us", "Route", "Opening hours", "Create Appointment", "Privacy"]
    let thumbList = ["spec_offer", "addcontacts", "aboutus", "route", "openhours", "calendar", ""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        setupCustomUI()
        
    }
    
    func setupCustomUI() {
        
        let menuLogo =  UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 22))
        menuLogo.image = UIImage(named: "repair2go_logo.png")
        menuLogo.contentMode = .scaleAspectFit
        self.navigationItem.titleView = menuLogo
        
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "ED2728")
        
        SideMenuManager.defaultManager.menuPresentMode = .menuSlideIn
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menulist.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell

        cell.lblMenu.text = menulist[indexPath.row]
        cell.ivMenu.image = UIImage(named: thumbList[indexPath.row])
        cell.selectionStyle = .none

        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let parent = self.presentingViewController as? UINavigationController {
            dismiss(animated: false) {
                if let homeController = parent.viewControllers.first as? HomeVC {
                    homeController.displayMenuItemScreen(TargetScreen(rawValue: indexPath.row)!)
                }
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
