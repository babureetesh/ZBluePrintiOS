//
//  Volunteer Targets.swift
//  ZoeBluePrint
//
//  Created by iOS Training on 02/03/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class Volunteer_Targets: UIViewController {

    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var lblVolHours:UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblHeadingName: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var lblTotalHours: UILabel!
    
    @IBOutlet weak var lblBlankLine: UILabel!
    @IBOutlet weak var lblTargetRequired: UILabel!
    @IBOutlet weak var lblCurrentHours: UILabel!

    @IBOutlet weak var imgViewCoverPic: UIImageView!
    @IBOutlet weak var CircluarProgress: CircularProgressView!
    
    var Target : [[String:Any]]!
    var TargetPercentage:Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // For CircularView:
    CircluarProgress.progressColor = UIColor(red: 208/255.0 , green:25/255.0 , blue: 89/255.0, alpha: 1.0)
    CircluarProgress.trackColor = UIColor(red: 238/255.0, green: 185/255.0, blue: 203/255.0, alpha: 1.0)
        CircluarProgress.tag = 101
       // self.perform(#selector(progressAnimate),with: nil, afterDelay: 2.0)
        
        
      let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
               let param = userIDData["user_id"] as! String
               print(param)
               
                 let serviceHanlder = ServiceHandlers()
        serviceHanlder.VolTargets(user_id : param) { (responce, isSuccess) in
             if isSuccess {
                
                var TargetData = responce as! Array<Any>
                self.Target = TargetData as? [[String:Any]]
                print(self.Target)

                for data in self.Target {
                    
                    let dataTarget = data as! [String:Any]
                    
                    var current_hours = dataTarget["vol_hours"] as! String
                    print(current_hours)
//                    let cHours = current_hours
//                    print(cHours)
                    var strtoPrint = "Volunteers Hours Current \(dataTarget["vol_hours"] as! String) | Target \(dataTarget["vol_hours_req"] as! String)"
                    self.lblCurrentHours.text = strtoPrint
                    //Volunteers HRS Current | Target 100
                    var vol_hours_req = dataTarget["vol_hours_req"] as! String
                    //print(vol_hours_req)
                    //var Target = "Target \(vol_hours_req)"
                    //print(Target)
                    //self.lblTargetRequired.text = Target
                    
                    self.TargetPercentage = (Float(current_hours)!)/(Float(vol_hours_req)!) * 100
                    print(self.TargetPercentage)
                    
                    var Percentage:Int = Int(self.TargetPercentage)
                    print(Percentage)
                   
                    var totalPercentage:String = String(Percentage)
                    print(totalPercentage)
                    
                    self.lblTotalHours.text = totalPercentage + "%"
                    
                    self.progressAnimate()
                
             }
          }
       }
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.getCoverImageForRank()
         let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let userID = userIDData["user_id"] as! String
                      //print(userID)
        
        let string_url = userIDData["user_profile_pic"] as! String
        
//        if defaults == "Dark Mode"{
//        var headingName = userIDData["user_f_name"] as! String
//                headingName = "\(headingName)'S TARGET"
//                print(headingName)
//            self.lblHeadingName.textColor = .white
//                lblHeadingName.text = headingName.uppercased()
//
//        } else  if defaults == "Light Mode"{
            
            var headingName = userIDData["user_f_name"] as! String
            headingName = "\(headingName)'S TARGET"
            print(headingName)
           // self.lblHeadingName.textColor = .black
           // lblHeadingName.text = headingName.uppercased()
            
       // }
        if let url = URL(string: string_url){
        do {
          let imageData = try Data(contentsOf: url as URL)
            self.profilepic.image = UIImage(data: imageData)
            self.profilepic.layer.borderWidth = 1
            self.profilepic.layer.masksToBounds = false
            self.profilepic.layer.borderColor = UIColor.black.cgColor
            self.profilepic.layer.cornerRadius = self.profilepic.frame.height/2
            self.profilepic.clipsToBounds = true
        } catch {
            //print("Unable to load data: \(error)")
        }
        }
        
        
        
//        if defaults == "Dark Mode"{
//            
//            DarkMode()
//            
//        }else if defaults == "Light Mode"{
//            
//            LightMode()
//            
//        }
    }
    func getCoverImageForRank(){
          
          var strImageNameCover = "cover_cloud.jpg"
          
    let decoded  = UserDefaults.standard.object(forKey: "VolData") as! Data
              let volData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
              //print(volData)
              if (volData["user_avg_rank"] != nil){
                  if let userAvgRank = volData["user_avg_rank"] as? String {
                      
                     let floatUserAverageRank = Float(userAvgRank)!
                      
                         
                      if ((floatUserAverageRank >= 0) && (floatUserAverageRank <= 20)){
                          strImageNameCover = "cover_riseandshine.jpg"
                      }else if ((floatUserAverageRank > 20) && (floatUserAverageRank <= 40)){
                          strImageNameCover = "cover_cake.jpg"
                      }else if ((floatUserAverageRank > 40) && (floatUserAverageRank <= 60)){
                          strImageNameCover = "cover_cool.jpg"
                      }else if ((floatUserAverageRank > 60) && (floatUserAverageRank <= 80)){
                          strImageNameCover = "cover_truck.jpg"
                      }else if (floatUserAverageRank > 80 ){
                          strImageNameCover = "cover_cloud.jpg"
                      }
                     
                  }
              }
          self.imgViewCoverPic.image = UIImage(named:strImageNameCover)
          
          
      }


    
    func DarkMode() {
    
    self.lblTargetRequired.textColor = .white
        self.lblCurrentHours.textColor = .white
        self.view.backgroundColor = .black
        self.lblBlankLine.backgroundColor = .white
        self.lblVolHours.textColor = UIColor.white
        self.btnList.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        
    }
    
    func LightMode() {
        
        self.lblTargetRequired.textColor = .white
        self.lblCurrentHours.textColor = .white
        self.view.backgroundColor = .black
         self.lblBlankLine.backgroundColor = .black
        self.lblVolHours.textColor = UIColor.black
        self.btnList.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
    }
    
    
    @objc func progressAnimate() {
    
        let viewTag  = self.view.viewWithTag(101) as! CircularProgressView
        print(self.TargetPercentage/100)
        viewTag.setProfileWithAnimation(duration: 2.0, Value: self.TargetPercentage/100)

        
     }
    
    @IBAction func notificationBellTapped(_ sender: Any) {
           
           let sb = UIStoryboard(name: "Main", bundle: nil)
           let obj = sb.instantiateViewController(withIdentifier: "notify") as! VolunteerNotificationViewController
                  self.present(obj, animated: true)
       }
 }
