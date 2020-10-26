////
//  ChangeTimezoneCSO.swift
//  ZoeBlue//print
//
//  Created by Reetesh Bajpai on 06/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class ChangeTimezoneCSO: UIViewController {
    
    @IBOutlet weak var btnTimeZone: UIButton!
    @IBOutlet weak var imgViewCsoCover: UIImageView!
    @IBOutlet weak var imageTime: UIImageView!
    
    @IBOutlet weak var imgCoverPic: UIImageView!
    @IBOutlet weak var imageDay: UIImageView!
    
    
    @IBOutlet weak var imgProfilepic: UIImageView!
    @IBOutlet weak var lblSelectTimeZone: UILabel!
    @IBOutlet weak var lblSelectDayLight: UILabel!
    @IBOutlet weak var lblTimezone: UILabel!
    
    @IBOutlet weak var btnMenuCso: UIButton!
    @IBOutlet weak var btnMenuVol: UIButton!
    var screen:String!
    var timezoneID:String?
    var dayLightID:String?
    var listTimeZone: [[String:Any]]!
    @IBOutlet weak var dayLightButton: UIButton!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Reetesh 16 jan
        let utility = Utility()
        utility.fetchTimeZone { (eventTypeList, isValueFetched) in
            if let list = eventTypeList {
                // self.showPopoverForView(view: sender, contents: list)
                //print(list)
                self.listTimeZone = list
              self.setDataToView()
            }
        } // Reetesh 16 jan
        btnTimeZone.setDropDownImagWithInset()
               dayLightButton.setDropDownImagWithInset()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.profile_pic()
        self.getCoverImageForRank()
        
    }
    
    func profile_pic()  {
           let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                      let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                      let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                      if let dirPath          = paths.first
                      {
                         let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
                          if let image    = UIImage(contentsOfFile: imageURL.path){
                                                  self.imgProfilepic.image = image
                                                    self.imgProfilepic.layer.borderWidth = 1
                                                    self.imgProfilepic.layer.masksToBounds = false
                                                    self.imgProfilepic.layer.borderColor = UIColor.black.cgColor
                                                    self.imgProfilepic.layer.cornerRadius = self.imgProfilepic.frame.height/2
                                                    self.imgProfilepic.clipsToBounds = true
                          }
                         // Do whatever you want with the image
                      }
           
       }





    func getCoverImageForRank(){
           
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                  let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                  let usertype = userIDData["user_type"] as! String
                  if (usertype == "CSO"){
                    self.btnMenuCso.isHidden = false
                    self.btnMenuVol.isHidden = true
                      self.imgCoverPic.image = UIImage(named:UserDefaults.standard.string(forKey: "csocoverpic")!)}else{
                    self.btnMenuCso.isHidden = true
                    self.btnMenuVol.isHidden = false
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
                        self.imgCoverPic.image = UIImage(named:strImageNameCover)
                    }
           
           
       }
    @IBAction func notifBellIconEvent(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
               let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
                 present(obj,animated: true)
        
    }
    
    func setDataToView(){
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let params = userIDData["user_id"] as! String
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.getUserTimeZone(user_id: params) { (responce, isSuccess) in
            if isSuccess {
                var data = responce as! Array<Any>
                var dict:Dictionary<String,Any> = data[0] as! Dictionary<String,Any>
                // Reetesh 16 jan
                
               self.dayLightID = dict["login_daylight"] as! String
               // self.timezoneID = dict["login_daylight"] as! String
                for zoneName in self.listTimeZone{
                    
                    var strZoneCode = zoneName["timezone_code"] as! String
                    var strZoneName = zoneName["timezone_name"] as! String
                    var ZoneChanged = "\(strZoneName) [\(strZoneCode)]"
                    
                    
                    if strZoneCode == dict["login_timezone"] as! String {
                        self.btnTimeZone.setTitle(ZoneChanged, for: .normal)
                        self.timezoneID = zoneName["timezone_code"] as! String //7th may
                    }
                }

                // Reetesh 16 jan
                if ((dict["login_daylight"] as! String) == "1"){
                    self.dayLightButton.setTitle(NSLocalizedString("ON", comment: ""), for: .normal) // Reetesh 16 jan
                }else{
                    self.dayLightButton.setTitle(NSLocalizedString("OFF", comment: ""), for: .normal) // Reetesh 16 jan
                }
                //print(dict)
                
            }
            
        }
    }
    @IBAction func back_button(_ sender: Any) {
        performSegueToReturnBack()
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectTimeZoneDropDown(_ sender: Any) {
        let utility = Utility()
        utility.fetchTimeZone { (eventTypeList, isValueFetched) in
            if let list = eventTypeList {
                self.showPopoverForView(view: sender, contents: list)
            }
        }
    }
    
    
    @IBAction func selectDayLightDropDown(_ sender: Any) {
        let list = [["day_status":NSLocalizedString("ON", comment: ""),"day_id":"1"],["day_status":NSLocalizedString("OFF", comment: ""),"day_id":"0"]]// Reetesh 16 jan
        self.showPopoverForView1(view: sender, contents: list)
        
    }
    
    
    
    @IBAction func btnSubmit(_ sender: Any) {
        if(validate()){
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            let userID = userIDData["user_id"] as! String
                
            let params = ["user_id":userID,
                          "login_timezone":self.timezoneID as! String,
                          "login_daylight":self.dayLightID as? String]
            print(params)
            let serviceHanlder = ServiceHandlers()
            serviceHanlder.updateTimeZone(data:params) { (responce, isSuccess) in
                if isSuccess {
                     UserDefaults.standard.set(self.timezoneID, forKey: UserDefaultKeys.key_userTimeZone)
                    let alert = UIAlertController(title: nil, message: NSLocalizedString("Time Zone Update Successfully", comment: ""), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
                        //run your function here
                       // self.dism()
                    }))
                    self.present(alert, animated: true)
                    self.setDataToView()
                }
                
                
            }
            
        }
        
    }
    
    
    func DarkMode(){
       
        
           view.backgroundColor = .black
        
        lblSelectTimeZone.textColor = UIColor.white
        
        
        lblSelectDayLight.textColor = UIColor.white
        lblTimezone.textColor = UIColor.white
        
        dayLightButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        dayLightButton.borderColor = .white
        dayLightButton.backgroundColor = .black
        
        btnTimeZone.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnTimeZone.borderColor = .white
        btnTimeZone.backgroundColor = .black

        imageDay.image = UIImage(named: "whitedrop.png")
        imageTime.image = UIImage(named: "whitedrop.png")
        
        
    }
    func LightMode(){
        
        view.backgroundColor = .white
        lblSelectTimeZone.textColor = UIColor.black
        lblSelectDayLight.textColor = UIColor.black
        
        btnTimeZone.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnTimeZone.borderColor = .black
        btnTimeZone.backgroundColor = .white

        
        
        lblTimezone.textColor = UIColor.black
        btnTimeZone.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnTimeZone.borderColor = .black
        btnTimeZone.backgroundColor = .white
        imageDay.image = UIImage(named: "dropdownarrow.png")
        imageTime.image = UIImage(named: "dropdownarrow.png")
        
        
    }
    
    func dism(){
        performSegueToReturnBack()
        //self.dismiss(animated: true, completion: nil)
    }
    func validate() -> Bool {
        if(self.timezoneID == ""){
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Select Time Zone", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }else if (self.dayLightID == ""){
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Select Day Light", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    fileprivate func showPopoverForView(view:Any, contents:Any) {
        let controller = DropDownItemsTable(contents)
        let senderButton = view as! UIButton
        controller.showPopoverInDestinationVC(destination: self, sourceView: view as! UIView) { (selectedValue) in
            if let selectVal = selectedValue as? String {
                senderButton.setTitle(selectVal, for: .normal)
               // senderButton.setImage(nil, for: .normal)
            } else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetTimeZone.timeZoneName] as? String {
                self.timezoneID = selectVal[GetTimeZone.timeZoneCode] as! String
                let title2 = selectVal[GetTimeZone.timeZoneCode]
                let title3 =  "\(title) [\(title2 ?? "")]"
                print(title3)
                senderButton.setTitle(title3, for: .normal)
              //  senderButton.setImage(nil, for: .normal)
            }
        }
    }
    fileprivate func showPopoverForView1(view:Any, contents:Any) {
        let controller = DropDownItemsTable(contents)
        let senderButton = view as! UIButton
        controller.showPopoverInDestinationVC(destination: self, sourceView: view as! UIView) { (selectedValue) in
            if let selectVal = selectedValue as? String {
                senderButton.setTitle(selectVal, for: .normal)
               // senderButton.setImage(nil, for: .normal)
            } else if let selectVal = selectedValue as? [String:Any], let title = selectVal[DayLight.day_status] as? String {
                self.dayLightID = selectVal[DayLight.day_id] as! String
                
                senderButton.setTitle(title, for: .normal)
               // senderButton.setImage(nil, for: .normal)
            }
        }
    }
}

