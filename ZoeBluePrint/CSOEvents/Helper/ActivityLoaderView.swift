//
//  ActivityLoaderView.swift
//  ZoeBlue//print
//
//  Created by Reetesh Bajpaion 15/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

let Backgroud_Color = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.6)

let ACTIVITY_LOADER_TAG = 99
let ROTATION_KEY = "transform.rotation"

class ActivityLoaderView: UIView {
    
    static let sharedInstance:ActivityLoaderView = {
        let instance = ActivityLoaderView()
        return instance
    }()
    
    var image : UIImageView?
    var activityView: UIActivityIndicatorView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func rotate() {
        self.image?.layer.removeAnimation(forKey: ROTATION_KEY)
        let rotationAnimation = CABasicAnimation(keyPath: ROTATION_KEY)
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2 //Minus can be Direction
        rotationAnimation.duration = 2.0
        rotationAnimation.repeatCount = .infinity
        self.image?.layer.add(rotationAnimation, forKey: nil)
    }
    
    fileprivate  func loadActivityLoader(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.addSubview(self)
        appDelegate.window?.bringSubviewToFront(self)
    }
    
    fileprivate func configureView() {
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        self.frame =  (appDelagate.window?.frame)!
        self.backgroundColor = Backgroud_Color
//        image = UIImageView(frame: CGRect(x: self.bounds.size.width/2, y: self.bounds.size.height/2, width: 48.0, height: 55.0))
//        image?.image = UIImage(named: "loading-large-icon")
//        self.addSubview(image!)
//        image?.frame.origin = CGPoint(x: self.bounds.size.width/2 - (image?.bounds.size.width)!/2, y: self.bounds.size.height/2 - (image?.bounds.size.height)!)
         activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView!.center = self.center
        self.addSubview(activityView!)
        activityView!.startAnimating()
        
        self.tag = ACTIVITY_LOADER_TAG
    }
    class func startAnimating() {
        let loader = ActivityLoaderView.sharedInstance
        if loader.superview == nil {
            loader.loadActivityLoader()
        }
        //loader.rotate()
        loader.accessibilityIdentifier = "App based Activity Loader"
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        if let window = UIApplication.shared.keyWindow {
            window.windowLevel = UIWindow.Level.statusBar+1
        }
    }
    
    class func stopAnimating() {
        let loader = ActivityLoaderView.sharedInstance
        loader.image?.layer.removeAnimation(forKey: ROTATION_KEY)
        loader.image?.stopAnimating()
//        if let window = UIApplication.shared.keyWindow {
//            window.windowLevel = UIWindow.Level.statusBar - 1
//        }
        if loader.superview != nil {
            loader.removeFromSuperview()
        }
    }
}
