//
//  MyTabBarControllerViewController.swift
//  ZoeBluePrint
//
//  Created by HashTag Labs on 29/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class MyTabBarControllerViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 3))
        lineView.backgroundColor = UIColor.lightGray
        self.tabBar.addSubview(lineView)
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let controllers =  self.viewControllers {
            if controllers.count > selectedIndex{
                if let navController = controllers[selectedIndex] as? UINavigationController {
                    navController.popToRootViewController(animated: false)
                }
            }
        }
        
    }
    
    // UITabBarControllerDelegate
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }
    
    
}
