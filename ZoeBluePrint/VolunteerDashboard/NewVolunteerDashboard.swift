//
//  NewVolunteerDashboard.swift
//  ZoeBluePrint
//
//  Created by HashTag Labs on 29/06/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
import CoreLocation

class NewVolunteerDashboard: UIViewController,UITabBarDelegate,UITabBarControllerDelegate,CLLocationManagerDelegate{

    
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
//    @IBOutlet weak var btnEvents: UIButton!
//    @IBOutlet weak var btnLocker: UIButton!
//    @IBOutlet weak var btnTargets: UIButton!
//    @IBOutlet weak var btnMessage: UIButton!
//    @IBOutlet weak var btnCSOArea: UIButton!
    
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var imageLocker: UIImageView!
    @IBOutlet weak var imageTarget: UIImageView!
    @IBOutlet weak var imageMessage: UIImageView!
    @IBOutlet weak var imageArea: UIImageView!
    
    
    @IBOutlet weak var Days_counter_value: UILabel!
       @IBOutlet weak var Days_counter: UILabel!
       @IBOutlet weak var Hours_counter_value: UILabel!
       @IBOutlet weak var Hours_value: UILabel!
       @IBOutlet weak var Minute_counter_value: UILabel!
       @IBOutlet weak var Minute_counter: UILabel!
       @IBOutlet weak var Seconds_counter_Value: UILabel!
       @IBOutlet weak var second_counter: UILabel!
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    
    var zipcode = ""
    var volunteerEvent : [[String:Any]]!
    var locationManager: CLLocationManager!
    var boolShoOrg = false
    
    var objOrganization : OrganizationViewController!
    var volunteerEventlist : [[String:Any]]?
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.delegate = self
        // Do any additional setup after loading the view.
        
        objOrganization = self.storyboard!.instantiateViewController(withIdentifier: "organization") as? OrganizationViewController
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                     let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                     let userID = userIDData["user_id"] as! String
                     //print(userID)
                     let servicehandler = ServiceHandlers()
                    
        servicehandler.VolunteerEventList(userData: userID ) { (responce, isSuccess) in
                         if isSuccess {
                             let data = responce as! Dictionary<String,Any>
                           self.volunteerEventlist = data["event_data"] as? [[String : Any]]
                             //print(data)
                             self.configureCountDown()
        
                            self.zipcode = (data["user_zipcode"] as? String)!
                             //print(self.zipcode)
                            self.getCoverImageForRank()
                           
                         }
                     }
        
        let tabbar = UITabBarController()
        tabbar.delegate = self
    }
    
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        let timeZone =  UserDefaults.standard.object(forKey: UserDefaultKeys.key_userTimeZone) as! String
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    // Creating Countdown Timer:
       fileprivate func configureCountDown() {
           if(self.volunteerEventlist != nil){
            var strUserTimezone = "EST"
           let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                   let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            if let timeZone = userIDData["user_timezone"] {
               strUserTimezone = timeZone as? String ?? "EST"
            }else{
               strUserTimezone = "EST"
            }
               let shift_date = self.volunteerEventlist!.first!["shift_date"] as? String
               let shift_time = self.volunteerEventlist!.first!["shift_start_time_timer"] as? String
            let shift_date_time = self.utcToLocal(dateStr: shift_date! + " " + shift_time!)
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            let date = dateFormatter.date(from: shift_date_time!)
              // dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
//               let timeZone =  UserDefaults.standard.object(forKey: UserDefaultKeys.key_userTimeZone) as! String
//               print(timeZone)
               
               let releaseDateString =  dateFormatter.string(from: date!)
               let releaseDateFormatter = DateFormatter()
               releaseDateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            releaseDateFormatter.timeZone = NSTimeZone(abbreviation: strUserTimezone) as TimeZone?
               releaseDate = releaseDateFormatter.date(from: releaseDateString) as NSDate?
               countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
           }else{
              self.volunteerEventlist = []
           }
       }
       @objc func updateTime() {
           
           let currentDate = Date()
           let calendar = Calendar.current
           ////print(releaseDate!)
           let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: (releaseDate! as Date))
           let strday = "\(diffDateComponents.day ?? 00)"
            if  (strday.count<2){
                Days_counter_value.text = "0"+strday
            }else{
              Days_counter_value.text = strday
            }
           
            // For Hours:
            let strHours = "\(diffDateComponents.hour ?? 00)"
            if(strHours.count < 2){
               Hours_counter_value.text = "0" + strHours
            }else{
              Hours_counter_value.text = strHours
            }
            
                //For Minutes:
                let strMinutes = "\(diffDateComponents.minute ?? 00)"
                       if(strMinutes.count < 2){
                          Minute_counter_value.text = "0" + strMinutes
              }else{
             Minute_counter_value.text = strMinutes
           }
           
            // For Seconds:
            let strSeconds = "\(diffDateComponents.second ?? 00)"
                     if(strSeconds.count < 2){
                       Seconds_counter_Value.text = "0" + strSeconds
            }else{
               Seconds_counter_Value.text = strSeconds
            }
            
           
       }
    func getCoverImageForRank(){
        
        var strImageNameCover = "cover_cloud.jpg"
        
        if let decoded  = UserDefaults.standard.object(forKey: "VolData") as? Data, let volData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Dictionary<String, Any>, let userAvgRank = volData["user_avg_rank"] as? String
        //print(volData)
        {
            
            
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
        self.image.image = UIImage(named:strImageNameCover)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     /*
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let userID = userIDData["user_id"] as! String
    print(userIDData)
          let string_url = userIDData["user_profile_pic"] as! String
        if let url = URL(string: string_url){
            do {
                let imageData = try Data(contentsOf: url as URL)
                self.profilePic.image = UIImage(data: imageData)
                self.profilePic.layer.borderWidth = 1
                self.profilePic.layer.masksToBounds = false
                self.profilePic.layer.borderColor = UIColor.black.cgColor
                self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2
                self.profilePic.clipsToBounds = true
            } catch {
                //print("Unable to load data: \(error)")
            }
        }
        */
        self.profile_pic()
        
        if (!boolShoOrg){
            
            
            for vc in self.children {
                vc.willMove(toParent: nil)
                vc.view.removeFromSuperview()
                vc.removeFromParent()
            }
        }
        boolShoOrg = false

    }
    
    func profile_pic()  {
          let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
          let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
          let params = userIDData["user_id"] as! String
          let serivehandler = ServiceHandlers()
          serivehandler.editProfile(user_id: params){(responce,isSuccess) in
              if isSuccess{
                  let data = responce as! Dictionary<String,Any>
                  let string_url = data["user_profile_pic"] as! String
                  if let url = URL(string: string_url){
                      
                  do {
                      DispatchQueue.global().async {
                          let imageData = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        self.saveImageInDocsDir(dataImage: imageData!)
                          DispatchQueue.main.async {
                            
                              self.profilePic.image = UIImage(data: imageData!)
                                                self.profilePic.layer.borderWidth = 1
                                                 self.profilePic.layer.masksToBounds = false
                                                 self.profilePic.layer.borderColor = UIColor.black.cgColor
                                                 self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2
                                                 self.profilePic.clipsToBounds = true
                          }
                      }
                  }
                  }
              }
          }
        
//        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
//        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
//        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
//        if let dirPath          = paths.first
//        {
//           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
//            if let image    = UIImage(contentsOfFile: imageURL.path){
//                                    self.profilePic.image = image
//                                      self.profilePic.layer.borderWidth = 1
//                                      self.profilePic.layer.masksToBounds = false
//                                      self.profilePic.layer.borderColor = UIColor.black.cgColor
//                                      self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2
//                                      self.profilePic.clipsToBounds = true
//            }
//           // Do whatever you want with the image
//        }
      }
      
      func saveImageInDocsDir(dataImage: Data ) {
           
       //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
              
                         if (dataImage != nil) {
                           // get the documents directory url
                           let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                           // choose a name for your image
                           let fileName = "profilepic.jpg"
                           // create the destination file url to save your image
                           let fileURL = documentsDirectory.appendingPathComponent(fileName)
                           // get your UIImage jpeg data representation and check if the destination file url already exists
                               do {
                                   // writes the image data to disk
                                try dataImage.write(to: fileURL, options: Data.WritingOptions.atomic)
                                   print("file saved")
                                   print(fileURL)
                               } catch {
                                   print("error saving file:", error)
                               }
                           
                         }
                   }
      
    
    
    
    
    func DarkMode() {
   
        
        view.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        btnSideMenu.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
       
    
//        btnEvents.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imageEvent.image = UIImage(named: "newIconEvents.png")
        
        
//        btnLocker.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imageLocker.image = UIImage(named: "newIconLocker.png")
        
        
//        btnTargets.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        imageTarget.image = UIImage(named: "")
        
        
//        btnMessage.setTitleColor(UIColor.white, for: UIControl.State.normal)
       imageMessage.image = UIImage(named: "newIconMessages.png")
        
 //       btnCSOArea.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        imageTarget.image = UIImage(named: "")
        
        
        
    }
    func LightMode() {
        
        
        view.backgroundColor = .white
        btnSideMenu.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
        
    }
    
    @IBAction func notificationBellTapped(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
          present(obj,animated: true)
    }
    
    @IBAction func eventButton(_ sender: Any) {
       
        if let navController = self.tabBarController?.viewControllers?[1] as? UINavigationController, let firstVC = navController.viewControllers.first, let eventVC = firstVC as? VolunteerEventsViewController
        {
                eventVC.strFromScreen = "DASHBOARD"
                eventVC.strPostalCode = nil
                 self.tabBarController?.selectedIndex = 1
        }
    
//        let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Volunteer Events") as? VolunteerEventsViewController)!
//        vc.strFromScreen = "DASHBOARD"
//        self.present(vc, animated: true)
        
//        let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Volunteer Events") as? VolunteerEventsViewController)!
//        vc.strFromScreen = "DASHBOARD"
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func lockerButton(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    
    
    @IBAction func teargetButton(_ sender: Any) {
        self.tabBarController?.selectedIndex = 3
    }
    
    @IBAction func messageButton(_ sender: Any) {
         self.tabBarController?.selectedIndex = 4
    }
    
    
    @IBAction func csoAreaButton(_ sender: Any) {
        
        
     /*   if !(self.zipcode.count > 0){
                                       if (CLLocationManager.locationServicesEnabled())
                                       {
                                           self.locationManager = CLLocationManager()
                                           self.locationManager.delegate = self
                                           self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                                           self.locationManager.requestAlwaysAuthorization()
                                           self.locationManager.startUpdatingLocation()
                                       }else{
                                           let alert = UIAlertController(title: "Allow Location Access", message: "Zoe Blue Print needs access to your location. Turn on Location Services in your device settings.", preferredStyle: UIAlertController.Style.alert)

                                           // Button to Open Settings
                                           alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
                                               guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                                   return
                                               }
                                               if UIApplication.shared.canOpenURL(settingsUrl) {
                                                   UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                                       print("Settings opened: \(success)")
                                                   })
                                               }
                                           }))
                                           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                           self.present(alert, animated: true, completion: nil)
                                       }
        }else {
            
            self.getNearByeventData()
        }*/
        
        if let navController = self.tabBarController?.viewControllers?[1] as? UINavigationController, let firstVC = navController.viewControllers.first, let eventVC = firstVC as? VolunteerEventsViewController
              {
                      eventVC.strFromScreen = "DASHBOARD"
                      eventVC.strPostalCode = self.zipcode
                              self.tabBarController?.selectedIndex = 1
              }
        
               
    }
    

    func getNearByeventData(){
       /*
        let serviceHandler = ServiceHandlers()
        serviceHandler.DiscoveringEvents(search_row_number: "0", search_keyword: "", search_page_size: "10", search_city: "", search_event_type: "", search_org: "", search_postcode: self.zipcode as? String ?? "", search_state: "")
        { (responce, isSuccess) in
            if isSuccess {
                let data = responce as! Array<Any>
                print(data)
                self.volunteerEvent = data as? [[String : Any]]
                if self.volunteerEvent.count > 0 {
                    self.viewTblEvenList.isHidden = false
                    self.tblVolEventList.delegate = self
                    self.tblVolEventList.dataSource = self
                    self.tblVolEventList.reloadData()
                }else{
                    let alertController = UIAlertController(title: "No event found!", message: nil, preferredStyle: .alert)

                      // Create the actions
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                          UIAlertAction in
                         // NSLog("OK Pressed")
                      }
                    // Add the actions
                      alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }else{
                
                let alertController = UIAlertController(title: "No Events Found", message: nil, preferredStyle: .alert)

                  // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                      UIAlertAction in
                     // NSLog("OK Pressed")
                  }
                // Add the actions
                  alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            }*/
        let vc = self.tabBarController?.viewControllers?[1] as! VolunteerEventsViewController
        vc.strFromScreen = "DASHBOARD"
        self.tabBarController?.selectedIndex = 1
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
       {

           let location = locations.last! as CLLocation
           print(location.coordinate.latitude)
           print(location.coordinate.longitude)
          // let cityCoords = CLLocation(latitude: newLat, longitude: newLon)
           self.getAdressName(coords: location)
        
       }
    
    func getAdressName(coords: CLLocation) {

      CLGeocoder().reverseGeocodeLocation(coords) { (placemark, error) in
              if error != nil {
                  print("Hay un error")
                let alertController = UIAlertController(title: "Error Occured!", message: "Postal Code not found.", preferredStyle: .alert)

                                         // Create the actions
                                       let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                             UIAlertAction in
                                         }
                                         // Add the actions
                                         alertController.addAction(okAction)
                                       self.present(alertController, animated: true, completion: nil)
                self.locationManager.stopUpdatingLocation()
              } else {

                  let place = placemark! as [CLPlacemark]
                  if place.count > 0 {
                      let place = placemark![0]
                      var adressString : String = ""
                      if place.postalCode != nil {
                          adressString = adressString + place.postalCode! //+ "\n"
                        self.zipcode = adressString
                        self.getNearByeventData()
                        self.locationManager.stopUpdatingLocation()
                      }else{
                        
                        let alertController = UIAlertController(title: "Error Occured!", message: "Postal Code not found.", preferredStyle: .alert)
                        // Create the actions
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                              UIAlertAction in
                             // NSLog("OK Pressed")
                          }
                        // Add the actions
                          alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        self.locationManager.stopUpdatingLocation()
                    }
                    self.locationManager.stopUpdatingLocation()
                    
                  }
              }
          }
    }
    
         
  
 
   
    
}



/*
 Remaining Tasks :
 
1) Images should be in white - Target , CSO Area,
 2) Functionality.
 
 */
//let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "request") as? CSORequest)!
//       vc.strShowClose = "YES"
//       self.present(vc, animated: true)
