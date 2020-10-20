//
//  CSOTabViewController.swift
//  ZoeBluePrint
//
//  Created by Rishi Chaurasia on 20/10/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class CSOTabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
