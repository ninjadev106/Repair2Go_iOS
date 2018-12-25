//
//  TouchTestVC.swift
//  Repair2Go
//
//  Created by mobile on 12/24/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class TouchTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(drawRectangular))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func drawRectangular(_ tapper: UITapGestureRecognizer) {
        let tapLocation = tapper.location(in: tapper.view)
        let layer = CAShapeLayer()
        layer.position = tapLocation
        layer.backgroundColor = UIColor.green.cgColor
        layer.bounds = CGRect(x: tapLocation.x, y: tapLocation.y, width: 20, height: 20)
        self.view.layer.addSublayer(layer)
        
//        CALayer *newLayer = [CALayer layer];
//        layer.bounds = layerBounds;
//        layer.position = [gesture locationInView:gesture.view];
//        layer.backgroundColor = layerBackgroundColor;
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
