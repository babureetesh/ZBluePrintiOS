//
//  AppDelegate.swift
//  ZoeBlueprint
//
//  Created by Reetesh Bajpai on 03/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import SendBirdSDK // Sendbird
import IQKeyboardManagerSwift
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coverPicImagearray = Array<Any>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SBDMain.initWithApplicationId("F46FE267-AE82-45B2-9F44-0BD7266FCFDE")
         IQKeyboardManager.shared.enable = true
       
        UITabBar.appearance().barTintColor = .white
       UITabBar.appearance().tintColor = .black

        
         coverPicImagearray = ["cover_riseandshine.jpg", "cover_cake.jpg", "cover_cool.jpg", "cover_truck.jpg","cover_cloud.jpg"]
          UserDefaults.standard.set(coverPicImagearray.randomElement(), forKey: "csocoverpic")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print(coverPicImagearray.randomElement()!)
        UserDefaults.standard.set(coverPicImagearray.randomElement(), forKey: "csocoverpic") //setObject
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

