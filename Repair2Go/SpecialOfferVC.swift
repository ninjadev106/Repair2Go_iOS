//
//  SpecialOfferVC.swift
//  Repair2Go
//
//  Created by mobile on 1/7/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseUI
import SDWebImage

class SpecialOfferVC: UIViewController {
    @IBOutlet weak var imgSpecialOffer: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadImageFromFirebaseStorage()
        
    }
    
    @IBAction func onTappedBtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func downloadImageFromFirebaseStorage(){
        
        activityIndicator.startAnimating()
        
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        // Create a child reference
        // imagesRef now points to "images"
//        let imagesRef = storageRef.child("Images")
        
        // Child references can also take paths delimited by '/'
        // spaceRef now points to "images/space.jpg"
        // imagesRef still points to "images"
        let specialImagesRef = storageRef.child("Images/IMG_0014.PNG")
        
//        specialImagesRef.downloadURL { (url, err) in
//
//            if (err != nil) { print (err) }
//            else {
//                let imageView: UIImageView = self.imgSpecialOffer
//                let placeholderImage = UIImage(named: "placeholder.jpg")
//                imageView.sd_setImage(with: url, completed: { (img, err, cache, urrl) in
//                    print (err)
//                })
//
//            }
//
//        }
        
        print("Path: \(specialImagesRef)")

        // UIImageView in your ViewController
        let imageView: UIImageView = self.imgSpecialOffer

        // Placeholder image
        let placeholderImage = UIImage(named: "placeholder.jpg")

        // Load the image using SDWebImage
        imageView.sd_setImage(with: specialImagesRef, placeholderImage: placeholderImage) { (img, err, cache, ref) in
            self.activityIndicator.stopAnimating()
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
