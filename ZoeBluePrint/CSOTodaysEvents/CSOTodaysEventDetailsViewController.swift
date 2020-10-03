//
//  CSOTodaysEventDetailsViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 11/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

protocol CSOTodaysEventDetailsViewControllerDelegate: class {
    func shiftDetailsTapped(_ shiftDetail: [String: Any]?)
}

class CSOTodaysEventDetailsViewController: UIViewController {
    weak var delegate: CSOTodaysEventDetailsViewControllerDelegate?
    enum CellType:Int {
        case Description = 0
        case Address = 1
        case Phone_Number = 2
        case Email = 3
        case Start_Date = 4
        case Start_Time = 5
        
    }
    let eventDetailsCellIdentifier = "EventDetailTableViewCell"
    
    @IBOutlet weak var RatingLabel: UILabel!
    @IBOutlet weak var sideMenu: UIButton!
    @IBOutlet weak var imgViewCsoCover: UIImageView!
    @IBOutlet weak var lightStarView: FloatRatingView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventAddress: UILabel!
    
    @IBOutlet weak var whiteStar: FloatRatingView!
    @IBOutlet weak var shiftViewImage: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    var imgName:String = ""
    @IBOutlet weak var starRatingView: FloatRatingView!
    
    @IBOutlet weak var pubunpubLabel: UILabel!
    @IBOutlet weak var pubunpubImage: UIImageView!
    @IBOutlet weak var back_button: UIButton!
    
    @IBOutlet weak var buttonShift: UIButton!
    
    
    @IBOutlet weak var contentTableView: UITableView!
    var screen:String?
    var selectedEvent = [String: Any]()
    var event_id:String?
    
    override func viewWillAppear(_ animated: Bool) {
         self.imgViewCsoCover.image = UIImage(named:UserDefaults.standard.string(forKey: "csocoverpic")!)
        self.back_button.isHidden = true
        self.buttonShift.isHidden = true
        //self.shiftViewImage.isHidden = true
      
        if screen == "DASHBOARD"{
        self.back_button.isHidden = false
            pubunpubLabel.isHidden = true
            pubunpubImage.isHidden = true
            
            
            let servicehandler = ServiceHandlers()
            servicehandler.getSelectedEventDetails(eventId: event_id!){(responce,isSuccess) in
                if isSuccess{
                    self.selectedEvent = responce as! [String: Any]
                    self.setEventData()
                    self.contentTableView.reloadData()

                }
                
            }
        }else{
            self.back_button.isHidden = true
            pubunpubImage.isHidden = false
            pubunpubLabel.isHidden = false
           // print(selectedEvent["event_heading"] as! String)
            self.eventTitle.text = selectedEvent["event_heading"] as! String
            
            let string_url = selectedEvent["event_image"] as! String
                         
            let replacedStr = string_url.replacingOccurrences(of: " ", with: "%20")
            let imageUrl = URL(string: replacedStr)!
            do {
                  let imageData = try Data(contentsOf: imageUrl as URL)
                  self.eventImage.image = UIImage(data: imageData)
                } catch {
                        print("Unable to load data: \(error)")
                  }
            var status = selectedEvent["event_status"] as? String
             //print(status)
            if status == "10" {
                 
                 self.pubunpubImage.image = UIImage(named: "tick.png")
                 self.pubunpubLabel.text = "  Published"
             }else
                   if status != "10"{
                 
                 self.pubunpubImage.image = UIImage(named: "close.png")
                 self.pubunpubLabel.text = "  Unpublished"
             }
        
        }
         
        if (screen  == "calender" ){
           
            self.buttonShift.isHidden = false
            self.back_button.isHidden = false
           // self.shiftViewImage.isHidden = false
            pubunpubLabel.isHidden = true
            pubunpubImage.isHidden = true
            //self.eventTitle.text = selectedEvent["event_heading"] as! String
            self.setEventData()

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       // let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        
//        if defaults == "Dark Mode"{
//
//            DarkMode()
//         self.starRatingView.isHidden = false
//             self.lightStarView.isHidden = true
//            self.sideMenu.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
//
//        }else if defaults == "Light Mode"{
//
//            LightMode()
            self.lightStarView.isHidden = false
             self.starRatingView.isHidden = true
            // self.sideMenu.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
            
       // }
        contentTableView.estimatedRowHeight = 78.0
        contentTableView.rowHeight = UITableView.automaticDimension
        
        self.profile_pic()
//        setEventData()
   }
    
    func DarkMode() {
        
        mainView.backgroundColor = .black
//        self.lightStarView.isHidden = false
//        self.starRatingView.isHidden = true
        self.RatingLabel.textColor = .white
        self.back_button.setImage(UIImage(named: "iphoneButton.png"), for: UIControl.State.normal)
      //  self.eventTitle.textColor = .white  In future
        
    }
    func LightMode() {
        
        mainView.backgroundColor = .white
//        self.lightStarView.isHidden = true
//        self.starRatingView.isHidden = false
         self.RatingLabel.textColor = .black
       // self.eventTitle.textColor = .black  work in future
    }
    
    
    @IBAction func notificationButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
          present(obj,animated: true)
    }
    
    @IBAction func sideButton(_ sender: Any) {
    }
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBAction func showShiftTapped(_ sender: Any) {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        
        if let shiftVC = mainSB.instantiateViewController(withIdentifier: "CSOEventShiftViewController") as? CSOEventShiftViewController {
            NSLog("%@",selectedEvent)
            shiftVC.shiftDetails = selectedEvent
            self.view.addSubview(shiftVC.view)
        }
    }
    func profile_pic()  {
       
      let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let params = userIDData["user_id"] as! String
        let serivehandler = ServiceHandlers()
        serivehandler.editProfile(user_id: params){(responce,isSuccess) in
            if isSuccess{
                let data = responce as! Dictionary<String,Any>
            //  //print(data)
               
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
    @IBAction func shiftButtonFunction(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "CSOEventShiftViewController") as! CSOEventShiftViewController
        obj.calenderData = selectedEvent
        obj.screen = "calender" //reetesh jan8
        self.present(obj, animated: true)
        
    }
    
    
    func configureTableView() {
        let nibName = UINib(nibName: "EventDetailTableViewCell", bundle:nil)
        contentTableView!.register(nibName, forCellReuseIdentifier: eventDetailsCellIdentifier)
        contentTableView.tableFooterView = UIView()
    }
    
    
    func getAbsoluteStringFromSeparator(rawString:String, separator:String) -> String {
        let strComponents = rawString.components(separatedBy: separator)
        var absString = String()
        for str in strComponents {
            absString = absString + " " + str
        }
        return absString
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func setEventData()  {
        eventTitle.text = selectedEvent["event_heading"] as? String
        let addr = selectedEvent["event_address"] as? String ?? ""
        let city = selectedEvent["event_city"] as? String ?? ""
        let state = selectedEvent["event_state_name"] as? String ?? ""
        let country = selectedEvent["event_country_name"] as? String ?? ""
        let zipcode = selectedEvent["event_postcode"] as? String ?? ""
        let description = selectedEvent["event_details"] as? String ?? ""
       
        var EventRate = selectedEvent["average_rating"] as! String
       // //print(EventRate)
        
       let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if EventRate > "0" {
           // if defaults == "Light Mode"{
           
var rating = Double(selectedEvent["average_rating"] as! String) ?? 0.0
self.starRatingView.rating = rating
self.starRatingView.isUserInteractionEnabled = false
var Rate = String(format: "%.1f", rating)
var countRate = selectedEvent["event_count_rating"] as! String
self.RatingLabel.text = "Average Star Rating is \(Rate) from the Total \(countRate) Rating"

           // }else if defaults == "Dark Mode"{
                
             //   var rating = Double(selectedEvent["average_rating"] as! String) ?? 0.0
               // self.lightStarView.rating = rating
                //self.lightStarView.isUserInteractionEnabled = false
                //var Rate = String(format: "%.1f", rating)
                //var countRate = selectedEvent["event_count_rating"] as! String
                //self.RatingLabel.text = "Average Star Rating is \(Rate) from the Total \(countRate) Rating"
            //}
        }else if  EventRate < "0" {
            
             self.RatingLabel.text = "No Ratings"
            
        }
        var status = selectedEvent["event_status"] as? String
        //print(status)
       if status == "10" {
            
            self.pubunpubImage.image = UIImage(named: "tick.png")
            self.pubunpubLabel.text = "  Published"
        }else
              if status != "10"{
            
            self.pubunpubImage.image = UIImage(named: "close.png")
            self.pubunpubLabel.text = "   Unpublished"
        }
    let string_url = selectedEvent["event_image"] as! String
                 
    let replacedStr = string_url.replacingOccurrences(of: " ", with: "%20")
    let imageUrl = URL(string: replacedStr)!
    do {
          let imageData = try Data(contentsOf: imageUrl as URL)
          self.eventImage.image = UIImage(data: imageData)
        } catch {
                // //print("Unable to load data: \(error)")
          }
     }
            func formattedNumber(number: String) -> String {
             let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
             let mask = "(XXX) XXX-XXXX"

             var result = ""
             var index = cleanPhoneNumber.startIndex
             for ch in mask where index < cleanPhoneNumber.endIndex {
                 if ch == "X" {
                     result.append(cleanPhoneNumber[index])
                     index = cleanPhoneNumber.index(after: index)
                 } else {
                     result.append(ch)
                 }
             }
             return result
         }

    
}


extension  CSOTodaysEventDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var heading = String()
        var desc = String()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: eventDetailsCellIdentifier, for: indexPath) as! EventDetailTableViewCell
        
//        cell.layoutMargins = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0)
        /*let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode"{
            
            cell.backgroundColor = .black
            cell.titleLabel!.backgroundColor = . black
            cell.detailLabel.backgroundColor = .black
            cell.titleLabel!.textColor =  UIColor(red: 95.0/255.0, green: 129.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            cell.detailLabel.textColor = .white
      
        }else if defaults == "Light Mode" {
            
            cell.backgroundColor = .white
            cell.titleLabel!.backgroundColor =  .white
            cell.detailLabel.backgroundColor = .white
            cell.titleLabel!.textColor = UIColor(red: 95.0/255.0, green: 129.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            cell.detailLabel.textColor = .black
            
        }*/
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        switch indexPath.row {
        case CellType.Description.rawValue:
            let descriptionKey = "event_details"
            if let eventdescription = selectedEvent[descriptionKey]{
                heading = "Description"
                desc = eventdescription as? String ?? ""
            }
        case CellType.Phone_Number.rawValue:
            let phoneKey = "event_phone"
            if let eventPhone = selectedEvent[phoneKey]
            {
       
        heading = "Phone Number"
        desc =  self.formattedNumber(number:(selectedEvent[phoneKey] as! String))
            }
        case CellType.Start_Date.rawValue:
            let phoneKey = "event_register_start_date"
            let phoneKey2 = "event_register_end_date"
            if let eventPhone = selectedEvent[phoneKey] {
                if let eventPhone2 = selectedEvent[phoneKey2]{
                heading = "Date"
                  
                desc = (eventPhone as? String ?? "") + " - " + (eventPhone2 as? String ?? "")
                }
            }
        case CellType.Email.rawValue:
            let phoneKey = "event_email"
            if let eventPhone = selectedEvent[phoneKey] {
                heading = "Email"
                desc = eventPhone as? String ?? ""
                

                
            }
        case CellType.Address.rawValue:
            let phoneKey = "event_address"
            let phoneKey2 = "event_city"
            let phoneKey3 = "event_state_name"
            let phoneKey4 = "event_country_name"
            let phoneKey5 = "event_postcode"
            if let eventPhone = selectedEvent[phoneKey] {
                if let eventPhone2 = selectedEvent[phoneKey2]{
                    if let eventPhone3 = selectedEvent[phoneKey3]{
                        if let eventPhone4 = selectedEvent[phoneKey4]{
                            if let eventPhone5 = selectedEvent[phoneKey5]{
                                heading = "Address"
                                
        let desc1 = (eventPhone as? String ?? "") + ", " + (eventPhone2 as? String ?? "")
        let desc2 = (eventPhone3 as? String ?? "") + ", " + (eventPhone4 as? String ?? "")
        let desc3 = (eventPhone5 as? String ?? "")
                                desc = desc1 + ", " + desc2 + ", "  + desc3
                    }
                        }
                        
                    }
                }
            }
       
        case CellType.Start_Time.rawValue:
             
            let phoneKey = "event_start_time_format"
            let phoneKey2 = "event_end_time_format"
            
            if let eventPhone = selectedEvent[phoneKey] {
                if let eventPhone2 = selectedEvent[phoneKey2]{
                           heading = "Time"
                    
                           desc = (eventPhone as? String ?? "") + " - " + (eventPhone2 as? String ?? "")
                }
                       }
            
        default:
          print("Not Mentioned")
        }
        
        cell.titleLabel.text = heading
        cell.detailLabel.text  = desc
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
//        tableView.layoutMargins = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}

