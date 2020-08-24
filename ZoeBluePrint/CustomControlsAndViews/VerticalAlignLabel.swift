//
//  VerticalAlignLabel.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 20/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VerticalAlignLabel: UILabel{
override func drawText(in rect: CGRect) {
    var newRect = rect
    switch contentMode {
    case .top:
        newRect.size.height = sizeThatFits(rect.size).height
    case .bottom:
        let height = sizeThatFits(rect.size).height
        newRect.origin.y += rect.size.height - height
        newRect.size.height = height
    default:
        ()
    }
    
    super.drawText(in: newRect)
}
}
