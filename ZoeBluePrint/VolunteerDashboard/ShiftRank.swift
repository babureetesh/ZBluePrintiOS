//
//  ShiftRank.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 13/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class ShiftRank: UIViewController {

    var data1: Dictionary<String,Any>!
    
    
    
    
    @IBOutlet weak var whiteStar: FloatRatingView!
    
    
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var btnbackTap: UIButton!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var StatusName: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var VolunteerRequestedLabel: UILabel!
    @IBOutlet weak var ShiftDateLabel: UILabel!
    @IBOutlet weak var ShiftTimeLabel: UILabel!
    
    @IBOutlet weak var RatingRank: FloatRatingView!
    @IBOutlet weak var shiftRank: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
//    var shiftdata = [String:Any]()
//    var shiftDetails = [String:Any]()
    
    @IBOutlet weak var coverpic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //print(data1)
        
        self.setValues()
        
      }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getCoverImageForRank()
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//        if defaults == "Dark Mode"{
//            DarkMode()
//
//        }else if defaults == "Light Mode"{
//            LightMode()
//        }
         let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                            let userID = userIDData["user_id"] as! String
                                          //print(userID)
                            
                           let string_url = userIDData["user_profile_pic"] as! String
        
      //  if  defaults == "Light Mode"{
                            var headingName = userIDData["user_f_name"] as! String
                               headingName = "\(headingName)'S DASHBOARD"
//                               self.lblHeadingName.textColor = .black
//                               lblHeadingName.text = headingName.uppercased()
       // }else if defaults == "Dark Mode"{
            
            //var headingName = userIDData["user_f_name"] as! String
          //  headingName = "\(headingName)'S BOOKING"
        //self.lblHeadingName.textColor = .white
        //    lblHeadingName.text = headingName.uppercased()
      //  }
        
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
              
          }

    func DarkMode(){
    
        view.backgroundColor = .black
        self.TitleLabel.textColor = .blue
        self.VolunteerRequestedLabel.textColor = .white
        self.ShiftDateLabel.textColor = .white
        self.ShiftTimeLabel.textColor = .white
        self.btnbackTap.setImage(UIImage(named: "iphoneButton.png"), for: UIControl.State.normal)
        self.btnList.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        
    }
    
    func LightMode(){
        
         view.backgroundColor = .white
        self.TitleLabel.textColor = .blue
        self.VolunteerRequestedLabel.textColor = .black
        self.ShiftDateLabel.textColor = .black
        self.ShiftTimeLabel.textColor = .black
        self.btnList.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
        self.btnbackTap.setImage(UIImage(named: "iphoneBackButton.png"), for: UIControl.State.normal)
    }
    
    
    
@IBAction func ListButtonTapped(_ sender: Any) {
    
    
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
            self.coverpic.image = UIImage(named:strImageNameCover)
            
            
        }
    
    
    @IBAction func backButto(_ sender: Any) {
        
    dismiss(animated: true, completion: nil)
    }
    

    
  
    
    func setValues(){
//        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//        if defaults == "Dark Mode"{
//
//            self.whiteStar.rating = Double(data1!["shift_rank"] as! String) ?? 0.0
//            self.whiteStar.isHidden = false
//            self.RatingRank.isHidden = true
//
//        }else if defaults == "Light Mode"{
//
            self.RatingRank.rating = Double(data1!["shift_rank"] as! String) ?? 0.0
            self.whiteStar.isHidden = true
            self.RatingRank.isHidden = false
       // }
        RatingRank.isUserInteractionEnabled = false
        whiteStar.isUserInteractionEnabled = false
       
        
        self.TitleLabel.text = data1["shift_task_name"] as! String
        self.VolunteerRequestedLabel.text = data1["shift_vol_req"] as! String
        self.ShiftDateLabel.text = data1["shift_date"] as! String
        
        
        var Start_time = data1["shift_start_time"] as! String
        var End_time = data1["shift_end_time"] as! String
        var Time = "\(Start_time) - \(End_time)"
        //print(Time)
        self.ShiftTimeLabel.text = Time as! String
        
      var changeRate = data1["volunteer_apply"] as! String
       ////print(changeRate)
       if changeRate == "1"{
        self.ImageView.image = UIImage(named: "complete-verified.png")
           
        self.StatusName.text = "Applied"
        self.StatusName.textColor = UIColor.gray

       }else
           if changeRate == "0"{
            self.ImageView.image = UIImage(named: "csoavailable.png")
         
        self.StatusName.text = "Available"
               self.StatusName.textColor = UIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 1.0)
//
       }
        
    }
    @IBAction func BellButton(_ sender: Any) {
        
    let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "notify") as! VolunteerNotificationViewController
               self.present(obj, animated: true)
    
    }
    
    
}
