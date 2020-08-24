//
//  MyTabBarControllerViewController.swift
//  ZoeBluePrint
//
//  Created by HashTag Labs on 29/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class MyTabBarControllerViewController: UITabBarController {

   override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    let lineView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 3))
    lineView.backgroundColor = UIColor.lightGray
    self.tabBar.addSubview(lineView)
    
        }

}
