////
////  VolDashboardViewController.swift
////  ZoeBlue//print
////
////  Created by Reetesh Bajpai on 06/06/19.
////  Copyright © 2019 Reetesh Bajpai. All rights reserved.
////
//


import UIKit
import SDWebImage
import Alamofire

protocol VolunteerEventDescriptionDelgate: class {
    func shiftDetailsTapped(_ shiftDetail: [String: Any]?)
    
}

class VolDashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    struct Connectivity {
        static let sharedInstance = NetworkReachabilityManager()!
        static var isConnectedToInternet:Bool {
            return self.sharedInstance.isReachable
          }
      }
    
    @IBOutlet weak var DiscoverLabel: UILabel!
    
    
    @IBOutlet weak var NoDataView: UIView!
    
    @IBOutlet weak var NoDataLabel: UILabel!
    
    
    
    @IBOutlet weak var DiscoverInAreaView1: UIView!
    
    @IBOutlet weak var DiscoverNOEventFoundView2: UILabel!
    
    var zipcode:String!
    @IBOutlet weak var Days_counter_value: UILabel!
    @IBOutlet weak var Days_counter: UILabel!
    
    
    @IBOutlet weak var Hours_counter_value: UILabel!
    @IBOutlet weak var Hours_value: UILabel!
    
    
    @IBOutlet weak var Minute_counter_value: UILabel!
    @IBOutlet weak var Minute_counter: UILabel!
    
    
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var Seconds_counter_Value: UILabel!
    @IBOutlet weak var second_counter: UILabel!
    
    @IBOutlet weak var Table1: UITableView!
    var volunteerEventlist : [[String:Any]]?
    var DiscoverEventList : [[String:Any]]?
    var releaseDate: NSDate?
    var countdownTimer = Timer()
   
    var img:UIImageView!
    
    var scView:UIScrollView!
    let buttonPadding:CGFloat = 390
    var xOffset:CGFloat = 0
    var y:CGFloat = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        // Do any additional setup after loading the view.
        Table1.dataSource = self
        Table1.delegate = self
        
        DiscoverInAreaView1.isHidden = true
        DiscoverNOEventFoundView2.isHidden = true
       // self.refreshLoadData()
      
    }
    
    override func viewWillAppear(_ animated: Bool ) {
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
              
               if Connectivity.isConnectedToInternet {
                        self.refreshLoadData()
                     } else {
                         
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("No Internet Connection", comment: ""), preferredStyle: UIAlertController.Style.alert)
                        
                                    // add an action (button)
                                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                        // show the alert
                                    self.present(alert, animated: true, completion: nil)
                        
                    }
              
                     
                 }

    func refreshLoadData(){
        NoDataView.isHidden = true
        NoDataLabel.isHidden = true
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
               let userID = userIDData["user_id"] as! String
               //print(userID)
               let servicehandler = ServiceHandlers()
              
               servicehandler.VolunteerEventList(userData: userID as! String) { (responce, isSuccess) in
                   if isSuccess {
                       let data = responce as! Dictionary<String,Any>

                       //print(data)
  
                        self.zipcode = data["user_zipcode"] as? String
                       //print(self.zipcode)
                       self.volunteerEventlist = data["event_data"] as? [[String : Any]]
                      
                       self.Table1.reloadData()
                        self.configureCountDown()
                       self.getDiscoverEventsArea()
                   }
               }
           }
    
    @IBAction func bellIconTapped(_ sender: Any) {
        
       let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
          present(obj,animated: true)
}

    
    @IBAction func SeeAllUpcomingEvents(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "cell23") as! VolunteerUpcmingEvents
        self.present(obj, animated: true)
    }
    
    func getDiscoverEventsArea() {
        let serviceHandler = ServiceHandlers()
        serviceHandler.DiscoveringEvents(search_row_number: "0", search_keyword: "", search_page_size: "10", search_city: "", search_event_type: "", search_org: "", search_postcode: self.zipcode as? String ?? "", search_state: "")
        { (responce, isSuccess) in
            if isSuccess {
                let data = responce as! Array<Any>
                //print(data)
                self.DiscoverEventList = data as! [[String : Any]]
                //self.DiscoverLabel.text = self.DiscoverEventList![0]["event_heading"] as! String
              //reetesh 21 jan
                self.setValuestoScroll()
                }
            }
       }
  
    func setValuestoScroll(){
            
            //print(self.DiscoverEventList?.count)
           
    //        if DiscoverEventList?.count != nil{
            scView = UIScrollView(frame: CGRect(x: 0, y: 350, width: view.bounds.width, height: 145))
            view.addSubview(scView)
            
            
            scView.backgroundColor = UIColor.white
            scView.translatesAutoresizingMaskIntoConstraints = false
            var xCoordinate = 0.0
            let yCoordinate   = 0.0
            for i in 0..<DiscoverEventList!.count{
                let button = UIButton()
                button.tag = i
                button.backgroundColor = UIColor.clear
              
                button.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 170, height: 120)
                
                let strUrl  = self.DiscoverEventList![i]["event_image"] as! String
                let replacedStr = strUrl.replacingOccurrences(of: " ", with: "%20")
                button.sd_setImage(with: URL(string: replacedStr), for: .normal, completed: nil)
                button.addTarget(self, action: #selector(buttonAction), for:.touchUpInside)
                self.view.addSubview(button)
                
                
                let label = UILabel(frame: CGRect(x: xCoordinate, y: 122, width: 170, height: 21))
                label.font = UIFont.systemFont(ofSize: 12.0)
                label.textAlignment = .center
                label.text = self.DiscoverEventList![i]["event_heading"] as? String
                
                scView.addSubview(label)
                
              xCoordinate = xCoordinate + 180
                scView.addSubview(button)
                //print(button.frame)
                xOffset = CGFloat(xCoordinate)
              
            }
            scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
        
        }
    
    @objc func buttonAction(sender: UIButton!){
        //print(sender.tag)
        let a = DiscoverEventList![sender.tag]
        //print(a)
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let selectedEventVC =  mainSB.instantiateViewController(withIdentifier: "Description") as! VolunteerEventDescription
        
        selectedEventVC.eventData = a
        selectedEventVC.event_id = a["event_id"] as! String
        selectedEventVC.screen = "DISCOVER EVENTS"
        
        self.present(selectedEventVC,animated: true)
        
    }

  // Creating Countdown Timer:
    fileprivate func configureCountDown() {
        if(self.volunteerEventlist != nil){
            let shift_date = self.volunteerEventlist!.first!["shift_date"] as? String
            let shift_time = self.volunteerEventlist!.first!["shift_start_time_timer"] as? String
            let shift_date_time = shift_date! + " " + shift_time!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            let date = dateFormatter.date(from: shift_date_time)
           // dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            
            
            let releaseDateString =  dateFormatter.string(from: date!)
            let releaseDateFormatter = DateFormatter()
            releaseDateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        if (volunteerEventlist?.count) != nil
        {
            NoDataView.isHidden = true
            NoDataLabel.isHidden = true
            return 1

        }else{

            NoDataView.isHidden = false
            NoDataLabel.isHidden = false
            
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Table1.dequeueReusableCell(withIdentifier: "cell23", for: indexPath) as! VolunteerEventTableViewCell
       cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        if(volunteerEventlist != nil){
            var a = volunteerEventlist![indexPath.row]
       // //print(a)
        
            let dateString = a["shift_date"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        
        let dateObj = dateFormatter.date(from: dateString)    //date is changing into string
        
        dateFormatter.dateFormat = "dd"
        ////print("Dateobj: \(dateFormatter.string(from: dateObj!))")  // the date data is coming now to again change from from string to date
        let dated = dateFormatter.string(from: dateObj!)
        cell.lblDate.text = dated as! String
        
        
        
        dateFormatter.dateFormat = "MM"
     //   //print("Monobj: \(dateFormatter.string(from: dateObj!))")
        let Month = dateFormatter.string(from: dateObj!)  // String coming
        let mon = Int(Month)     // changing String into Int
        let month = dateFormatter.monthSymbols[mon! - 1]    // data according to array [0....12]
        let mon2:String = String(month.prefix(3))       // e.g., oct,Nov,Dec....
     //   //print(mon2)
        cell.lblMonth.text = mon2 as! String
        
        
        dateFormatter.dateFormat = "EEEE"
       // //print("Week: \(dateFormatter.string(from: dateObj!))")
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
        
        }
        return cell
            
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 82.0
}
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let a = volunteerEventlist![0]
        //print(a)

        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let selectedEventVC =  mainSB.instantiateViewController(withIdentifier: "Description") as? VolunteerEventDescription
        selectedEventVC!.data1 = a
        
        selectedEventVC!.screen = "UPCOMING EVENT"
        self.present(selectedEventVC!,animated: true)
    }

}


