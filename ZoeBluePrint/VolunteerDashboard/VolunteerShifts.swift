//
//  VolunteerShifts.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 12/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolunteerShifts: UIViewController,UITableViewDataSource,UITableViewDelegate {
   

    
    
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var buttonView: UIButton!
    
//    @IBOutlet weak var lblHeadingName: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    var data:Array<Any>?
     var eventID:String?
     var dataDetails:Dictionary<String,Any>?
    
    var volunteerShiftsList : [[String:Any]]!
    
    
    @IBOutlet weak var sideMenuTapped: UIButton!
   
    @IBOutlet weak var Table1: UITableView!
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var lblShift: UILabel!
    
    @IBOutlet weak var StackView: UIView!
    @IBOutlet weak var ShiftLabel: UILabel!
    @IBOutlet var OuterView: UIView!
    
    @IBOutlet weak var imgViewCoverPic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.Table1.tableFooterView = UIView(frame: .zero)
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
              self.OuterView.addGestureRecognizer(mytapGestureRecognizer)
              self.StackView.isUserInteractionEnabled = true
              OuterView.isHidden = true               // Change Status
              StackView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

        OuterView.isHidden = true
        StackView.isHidden = true
        
        self.call_for_Table_data()
    }
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//    let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//    if defaults == "Dark Mode"{
//
//        DarkMode()
//    }else if defaults == "Light Mode"{
//        LightMode()
//    }
    self.getCoverImageForRank()
                   let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
         let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
             let userID = userIDData["user_id"] as! String
    
//    if defaults == "Dark Mode"{
//
//        var headingName = userIDData["user_f_name"] as! String
//        headingName = "\(headingName)'S DASHBOARD"
//        self.lblHeadingName.textColor = .white
//        lblHeadingName.text = headingName.uppercased()
//
//    }else if defaults == "Light Mode"{
        
        var headingName = userIDData["user_f_name"] as! String
         headingName = "\(headingName)'S BOOKING"
//         self.lblHeadingName.textColor = .black
//         lblHeadingName.text = headingName.uppercased()
   // }
     let string_url = userIDData["user_profile_pic"] as! String
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


    @IBAction func notificationBellTapped(_ sender: Any) {
           
           let sb = UIStoryboard(name: "Main", bundle: nil)
           let obj = sb.instantiateViewController(withIdentifier: "notify") as! VolunteerNotificationViewController
                  self.present(obj, animated: true)
       }
    func DarkMode(){
        
        
        view.backgroundColor = .black
        self.buttonView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.buttonView.backgroundColor = .black
        self.ImageView.image = UIImage(named: "lighteye-open.png")
        self.btnback.setImage(UIImage(named: "iphoneButton.png"), for: UIControl.State.normal)
        self.btnback.backgroundColor = .black
        self.sideMenuTapped.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        self.lblShift.textColor = .white
        
    }
    func LightMode(){
       
        view.backgroundColor = .white
        self.buttonView.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.buttonView.backgroundColor = .white
        self.sideMenuTapped.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
        self.lblShift.textColor = .black
         self.btnback.setImage(UIImage(named: "iphoneBackButton.png"), for: UIControl.State.normal)
        
    }
    @objc func handleTap(_ sender:UITapGestureRecognizer){

           self.OuterView.isHidden = true
           self.StackView.isHidden = true
           

       }
    func call_for_Table_data()  {
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let userID = userIDData["user_id"] as! String
        ////print(userID)
        
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.VolunteerShiftsDetails(user_id: userID , event_id:self.eventID!) { (responce,isSuccess) in
            if isSuccess {
                self.data = responce as! [[String: Any]]
                print(self.data)
                
                
                self.Table1.reloadData()
                
            }else{
                let alert = UIAlertController(title: nil, message: NSLocalizedString("Data Not Found", comment: ""), preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
                    //Cancel Actionse
                    self.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (data != nil)
        {
            return data!.count
        }
        //                }else{
        return 0
        //                }
    }
   
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Table1.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VolunteerShiftTableViewCell
        
        var b = data![indexPath.row] as! Dictionary<String,Any>
        //var a = b[indexPath.row]
        
        cell.selectionStyle = .none
//    let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//        if defaults == "Dark Mode"{
//            
//            cell.backgroundColor = .black
//            cell.TimeLabel.textColor = .white
//            cell.MonthLabel.textColor = .white
//            cell.DateLabel.textColor = .white
//            cell.WeekLabel.textColor = .white
//            cell.TitleLabel.textColor = .white
//            
//            
//            
//        }else if defaults == "Light Mode" {
//            
//            cell.backgroundColor = .white
//            cell.TimeLabel.textColor = .black
//            cell.MonthLabel.textColor = .black
//            cell.DateLabel.textColor = .black
//            cell.WeekLabel.textColor = .black
//            cell.TitleLabel.textColor = .black
//            
//        }
        cell.TitleLabel.text = b["shift_task_name"] as! String
        
        
        var start_time = b["shift_start_time"] as! String
        var end_time = b["shift_end_time"] as! String
        var Time = "\(start_time) - \(end_time)"
        //.////print(Time)
        cell.TimeLabel.text = Time as! String
        
        let dateString = b["shift_date"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        
        let dateObj = dateFormatter.date(from: dateString)    //date is changing into string
        
        dateFormatter.dateFormat = "dd"
        ////print("Dateobj: \(dateFormatter.string(from: dateObj!))")  // the date data is coming now to again change from from string to date
        let dated = dateFormatter.string(from: dateObj!)
        ////print(dated)
        cell.DateLabel.text = dated as! String
        
        dateFormatter.dateFormat = "MM"
        ////print("Monthobj: \(dateFormatter.string(from: dateObj!))")
        let month = dateFormatter.string(from: dateObj!)
        let mon = Int(month)
        let mont = dateFormatter.monthSymbols[mon! - 1]
        let Month = String(mont.prefix(3))
        ////print(Month)
        cell.MonthLabel.text = Month as! String
        
        dateFormatter.dateFormat = "EEE"
        ////print("Week: \(dateFormatter.string(from: dateObj!))")
        let weekday = Calendar.current.component(.weekday, from: dateObj!)
        let week:String = dateFormatter.weekdaySymbols![weekday - 1]
        let Week = String(week.prefix(3))
        ////print(Week)
        cell.WeekLabel.text = Week as! String
        
        
        cell.StatusNameTapped.tag = indexPath.row
        //  //print(b["volunteer_apply"] as! String)
        
        
        ////print(b)
        
        var accepted = b["volunteer_req_accepted"] as! String
        ////print(accepted)
        
        var vol_request = b["shift_vol_req"] as! String
        ////print(vol_request)
        
        var changeRate = b["volunteer_apply"] as! String
        ////print(changeRate)
        if changeRate != "0"{
            
            cell.StatusNameTapped.setImage(UIImage(named: "pending.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
            cell.StatusName.text = "Waiting"
            cell.StatusName.textColor = .gray
            // UIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 1.0)
        }else
            if changeRate == "0" {
                
                if vol_request == accepted {
                    
                    cell.StatusNameTapped.setImage(UIImage(named: "not-available.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    cell.StatusName.text = "Not Available"
                    cell.StatusName.textColor = UIColor.gray
                    
                }else {
                    
                    cell.StatusNameTapped.setImage(UIImage(named: "csoavailable.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    cell.StatusName.text = "Available"
                    cell.StatusName.textColor =  UIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 1.0)
                }
                
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OuterView.isHidden = false
        StackView.isHidden = false
        
        var b = data![indexPath.row] as! Dictionary<String,Any>
        ////print(b)
        self.dataDetails = b
        
    }
    
       
    
   
    @objc func methodOfReceivedNotification(notification: Notification){
        
        let indexSelected = notification.userInfo!["selectedIndex"] as! Int
        let b = data![indexSelected] as! Dictionary<String,Any>
       
        
        var Rank = b["shift_rank"] as! String
        ////print(Rank)
    
        
        var Apply = b["volunteer_apply"] as! String
       // //print(Apply)
     
        
        var returnValue = (UserDefaults.standard.object(forKey: "user_avg_rate") as! String)
        ////print(returnValue)
        
        let changeRate = b["volunteer_apply"] as! String
         ////print(changeRate)
         if changeRate == "0"{
             
              if Rank <= returnValue {
                
                let cso_id = b["csoa_id"] as! String
                ////print(cso_id)
                
                let shift_id = b["shift_id"] as! String
                
                
            let serviceHanlder = ServiceHandlers()
                serviceHanlder.EventSendRequest(cso_id: cso_id, shift_id: shift_id, event_id: self.eventID!) { (responce,isSuccess) in
                        if isSuccess {
        let alert = UIAlertController(title: "", message: NSLocalizedString("Volunteer Request Sent successfully", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
            self.call_for_Table_data()
        }else{
                   let alert = UIAlertController(title: "", message: NSLocalizedString("Error Occured!", comment: ""), preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
             }
            }
            }else{
        let alert = UIAlertController(title: "", message: NSLocalizedString("You are not eligible for this shift", comment: ""), preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
            }
         }else{
    let alert = UIAlertController(title: "", message: NSLocalizedString("You are not eligible for this shift", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
                 }
    }
                
     @IBAction func backbutton(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "notify") as! VolunteerNotificationViewController
               self.present(obj, animated: true)
    }
    @IBAction func btnSideMenu(_ sender: Any) {
    }
    
    @IBAction func ViewButtonTapped(_ sender: Any) {
   
  OuterView.isHidden = true
  StackView.isHidden = true
   let mainSB = UIStoryboard(name: "Main", bundle: nil)
   let selectedEventVC =  mainSB.instantiateViewController(withIdentifier: "Cell") as? ShiftRank
        selectedEventVC!.data1 = self.dataDetails
   self.present(selectedEventVC!,animated: true)
        
   
    }
    
    
    @IBAction func backButtonFunction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
