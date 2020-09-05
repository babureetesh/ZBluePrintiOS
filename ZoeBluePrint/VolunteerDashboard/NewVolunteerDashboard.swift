//
//  NewVolunteerDashboard.swift
//  ZoeBluePrint
//
//  Created by HashTag Labs on 29/06/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
import CoreLocation

class NewVolunteerDashboard: UIViewController,UITabBarDelegate,UITabBarControllerDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource {

    
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
    
    @IBOutlet weak var viewTblEvenList: UIView!
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var imageLocker: UIImageView!
    @IBOutlet weak var imageTarget: UIImageView!
    @IBOutlet weak var imageMessage: UIImageView!
    @IBOutlet weak var imageArea: UIImageView!
    
    @IBOutlet weak var tblVolEventList: UITableView!
    var zipcode = ""
    var volunteerEvent : [[String:Any]]!
    var locationManager: CLLocationManager!
    var boolShoOrg = false
    
    var objOrganization : OrganizationViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.delegate = self
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("showorg"), object: nil)
        objOrganization = self.storyboard!.instantiateViewController(withIdentifier: "organization") as? OrganizationViewController
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                     let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                     let userID = userIDData["user_id"] as! String
                     //print(userID)
                     let servicehandler = ServiceHandlers()
                    
                     servicehandler.VolunteerEventList(userData: userID as! String) { (responce, isSuccess) in
                         if isSuccess {
                             let data = responce as! Dictionary<String,Any>
                           
                             //print(data)
                            
        
                            self.zipcode = (data["user_zipcode"] as? String)!
                             //print(self.zipcode)
                            self.getCoverImageForRank()
                           
                         }
                     }
        
        
       // self.tblVolEventList.estimatedRowHeight = 350
        //self.tblVolEventList.rowHeight = UITableView.automaticDimension
        
        let tabbar = UITabBarController()
        tabbar.delegate = self
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
        self.image.image = UIImage(named:strImageNameCover)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewTblEvenList.isHidden = true
        super.viewWillAppear(animated)
      //  let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let userID = userIDData["user_id"] as! String
    print(userIDData)
        
        let string_url = userIDData["user_profile_pic"] as! String
        
    //    if  defaults == "Light Mode"{
            var headingName = userIDData["user_f_name"] as! String
            headingName = "\(headingName)'S DASHBOARD"
          
      //      LightMode()
            
        //}else if defaults == "Dark Mode"{
            
          //  var headingName = userIDData["user_f_name"] as! String
            //headingName = "\(headingName)'S DASHBOARD"
            //self.heading.textColor = .white
            //heading.text = headingName.uppercased()
            //DarkMode()
            
      //  }
        
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
        
        
        if (!boolShoOrg){
            
            
            for vc in self.children {
                vc.willMove(toParent: nil)
                vc.view.removeFromSuperview()
                vc.removeFromParent()
            }
        }
        boolShoOrg = false

    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        
        print("Notification called")
        self.tabBarController!.selectedIndex = 0
        self.setupViewForOrganization()
    }
    
    func setupViewForOrganization(){
        
        boolShoOrg = true
        
              
             
              objOrganization.view.frame = self.view.bounds;
              objOrganization.willMove(toParent: self)
              self.view.addSubview(objOrganization.view)
              self.addChild(objOrganization)
              objOrganization.didMove(toParent: self)
        
        
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
        let obj = sb.instantiateViewController(withIdentifier: "notify") as! VolunteerNotificationViewController
               self.present(obj, animated: true)
    }
    
    @IBAction func eventButton(_ sender: Any) {
       
       
        let vc = self.tabBarController?.viewControllers?[1] as! VolunteerEventsViewController
        vc.strFromScreen = "DASHBOARD"
         self.tabBarController?.selectedIndex = 1
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
        
        
        if !(self.zipcode.count > 0){
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
        }
    }
    
    func getNearByeventData(){
        
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
            }
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
    
         
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (volunteerEvent != nil)
        {
            return volunteerEvent!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVolEventList.dequeueReusableCell(withIdentifier: "voleventlistcell", for: indexPath) as! VolEventsListTableViewCell
        
        
        var a = volunteerEvent[indexPath.row]

        let dateString = a["event_register_start_date"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale = Locale.init(identifier: "en_GB")

        let dateObj = dateFormatter.date(from: dateString)    //date is changing into string

        dateFormatter.dateFormat = "dd"
        //print("Dateobj: \(dateFormatter.string(from: dateObj!))")  // the date data is coming now to again change from from string to date
        let dated = dateFormatter.string(from: dateObj!)
        print(dated)
       // cell.lblEventDate.text = dated as! String



        dateFormatter.dateFormat = "MM"
        //print("Monobj: \(dateFormatter.string(from: dateObj!))")
        let Month = dateFormatter.string(from: dateObj!)  // String coming
        let mon = Int(Month)     // changing String into Int
        let month = dateFormatter.monthSymbols[mon! - 1]    // data according to array [0....12]
        let mon2:String = String(month.prefix(3))       // e.g., oct,Nov,Dec....
        print(mon2)
      //  cell.lblMonth.text = mon2 as! String


        dateFormatter.dateFormat = "EEEE"
        //print("Week: \(dateFormatter.string(from: dateObj!))")
        let weekday = Calendar.current.component(.weekday, from: dateObj!)
        let week:String = dateFormatter.weekdaySymbols![weekday - 1]
        print(week)
       // a.weekdaySymbols[Calendar.current.component(.weekday, from: dateObj)]
        cell.lblEventDate.text = "\(dated)\n\(mon2)\n\(week.prefix(3))"
        cell.lblEventTitle.text = a["event_heading"] as? String
       
        //print(time)
        cell.lblEventDesc.text = a["event_details"] as? String
        cell.lblEventDesc.sizeToFit()
        let cellHeight = cell.contentView.bounds.size.height;
        cell.lblEventDate.frame.size.height = cellHeight
//        let neededSize =  cell.lblEventDesc.sizeThatFits(CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude))
//        print(neededSize)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let a = volunteerEvent[indexPath.row]
        let cellText = a["event_details"] as? String
        let cellFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 270.0, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = cellFont
        label.text = cellText
        label.sizeToFit()
        print(label.frame.height)
        
        return label.frame.height + 80
        
       // return 250.0

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var event = volunteerEvent[indexPath.row]
        //print(event)
        
        let a = volunteerEvent[indexPath.row]
        let sbh = ServiceHandlers()
        sbh.getSelectedEventDetails(eventId: a["event_id"] as! String){(responce,isSuccess) in
            if isSuccess{
               let event2 = responce as! Dictionary<String,Any>
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Description") as! VolunteerEventDescription
                       nextViewController.eventData = event2
                    nextViewController.event_id = a["event_id"] as! String
                       self.present(nextViewController, animated:true, completion:nil)
            }
            
        }
      
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

   
    
}



/*
 Remaining Tasks :
 
1) Images should be in white - Target , CSO Area,
 2) Functionality.
 
 */
//let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "request") as? CSORequest)!
//       vc.strShowClose = "YES"
//       self.present(vc, animated: true)
