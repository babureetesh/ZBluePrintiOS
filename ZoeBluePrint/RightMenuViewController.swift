//
//  RightMenuViewController.swift
//  ZoeBlue//print
//
//  Created by Reetesh Bajpai on 02/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//
//https://github.com/jonkykong/SideMenu

// CSO SIDE MENU
import UIKit

class RightMenuViewController: UIViewController{

    
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnTimeZone: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var coverPicture: UIImageView!
    @IBOutlet weak var zonePressed: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var lblnames: UILabel!
    
    
    @IBOutlet weak var imageEdit: UIImageView!
    @IBOutlet weak var imageTimeZone: UIImageView!
    @IBOutlet weak var imageSetting: UIImageView!
    @IBOutlet weak var imageLogout: UIImageView!
    @IBOutlet weak var imagePassword: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
//        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
//        let params = userIDData["user_id"] as! String
//        print(params)
        
        let timeZone =  UserDefaults.standard.object(forKey: UserDefaultKeys.key_userTimeZone) as! String
        print(timeZone)
        self.zonePressed.setTitle(timeZone, for: UIControl.State.normal)
        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
//        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
//        let strTimeZone = userIDData["user_timezone"] as! String ?? ""
//        print(strTimeZone)
//        self.zonePressed.setTitle(strTimeZone, for: .normal)
//
        
        
//        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//        if defaults == "Dark Mode"{
//
//            DarkMode()
//        }else if defaults == "Light Mode" {
//             LightMode()
//        }
        
        
        
        self.profile_pic()
        

    }
   
    func DarkMode() {
    
        view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
       
        btnEditProfile.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imageEdit.image = UIImage(named: "lightedit_user.png")
        btnEditProfile.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)    //1
        
        btnTimeZone.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imageTimeZone.image = UIImage(named: "lightTime.png")
        btnTimeZone.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)    //2
        
        btnSetting.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imageSetting.image = UIImage(named: "lightnewSettings.png")
        btnSetting.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)    //3
        
        btnChangePassword.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imagePassword.image = UIImage(named: "lightPassword.png")
        btnChangePassword.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)    //4
        
        btnLogout.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imageLogout.image = UIImage(named: "lightlogout.png")
        btnLogout.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)    //5
        
    }
    
    func LightMode() {
    
          view.backgroundColor = .white
    }
    
        func profile_pic()  {
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            let params = userIDData["user_id"] as! String
            let serivehandler = ServiceHandlers()
            serivehandler.editProfile(user_id: params){(responce,isSuccess) in
                if isSuccess{
                    let data = responce as! Dictionary<String,Any>
                    let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//                    if defaults == "Dark Mode"{
//
//                        self.lblnames.textColor = .white
//                    }else{
//
                        self.lblnames.textColor = .black
                    //}
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
                           // let profile_data = try Data(contentsOf: profile_url as URL)
                          // self.coverPicture.image = UIImage(data: profile_data)
                            
                        } catch {
                            //print("Unable to load data: \(error)")
                        }
                    }
                    
                }
            }
        }


    @IBAction func EditProfile(_ sender: Any) {
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let change_timezone_view  = sampleStoryBoard.instantiateViewController(withIdentifier: "CSORegistrationViewController") as! CSORegistration
        change_timezone_view.screen = "EDIT VIEW"
        self.present(change_timezone_view, animated: true, completion: nil)
    }
    
    @IBAction func TimeZone(_ sender: Any) {
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let change_timezone_view  = sampleStoryBoard.instantiateViewController(withIdentifier: "changetimezonecso") as! ChangeTimezoneCSO
        self.present(change_timezone_view, animated: true, completion: nil)
    }
    
    @IBAction func TimeZoneEDT(_ sender: Any) {
        
        
    }

    @IBAction func Setting(_ sender: Any) {
        
        let lang : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let changeLanguage  = lang.instantiateViewController(withIdentifier: "language") as! Language
        self.present(changeLanguage, animated: true, completion: nil)
    }
    

    @IBAction func ChangePassword(_ sender: Any) {
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let change_password_view  = sampleStoryBoard.instantiateViewController(withIdentifier: "changepasswordcso") as! ChangePasswordCSO
        self.present(change_password_view, animated: true, completion: nil)
        
    }
    
    @IBAction func Logout(_ sender: Any) {
        //UserDefaults.standard.removeObject(forKey: UserDefaultKeys.key_LoggedInUserData)
               UserDefaults.standard.synchronize()
       // self.dismiss(animated: false, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("Removetabbar"), object: nil)

         UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "login")
       
  }
}
