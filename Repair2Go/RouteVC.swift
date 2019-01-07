//
//  RouteVC.swift
//  Repair2Go
//
//  Created by Le Van Thang on 1/7/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit
import WebKit

class RouteVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        self.webView.navigationDelegate = self
        
        let originalString = "https://www.google.com/maps/place/Repair2Go,+Nørregade+54C,+7500+Holstebro,+Denmark/@56.3619169,8.6191796,16z/data=!4m2!3m1!1s0x464bcdd1403a195d:0x4bd2784d774102d8"
        if let encoded = originalString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: encoded)
        {
            //print(url)
            webView.load(URLRequest.init(url: url))
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @IBAction func onCloseButton(_ sender: Any?){
        self.dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Stop activity
        self.activityIndicator.stopAnimating()
    }
}
