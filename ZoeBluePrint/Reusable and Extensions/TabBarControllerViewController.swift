//
//  TabBarControllerViewController.swift
//  ZoeBluePrint
//
//  Created by HashTag Labs on 22/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class TabBarControllerViewController: UITabBarController {

    let defaults = UserDefaults.standard.string(forKey: "ChnageTheme")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        
        if defaults == "Dark Mode"{
            
           tabBar.barTintColor = .black
            tabBar.unselectedItemTintColor = .gray
            tabBar.tintColor = .black
            
        }else if defaults == "Light Mode"{
            
             tabBar.barTintColor = .white
            
        }
    }

   

}
