//
//  CircularProgressView.swift
//  ZoeBluePrint
//
//  Created by iOS Training on 03/03/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class CircularProgressView: UIView {

    
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCircularPath()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createCircularPath()
        
    }
    
    // Now for Selecting Color :
    
    var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
            
        }
    }
    var trackColor = UIColor.white {
           didSet {
               trackLayer.strokeColor = trackColor.cgColor
               
           }
       }

    fileprivate func createCircularPath() {
        
        
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x:frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        // * arc centre should be at the centre of the circle : arcCenter
        
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 12.0
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
        
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 12.0
        progressLayer.strokeEnd = 1.0
        layer.addSublayer(progressLayer)
        
       
    }
    
    func setProfileWithAnimation(duration:TimeInterval, Value: Float) {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = duration
        animation.fromValue = 0.0
        animation.toValue = Value
        animation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(Value)
        progressLayer.add(animation, forKey: "progressAnimate")
        
        
    }
}
