//
//  DynamicLabelSize.swift
//  ZoeBluePrint
//
//  Created by iOS Training on 05/03/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class DynamicLabelSize: UIView {

    static func height(text:String?, font:UIFont, width:CGFloat ) -> CGFloat{
        var currentHeight : CGFloat!
        
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        lable.font = font
        lable.text = text
        lable.sizeToFit()
        lable.lineBreakMode = .byWordWrapping
        
        currentHeight = lable.frame.height
        lable.removeFromSuperview()
        
        return currentHeight
        
    }
}
