//
//  TouchTestView.swift
//  Repair2Go
//
//  Created by Le Van Thang on 1/7/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit

class TouchTestView: UIView {
    private let space = 2
    private let cols = 10
    private var rows = 25
    private var w = CGFloat(40)
    private var h = CGFloat(40)
    
    private var fillInRect: [Bool] = []
    
    override func awakeFromNib() {
        for _ in 0..<rows {
            for _ in 0..<cols {
                fillInRect.append(false)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let pt = event?.allTouches?.first?.location(in: self){
            let c = Int(pt.x / (w + CGFloat(space)))
            let r = Int(pt.y / (h + CGFloat(space)))
            
            if !fillInRect[r*cols + c] {
                fillInRect[r*cols + c] = true
                self.setNeedsDisplay()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let pt = event?.allTouches?.first?.location(in: self){
            let c = Int(pt.x / (w + CGFloat(space)))
            let r = Int(pt.y / (h + CGFloat(space)))
            
            if !fillInRect[r*cols + c] {
                fillInRect[r*cols + c] = true
                self.setNeedsDisplay()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        w = (self.frame.width - CGFloat((cols - 1)*space))/CGFloat(cols)
        rows = Int(self.frame.height/w)
        h = (self.frame.height - CGFloat((rows - 1)*space))/CGFloat(rows)

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.green.cgColor)
        
        var rects: [CGRect] = []
        
        for row in 0..<rows {
            for col in 0..<cols {
                //context?.move(to: CGPoint(x: (CGFloat(col)*w + CGFloat(col*space)), y: (CGFloat(row)*h) + CGFloat(row*space)))
                
                if fillInRect[row*cols + col] {
                let r = CGRect(x: (CGFloat(col)*w + CGFloat(col*space)), y: (CGFloat(row)*h) + CGFloat(row*space), width: w, height: h)
                
                rects.append(r)
                }
            }
        }
        
        context?.fill(rects)
    }
}
