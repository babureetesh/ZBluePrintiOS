//
//  VolRightMenuOption.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 22/12/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolRightMenuOption: UIViewController {

    
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var coverPicture: UIImageView!
    @IBOutlet weak var lblnames: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var btlTimezone: UILabel!
    @IBOutlet weak var imageEditProfile: UIImageView!
    @IBOutlet weak var btnEditProfilePressed: UIButton!
    @IBOutlet weak var imageTimeZone: UIImageView!
    @IBOutlet weak var brtnTimeZone: UIButton!
    @IBOutlet weak var imageSetting: UIImageView!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var imageChangePassword: UIImageView!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var imageLogout: UIImageView!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//        if defaults == "Dark Mode"{
//            
//            DarkMode()
//            
//        }else if defaults == "Light Mode"{
//            
//            LightMode()
//            
//            
//        }
        
       let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
               let params = userIDData["user_id"] as! String
        print(params)
        
               var timeZone =  userIDData["user_timezone"] as! String ?? ""
        print(timeZone)
             //  self.btlTimezone.text = timeZone
       
               
               let serivehandler = ServiceHandlers()
               serivehandler.editProfile(user_id: params){(responce,isSuccess) in
                   if isSuccess{
                       let data = responce as! Dictionary<String,Any>
                       
                       var firstname = data["user_f_name"] as! String
                       var lastname = data["user_l_name"] as! String
                       var names = "\(firstname) \(lastname)"
                       //print(names)
                    
                    self.lblnames.text = names.uppercased()
                    print(names.uppercased())
                       
                       
                       let string_url = data["user_profile_pic"] as! String
                       
                       if let url = URL(string: string_url){
                                      do {
                                        //  let profile_data = try Data(contentsOf: profile_url as URL)
                                          let imageData = try Data(contentsOf: url as URL)
                                          //self.coverPicture.image = UIImage(data: profile_data)
                                          self.profilePicture.image = UIImage(data: imageData)
                                          self.profilePicture.layer.borderWidth = 1
                                          self.profilePicture.layer.masksToBounds = false
                                          self.profilePicture.layer.borderColor = UIColor.black.cgColor
                                          self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height/2
                                          self.profilePicture.clipsToBounds = true
                                      } catch {
                                          //print("Unable to load data: \(error)")
                                      }
                                      }
                                      
                                       let profile_pic_string = data["user_cover_pic"] as! String
                                      if let profile_url = URL(string: profile_pic_string){
                                          do {
                                              let profile_data = try Data(contentsOf: profile_url as URL)
                                             self.coverPicture.image = UIImage(data: profile_data)
                                              
                                          } catch {
                                              //print("Unable to load data: \(error)")
                                          }
                                      }
                   }
               }

     
     }
  @IBAction func editProfile(_ sender: Any) {
      
    let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
             let change_timezone_view  = sampleStoryBoard.instantiateViewController(withIdentifier: "volreg") as! VolRegistration
             change_timezone_view.screen = "EDIT VIEW"
             self.present(change_timezone_view, animated: true, completion: nil)
    
    }
    @IBAction func timeZoneChange(_ sender: Any) {
        
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let change_timezone_view  = sampleStoryBoard.instantiateViewController(withIdentifier: "changetimezonecso") as! ChangeTimezoneCSO
               self.present(change_timezone_view, animated: true, completion: nil)
        
        
    }
    @IBAction func volSettings(_ sender: Any) {
        
        let lang : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let changeLanguage  = lang.instantiateViewController(withIdentifier: "language") as! Language
        self.present(changeLanguage, animated: true, completion: nil)
        
        
        
    }
    @IBAction func logout(_ sender: Any) {
        
//       let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//
//
//        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.key_LoggedInUserData)
//        UserDefaults.standard.synchronize()
//
//        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
//            //print("\(key) = \(value) \n")
//        }
//        let sb :UIStoryboard =  UIStoryboard(name: "Main", bundle:nil)
//        let homeView  = sb.instantiateViewController(withIdentifier: "login") as! ViewController
//        self.present(homeView, animated: true, completion: nil)
         UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "login")
        
    }
    
    
    @IBAction func volChangePassword(_ sender: Any) {
      
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let password  = storyboard.instantiateViewController(withIdentifier: "changepasswordcso") as! ChangePasswordCSO
        self.present(password, animated: true, completion: nil)
}
    
    @IBAction func showOrganization(_ sender: Any) {
//let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//       let org  = storyboard.instantiateViewController(withIdentifier: "organization") as! OrganizationViewController
//       self.present(org, animated: true, completion: nil)
        
      //  let vc = self.tabBarController?.viewControllers?[1] as! NewVolunteerDashboard
               //vc.strFromScreen = "DASHBOARD"
                //self.tabBarController?.selectedIndex = 0
        
        NotificationCenter.default.post(name: Notification.Name("showorg"), object: nil)
       dismiss(animated: true, completion: nil)
        
      
    }
    
    func DarkMode(){
        
        self.view.backgroundColor = .black
        self.btnLogout.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageLogout.image = UIImage(named: "lightlogout.png")
         self.btnSetting.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageSetting.image = UIImage(named: "lightnewSettings.png")
         self.btnChangePassword.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageChangePassword.image = UIImage(named: "lightPassword.png")
         self.btnEditProfilePressed.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageEditProfile.image = UIImage(named: "lightedit_user.png")
         self.brtnTimeZone.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageTimeZone.image = UIImage(named: "lightTime.png")
//        self.view.backgroundColor = .black
        self.mainView.backgroundColor = .black

        
        
    }
    func LightMode(){
        
        self.btnLogout.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnSetting.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnChangePassword.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnEditProfilePressed.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.brtnTimeZone.setTitleColor(UIColor.black, for: UIControl.State.normal)
         self.view.backgroundColor = .white
        self.mainView.backgroundColor = .white
//
    }

   
    
}
