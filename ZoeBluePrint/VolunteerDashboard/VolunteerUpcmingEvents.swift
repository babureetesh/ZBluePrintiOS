//
//  VolunteerUpcmingEvents.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 07/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolunteerUpcmingEvents: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var VolunteerList: UITableView!
      var volunteerEvent : [[String:Any]]!
    
    
    @IBOutlet weak var profilepic: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let userID = userIDData["user_id"] as! String
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.VolunteerEventList(userData: userID as! String) { (responce, isSuccess) in
            if isSuccess {
                let data = responce as! [String: Any]
                if data["event_data"] != nil{
                //print(data)
                self.volunteerEvent = data["event_data"] as! [[String : Any]]
                self.VolunteerList.reloadData()
                }else{
                    let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: {(_alertCOntroller)-> Void in
                        self.dismiss(animated: true, completion: nil)
                        
                    }))
                    self.present(alert,animated: true)
                }
            }
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
          let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                            let userID = userIDData["user_id"] as! String
                                          //print(userID)
                          
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (volunteerEvent != nil)
        {
            return volunteerEvent!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = VolunteerList.dequeueReusableCell(withIdentifier: "Events", for: indexPath) as! VolunteerUpcomingTableViewCell
        
        
        var a = volunteerEvent[indexPath.row]
        
        let dateString = a["shift_date"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        
        let dateObj = dateFormatter.date(from: dateString)    //date is changing into string
        
        dateFormatter.dateFormat = "dd"
        //print("Dateobj: \(dateFormatter.string(from: dateObj!))")  // the date data is coming now to again change from from string to date
        let dated = dateFormatter.string(from: dateObj!)
        cell.lblDate.text = dated as! String
        
        
        
        dateFormatter.dateFormat = "MM"
        //print("Monobj: \(dateFormatter.string(from: dateObj!))")
        let Month = dateFormatter.string(from: dateObj!)  // String coming
        let mon = Int(Month)     // changing String into Int
        let month = dateFormatter.monthSymbols[mon! - 1]    // data according to array [0....12]
        let mon2:String = String(month.prefix(3))       // e.g., oct,Nov,Dec....
        //print(mon2)
        cell.lblMonth.text = mon2 as! String
        
        
        dateFormatter.dateFormat = "EEEE"
        //print("Week: \(dateFormatter.string(from: dateObj!))")
        let weekday = Calendar.current.component(.weekday, from: dateObj!)
        let week:String = dateFormatter.weekdaySymbols![weekday - 1]
        //print(week)
        //        a.weekdaySymbols[Calendar.current.component(.weekday, from: dateObj)]
        cell.WeekLabel.text = week as! String
        cell.Title.text = a["event_heading"] as! String
        
        var start = a["event_register_start_date"] as! String
        var end = a["event_register_end_date"] as! String
        var Date = "Event Date: \(start) to \(end)"
        //print(Date)
        cell.DescriptionLabel.text = Date as! String
        
        var task_name = a["shift_task_name"] as! String
        var start_time = a["shift_start_time"] as! String
        var end_time = a["shift_end_time"] as! String
        var time = "\(task_name): \(dateString) - \(start_time) to \(end_time)"
        //print(time)
        cell.Description2.text = time as! String
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 88.0

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
    
    
    @IBAction func bellbutton(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "notify") as! VolunteerNotificationViewController
               self.present(obj, animated: true)
    }
    
    
    @IBAction func backbutton(_ sender: Any) {
        
    dismiss(animated: true, completion: nil)
        
    }
    
}
