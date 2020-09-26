//
//  VolunteerRightMenuViewController.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 23/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolunteerRightMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
              let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
              let strTimeZone = userIDData["user_timezone"] as! String
              
//             self.TimeZonePressed.setTitle(strTimeZone, for: .normal)
    }
    
    @IBAction func logout(_ sender: Any) {
        
//        let domain = Bundle.main.bundleIdentifier!
//               UserDefaults.standard.removePersistentDomain(forName: domain)
//
//
//               UserDefaults.standard.removeObject(forKey: UserDefaultKeys.key_LoggedInUserData)
//               UserDefaults.standard.synchronize()
//
//               for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
//                   //print("\(key) = \(value) \n")
//               }
//               let sb :UIStoryboard =  UIStoryboard(name: "Main", bundle:nil)
//               let homeView  = sb.instantiateViewController(withIdentifier: "login") as! ViewController
//               self.present(homeView, animated: true, completion: nil)
        
//        UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "login")
        
//        let sb :UIStoryboard =  UIStoryboard(name: "Main", bundle:nil)
//               let newViewController = sb.instantiateViewController(withIdentifier: "login")
//
//               self.dismiss(animated: true) { () -> Void in
//                   //Perform segue or push some view with your code
//                   UIApplication.shared.keyWindow?.rootViewController = newViewController
//             }
        self.tabBarController?.view.removeFromSuperview()
       //  UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "login")
               
    }
    
 @IBAction func Password(_ sender: Any) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let password  = storyboard.instantiateViewController(withIdentifier: "changepasswordcso") as! ChangePasswordCSO
        self.present(password, animated: true, completion: nil)
}
    

    @IBAction func Setting(_ sender: Any) {
        
        
    }
    
    @IBAction func Timezone(_ sender: Any) {
        
        
    }
  @IBAction func EditProfile(_ sender: Any) {
    
    
    }
}
