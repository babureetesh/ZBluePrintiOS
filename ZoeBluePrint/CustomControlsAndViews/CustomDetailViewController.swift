//
//  CustomDetailViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 18/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
protocol CustomDetailViewControllerDelegate: class {
    func eventSelected(_ eventDetail: [String: Any]?)
}

class CustomDetailViewController: UIViewController {
    weak var delegate: CustomDetailViewControllerDelegate?
    let cellIdentifier = "CustomDetailTableViewCell"
    
    @IBOutlet weak var eventView: UIView!
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentTableView: UITableView!
    var contentToShow = [[String:Any]]()
    var strFromVolCal : String = ""
    
    var screen:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.isOpaque = false
        view.backgroundColor = .clear
        // Do any additional setup after loading the view.
        configureTableView()
        
        
        
    }
    
    func configureTableView() {
        let nibName = UINib(nibName: "CustomDetailTableViewCell", bundle:nil)
        contentTableView!.register(nibName, forCellReuseIdentifier: cellIdentifier)
        contentTableView.tableFooterView = UIView()
    }

    func removeMeNow(selectedEvent:[String: Any]?)  {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        
        delegate?.eventSelected(selectedEvent)
        
    }
    @IBAction func viewTapped(_ sender: Any) {
        
        removeMeNow(selectedEvent: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var heightConstraint = contentViewHeightConstraint.constant
        
        if contentToShow.count < 2 {
            heightConstraint = heightConstraint - 40
            contentViewHeightConstraint.constant = heightConstraint
            self.view.layoutIfNeeded()
        }
        
    }
    func DarkMode(){
        
        
eventView.backgroundColor = UIColor(red: 66.0/255.0, green: 66.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        
    }
    func LightMode(){
        
        eventView.backgroundColor = .white
    }

}

extension CustomDetailViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentToShow.count > 0 ? contentToShow.count : 0 
    }
    func getDayOfWeek(_ today:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        switch weekDay {
        case 1:
             return "Sun"
        case 2:
             return "Mon"
        case 3:
             return "Tue"
        case 4:
             return "Wed"
        case 5:
             return "Thu"
        case 6:
         return "Fri"
        case 7:
             return "Sat"
        default:
             return "Not Find"
        }
    
    }
    
    func getMonthFromString(monthStrin:Any?) -> String {
        if let monthStr = monthStrin as? String {
            if monthStr.components(separatedBy: "-").count > 2 {
                if let monthNumber:Int = Int (monthStr.components(separatedBy: "-")[0] )  {
                    return Utility.getShortMonthString(monthNumber: monthNumber)
                }
            }
            return ""
        }
        return ""
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomDetailTableViewCell
         let contents = contentToShow[indexPath.row]
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
//        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//        if defaults == "Dark Mode"{
//
//            cell.backgroundColor = UIColor(red: 66.0/255.0, green: 66.0/255.0, blue: 66.0/255.0, alpha: 1.0)
//            cell.monthLabel.textColor = .white
//            cell.dateLabel.textColor = .white
//            cell.dateTimeLabel.textColor = .white
//            cell.titleLabel.textColor = .white
//            cell.lableDescription.textColor = .white
//            cell.dayLabel.textColor = .white
//
//            }else if defaults == "Light Mode" {
//
//            cell.backgroundColor = .white
//            cell.monthLabel.textColor = .black
//            cell.dateLabel.textColor = .black
//            cell.dateTimeLabel.textColor = .black
//            cell.titleLabel.textColor = .black
//            cell.lableDescription.textColor = .black
//            cell.dayLabel.textColor = .black
//
//
//        }
      
if strFromVolCal == "VOL"{//---------------------------VOL------------------------------
        cell.monthLabel.text = getMonthFromString(monthStrin: contents["shift_date"]) //1
    
          let dateString = contents["shift_date"] as! String
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            dateFormatter.locale = Locale.init(identifier: "en_GB")
            
            let dateObj = dateFormatter.date(from: dateString)    //date is changing into string
            
            dateFormatter.dateFormat = "dd"
            let dated = dateFormatter.string(from: dateObj!)
           print(dated)
            cell.dateLabel.text = dated  //2
   // cell.lblCommentRemark.isHidden = true
    if (contents["map_status"] as! String) == "90" {
        cell.dateTimeLabel.text = "Not Available"
    }else if ((contents["map_status"] as! String) == "70"){
        cell.dateTimeLabel.text = "Verified" + "\n\(contents["map_rank_comment"] as! String)"
//cell.lblCommentRemark.isHidden = false
        //cell.lblCommentRemark.text = (contents["map_rank_comment"] as! String)
    }else if ((contents["map_status"] as! String) == "10"){
        cell.dateTimeLabel.text = "Pending"
    }else if ((contents["map_status"] as! String) == "20"){
        cell.dateTimeLabel.text = "Accepted"
    }else if ((contents["map_status"] as! String) == "30"){
        cell.dateTimeLabel.text = "Decline"
    }else if ((contents["map_status"] as! String) == "40"){
        cell.dateTimeLabel.text = "Complete"
    }else if ((contents["map_status"] as! String) == "50"){
        cell.dateTimeLabel.text = "More Information"
    }else if ((contents["map_status"] as! String) == "51"){
        cell.dateTimeLabel.text = "More Information"
    }else if ((contents["map_status"] as! String) == "60"){
        cell.dateTimeLabel.text = "Rejected" + "\n\(contents["map_status_comment"] as! String)"
         //cell.lblCommentRemark.isHidden = false
        //cell.lblCommentRemark.text = (contents["map_status_comment"] as! String)
    }
    
    
    
            
            if ((contents["map_status"] as! String) == "70" || (contents["map_status"] as! String) == "90" ) {
                
               var strRank = contents["map_rank_comment"] as? String ?? ""
                              if (strRank.count>0){
                                  strRank = "Rank : " + strRank
                                 // cell.dateTimeLabel.text = strRank //3
                              }else{
                               //cell.dateTimeLabel.text = ""
                              }
                
               
                var heading = contents["event_heading"] as! String
                         //  //print(heading)
                cell.titleLabel.text = heading   //4
                                       
        cell.lableDescription.text = "\(contents["shift_start_time"] as?  String ?? "") - \(contents["shift_end_time"] as?  String ?? "")"   //5
                                            
        let weekDay = getDayOfWeek(contents["shift_date"] as! String)!
        cell.dayLabel.text = weekDay as? String ?? ""  //6

       
    }else if(contents["map_status"] as! String) == nil || (contents["map_status"] as! String) == "40" {
                
       // cell.dateTimeLabel?.isHidden = true
                
                
        var heading = contents["event_heading"] as! String
       // //print(heading)
        cell.titleLabel.text = heading
                                       
    cell.lableDescription.text = "\(contents["shift_start_time"] as?  String ?? "") - \(contents["shift_end_time"] as?  String ?? "")"
                                            
        let weekDay = getDayOfWeek(contents["shift_date"] as! String)!
        cell.dayLabel.text = weekDay as? String ?? ""
           
}else{
          //      cell.dateTimeLabel?.isHidden = true
                
              var heading = contents["event_heading"] as! String
                  //  //print(heading)
                    cell.titleLabel.text = heading
                                                   
                cell.lableDescription.text = "\(contents["shift_start_time"] as?  String ?? "") - \(contents["shift_end_time"] as?  String ?? "")"
                                                        
                    let weekDay = getDayOfWeek(contents["shift_date"] as! String)!
                    cell.dayLabel.text = weekDay as? String ?? ""
    }
    
}else{
    //--------------------------------------"CSO"---------------------------------------------------
         
            let monthString = contents["mn"] as? String ?? "0" // for CSO
                   let a:Int? = Int(monthString)
                   
                   let month =  Utility.getShortMonthString(monthNumber:a ?? 0)
    
    print(month)
                   cell.monthLabel.text = month
    
    

                   cell.dateLabel.text = contents["dt"] as? String ?? ""
    
    cell.lableDescription.text = contents["shift_task_name"] as? String ?? ""
        cell.titleLabel.text = contents["event_heading"] as? String ?? ""
      
        cell.dateTimeLabel.text = "Time : \(contents["shift_start_time"] as?  String ?? "") - \(contents["shift_end_time"] as?  String ?? "")"
        let weekDay = getDayOfWeek(contents["shift_date"] as! String)!
        cell.dayLabel.text = weekDay as? String ?? ""
        }
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // //print(contentToShow[indexPath.row])
        if strFromVolCal == "VOL"{
         
            self.removeMeNow(selectedEvent: contentToShow[indexPath.row])
            
        }
        else{
         let content = contentToShow[indexPath.row]
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.getSelectedEventDetails(eventId: content["event_id"] as? String ?? "") { (responce, isSuccess) in
            if isSuccess {
                var eventData = responce as! [String: Any]
               // //print(eventData)
               // eventData.setValue(content, forKey: "shiftdata")
                eventData.updateValue(content, forKey: "shiftdata")
                self.removeMeNow(selectedEvent: eventData)
            }
        }
        }
    }

   
    
}
