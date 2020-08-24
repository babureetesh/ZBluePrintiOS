//
//  CSOEventShiftViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 12/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class CSOEventShiftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    
    
    @IBOutlet weak var sideMenu: UIButton!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDelete: UIImageView!
    @IBOutlet weak var imageEdit: UIImageView!
    
    @IBOutlet weak var StatusImage: UIImageView!
    
    @IBOutlet weak var StatusLabel: UILabel!
    
    @IBOutlet weak var lightStarRating: FloatRatingView!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var shiftRank: UILabel!
    
    @IBOutlet weak var starView: FloatRatingView!
    
    
    @IBOutlet weak var getShiftDetailsBackgroundView: UIView!
    
    
    @IBOutlet weak var RequestLabel: UILabel!
    
    @IBOutlet weak var ShiftDateLAbel: UILabel!
    
    @IBOutlet weak var ShiftTimeLabel: UILabel!
    
    @IBOutlet weak var getShiftDetailsView: UIView!
    
    @IBOutlet weak var tableGetAllShift: UITableView!
    @IBOutlet weak var task_name: UILabel!
      
     @IBOutlet weak var vol_requested: UILabel!
    @IBOutlet weak var shift_date: UILabel!
    @IBOutlet weak var shift_time: UILabel!
    var calenderData:Dictionary<String,Any>?
    var shiftdata = [[String:Any]]()
    var shiftDetails = [String:Any]()
    var index:Int?
    var event_id:String?
    var screen:String?
    var shift_Rank:Int?
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    
    @IBAction func notificationButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
          present(obj,animated: true)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // //print("view will appear called")
 /*  let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode"{
            
            DarkMode()
            self.sideMenu.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
    self.backButton.setImage(UIImage(named: "iphoneButton.png"), for: UIControl.State.normal)
        
        } else  if defaults == "Light Mode"{
            
            LightMode()*/
          //  self.sideMenu.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
            self.backButton.setImage(UIImage(named: "iphoneBackButton.png"), for: UIControl.State.normal)
            
     //   }*/
       
        self.lightStarRating.isHidden = true
        self.backButton.isHidden = false
        self.starView.isHidden = true
        self.starView.isUserInteractionEnabled = false
        self.lightStarRating.isUserInteractionEnabled = false
        shiftRank.isHidden = true
        RequestLabel.isHidden = true
        ShiftDateLAbel.isHidden = true
        ShiftTimeLabel.isHidden = true
        vol_requested.isHidden = true
        shift_date.isHidden = true
        shift_time.isHidden = true
        StatusLabel.isHidden = true
        StatusLabel.isHidden = true
        
        if screen == "calender"{
     
            let shiftdata = self.calenderData!["shiftdata"] as! Dictionary<String,Any>
//                    self.task_name.text = shiftdata[index!]["shift_task_name"] as! String
                  let servicehandler = ServiceHandlers()
            servicehandler.getShiftDetails(shiftId: shiftdata["shift_id"] as! String){
                (responce,isSuccess) in
                if isSuccess{
                    let data = responce as! Dictionary<String,Any>
                    self.setValues(shiftdata1: data)
                    
                    
                }
            }
                    //var data = shiftdata[index!]
                    //self.setValues(shiftdata1:data)
        }
        self.profile_pic()
    }
    
    func DarkMode(){
    
        self.view.backgroundColor = UIColor(red: 38.0/255.0, green: 39.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        self.getShiftDetailsView.backgroundColor = .darkGray
        self.btnEdit.backgroundColor = .darkGray
        self.btnEdit.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageEdit.image = UIImage(named: "lightThemePencil.png")
        
        self.btnDelete.backgroundColor = .darkGray
        self.btnDelete.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageDelete.image = UIImage(named: "LightInkeddownload.png")
        
        self.btnView.backgroundColor = .darkGray
        self.btnView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageView.image = UIImage(named: "lighteye-open.png")
        
        label1.backgroundColor = .lightGray
        label2.backgroundColor = .lightGray
        
        self.task_name.textColor = .white
         self.task_name.backgroundColor = UIColor(red: 38.0/255.0, green: 39.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        
        
    }
    func LightMode(){
        
        self.view.backgroundColor = .white
        self.getShiftDetailsView.backgroundColor = .white
        
        label1.backgroundColor = .lightGray
        label2.backgroundColor = .lightGray
        
        self.task_name.textColor = .black
        self.task_name.backgroundColor = .white
        
    }
    
            override func viewDidLoad() {
        super.viewDidLoad()
                
              
        self.tableGetAllShift.delegate = self
        self.tableGetAllShift.dataSource = self
      
        self.tableGetAllShift.isHidden = false
                
        
     let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    self.getShiftDetailsBackgroundView.addGestureRecognizer(mytapGestureRecognizer)
    self.getShiftDetailsView.isUserInteractionEnabled = true
              
                getShiftDetailsBackgroundView.isHidden = true               // Change Status
                getShiftDetailsView.isHidden = true

                
                NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
                if screen != "calender"{
                    self.getAllData()
                }
        
    }
    @objc func handleTap(_ sender:UITapGestureRecognizer) {

              self.getShiftDetailsBackgroundView.isHidden = true
              self.getShiftDetailsView.isHidden = true
              

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
                  let imageData = try Data(contentsOf: url as URL)
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

            }
        }
    }
      
    @IBAction func backButtonFunction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   @objc func methodOfReceivedNotification(notification: Notification) {
     //  //print("Value of notification : ", notification.object ?? "")
    self.getAllData()
   }
    func getAllData(){
        
       // //print(shiftDetails)
        let eventID = shiftDetails["event_id"] as! String
       // //print(eventID)
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.getAllShift(eventId: eventID as? String ?? "") { (responce, isSuccess) in
          if isSuccess {
               self.shiftdata = responce as! [[String: Any]]
               // //print(self.shiftdata)
                  self.tableGetAllShift.reloadData()
               
          }else{
                  
            let alert = UIAlertController(title: nil, message: "Data Not Found", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                      self.present(alert,animated: true)
                                            }
                                   }
    }
    func setValues(shiftdata1:Dictionary<String,Any>){
     /*  let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode"{
            
            
            self.view.backgroundColor = UIColor(red: 38.0/255.0, green: 39.0/255.0, blue: 39.0/255.0, alpha: 1.0)
            self.RequestLabel.textColor = .blue
            self.ShiftDateLAbel.textColor = .blue
            self.ShiftTimeLabel.textColor = .blue
            self.shiftRank.textColor = .blue
            self.task_name.textColor = UIColor.blue
            self.shift_time.textColor = UIColor.white
            self.vol_requested.textColor = UIColor.white
            self.shift_date.textColor = UIColor.white
            self.starView.backgroundColor = .clear
            
            self.starView.isHidden = false
            self.starView.rating = Double(shiftdata1["shift_rank"] as! String) ?? 0.0
            self.starView.isUserInteractionEnabled = false
            lightStarRating.isHidden = true
            self.backButton.setImage(UIImage(named: "iphoneButton.png"), for: UIControl.State.normal)
            
        } else if defaults == "Light Mode" {
            */
            
            self.view.backgroundColor = .white
            self.RequestLabel.textColor = .blue
            self.ShiftDateLAbel.textColor = .blue
            self.ShiftTimeLabel.textColor = .blue
            self.shiftRank.textColor = .blue
            self.task_name.textColor = UIColor.blue
            self.shift_time.textColor = UIColor.black
            self.vol_requested.textColor = UIColor.black
            self.shift_date.textColor = UIColor.black
            
            self.lightStarRating.isHidden = false
            self.lightStarRating.rating = Double(shiftdata1["shift_rank"] as! String) ?? 0.0
            self.lightStarRating.isUserInteractionEnabled = false
            starView.isHidden = true
      
    //    }
        
                   self.tableGetAllShift.isHidden = true
                   self.getShiftDetailsBackgroundView.isHidden = true
                   self.backButton.isHidden = false
                   RequestLabel.isHidden = false
                          ShiftDateLAbel.isHidden = false
                          ShiftTimeLabel.isHidden = false
                          shiftRank.isHidden = false
                          vol_requested.isHidden = false
                          shift_date.isHidden = false
                          shift_time.isHidden = false
                          StatusImage.isHidden = false
                          StatusLabel.isHidden = false
       
        task_name.text = shiftdata1["shift_task_name"] as! String
    
        var start_time = shiftdata1["shift_start_time_format"] as! String
    
        var end_time = shiftdata1["shift_end_time_format"] as! String

        var Time = "\(start_time) - \(end_time)"
    
        shift_time.text = Time
        
       
        vol_requested.text = shiftdata1["shift_vol_req"] as? String
        
        shift_date.text = shiftdata1["shift_date"] as? String
        
        var status = shiftdata1["shift_status"] as! String
        
        let intVolunteerApply = Int(shiftdata1["volunteer_apply"]as! String)
        let intVolReq = Int(shiftdata1["shift_vol_req"]as! String)
        let intVolunteerreqAccepted = Int(shiftdata1["volunteer_req_accepted"]as! String)
        
        if intVolunteerApply != 0{
            
            StatusImage.image = UIImage(named: "pending.png")
                   StatusLabel.text = "Waiting"
                   self.StatusLabel.textColor = UIColor.gray
        }else if intVolunteerApply == 0{
            
            if intVolunteerreqAccepted == intVolReq{
                
                StatusImage.image = UIImage(named: "not-available.png")
                StatusLabel.text = "Not Available"
                self.StatusLabel.textColor = UIColor.gray
                
            }else{
                
                StatusImage.image = UIImage(named: "csoavailable.png")
                StatusLabel.text = "Available"
                self.StatusLabel.textColor = UIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 1.0)
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shiftdata.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableGetAllShift.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! getShiftDataCell
    var dateString = shiftdata[indexPath.row]["shift_date"] as! String
   /* let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
    if defaults == "Dark Mode" {
        
        cell.backgroundColor = UIColor(red: 38.0/255.0, green: 39.0/255.0, blue: 39.0/255.0, alpha: 1.0)
        cell.shiftDate.textColor = .white
        cell.shiftMonth.textColor = .white
        cell.shiftDay.textColor = .white
        cell.lbnEventName.textColor = .white
        cell.lbnEventTime.textColor = .white
        
        
    } else if defaults == "Light Mode" {
        
        cell.backgroundColor = .white
        cell.shiftDate.textColor = .black
        cell.shiftMonth.textColor = .black
        cell.shiftDay.textColor = .black
        cell.lbnEventName.textColor = .black
        cell.lbnEventTime.textColor = .black
        
    }*/
    
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MM-dd-yyyy"
           dateFormatter.locale = Locale.init(identifier: "en_GB")
    let dateObj = dateFormatter.date(from: dateString)
    
    dateFormatter.dateFormat = "dd"
   // //print("Dateobj: \(dateFormatter.string(from: dateObj!))")
    let dated = dateFormatter.string(from: dateObj!)
    
     
    cell.shiftDate.text = dated as! String
    cell.shiftMonth.text = shiftdata[indexPath.row]["shift_month"] as! String
     var day = shiftdata[indexPath.row]["shift_day"] as! String
   // //print(day)
    cell.shiftDay.text = String(day.prefix(3))
    cell.lbnEventName.text = shiftdata[indexPath.row]["shift_task_name"] as! String
   
    var start_time = shiftdata[indexPath.row]["shift_start_time"] as! String
   // //print(start_time)
    var end_time = shiftdata[indexPath.row]["shift_end_time"] as! String
   // //print(end_time)
    cell.lbnEventTime.text = "\(start_time) - \(end_time)"
    
    return cell 
   }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // //print(indexPath.row)
        self.getShiftDetailsBackgroundView.isHidden = false
        self.getShiftDetailsView.isHidden = false
        index = indexPath.row
        
    }
    
    @IBAction func getDetailEditButton(_ sender: Any) {
        var data = shiftdata[index!]
        self.getShiftDetailsBackgroundView.isHidden = true
        //self.getShiftDetailsView.isHidden = true
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let secondViewController = storyBoard.instantiateViewController(withIdentifier: "CSOAddShiftViewController") as! CSOAddShiftViewController
        secondViewController.data_for_update = data
        secondViewController.screen = "EDIT SCREEN"
        secondViewController.eventDetail = shiftDetails
        self.present(secondViewController, animated:true, completion:nil)
        
    }
    
    
    @IBAction func getDetailDeleteButton(_ sender: Any) {
        var data = shiftdata[index!]["shift_id"]
        self.getShiftDetailsBackgroundView.isHidden = true
//        self.getShiftDetailsBackgroundView.isHidden = true
        let serviceHanlder = ServiceHandlers()
                       serviceHanlder.deleteShiftForEventCSO(shift_id: data as? String ?? "") { (responce, isSuccess) in
                                           if isSuccess {
              
   let alert = UIAlertController(title: "", message: NSLocalizedString("Do you want to delete the document?", comment: ""), preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(_ action: UIAlertAction) -> Void in
            ActivityLoaderView.startAnimating()
                                            
   let alert = UIAlertController(title: nil, message: NSLocalizedString("Data Deleted", comment: ""), preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
          self.present(alert,animated: true)
        self.getAllData()
         self.tableGetAllShift.reloadData()
                                            
          }))
    alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
 
    }else{
  
    var data = responce as! Dictionary<String,Any>
    var msg = data["res_message"] as! String
let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        self.present(alert,animated: true)
                                               }
                                      }
                            }
    
    
    
    @IBAction func getDetailViewButton(_ sender: Any) {
        self.tableGetAllShift.isHidden = true
        self.getShiftDetailsBackgroundView.isHidden = true
        self.getShiftDetailsView.isHidden = true
       /* let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode" {
            
            
            self.view.backgroundColor = .black
            self.RequestLabel.textColor = .blue
            self.ShiftDateLAbel.textColor = .blue
            self.ShiftTimeLabel.textColor = .blue
            self.shiftRank.textColor = .blue
            self.task_name.textColor = UIColor.white
            self.shift_time.textColor = UIColor.white
            self.vol_requested.textColor = UIColor.white
            self.shift_date.textColor = UIColor.white
            
            self.starView.rating = Double(shiftdata[index!]["shift_rank"] as! String) ?? 0.0
            self.starView.isUserInteractionEnabled = false
            lightStarRating.isHidden = true
            
        }else if defaults == "Light Mode" {
            
            */
            self.view.backgroundColor = .white
            self.RequestLabel.textColor = .blue
            self.ShiftDateLAbel.textColor = .blue
            self.ShiftTimeLabel.textColor = .blue
            self.shiftRank.textColor = .blue
            self.task_name.textColor = UIColor.black
            self.shift_time.textColor = UIColor.black
            self.vol_requested.textColor = UIColor.black
            self.shift_date.textColor = UIColor.black
            
            self.lightStarRating.rating = Double(shiftdata[index!]["shift_rank"] as! String) ?? 0.0
            self.lightStarRating.isUserInteractionEnabled = false
            starView.isHidden = true
       
     //   }
        
        self.task_name.text = shiftdata[index!]["shift_task_name"] as! String
        
        var startTime = shiftdata[index!]["shift_start_time"] as! String
        var endTime = shiftdata[index!]["shift_end_time"] as! String
        var Time = "\(startTime) - \(endTime)"
       // //print(Time)
        self.shift_time.text = Time as! String
        
        RequestLabel.isHidden = false
        ShiftDateLAbel.isHidden = false
        ShiftTimeLabel.isHidden = false
        shiftRank.isHidden = false
        starView.isHidden = false
        lightStarRating.isHidden = false
        vol_requested.isHidden = false
        shift_date.isHidden = false
        shift_time.isHidden = false
        StatusLabel.isHidden = false
        StatusLabel.isHidden = false
        

        self.starView.rating = Double(shiftdata[index!]["shift_rank"]as! String ) ?? 0.0
        
        self.lightStarRating.rating = Double(shiftdata[index!]["shift_rank"]as! String ) ?? 0.0
        
        var data = shiftdata[index!]
//        self.setValues(shiftdata1:data)
        let servicehandler = ServiceHandlers()
                           servicehandler.getShiftDetails(shiftId: data["shift_id"] as! String){
                               (responce,isSuccess) in
                               if isSuccess{
                                   let data = responce as! Dictionary<String,Any>
                                   self.setValues(shiftdata1: data)
                                   
                                   
                               }
                           }
                      }
                }
