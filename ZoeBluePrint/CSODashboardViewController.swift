//
//  CSODashboardViewController.swift
//  ZoeBlue//print
//
//  Created by Reetesh Bajpai on 06/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import Alamofire
import FSCalendar
import BRCountDownView
import SideMenu


class CSODashboardViewController: BaseViewController {
    
    let calendar = FSCalendar()
    @IBOutlet weak var lblCountdown: UILabel!
    @IBOutlet weak var lblUpcomingEvents: UILabel!
    
    
    
    @IBOutlet weak var sideButton: UIButton!
    @IBOutlet weak var lblcount: UIView!
    @IBOutlet weak var mangeRequest: UIButton!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    @IBOutlet weak var viewNoDataFound: UIView!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var scroller: UIScrollView!
    
    @IBOutlet weak var daysCounter_value: UILabel!
    @IBOutlet weak var counter_dayText: UILabel!
    @IBOutlet weak var counter_hoursValue: UILabel!
    @IBOutlet weak var counter_hoursText: UILabel!
    @IBOutlet weak var counter_minutesValue: UILabel!
    @IBOutlet weak var counter_minutesText: UILabel!
    @IBOutlet weak var counter_secondsValue: UILabel!
    @IBOutlet weak var counter_secondsText: UILabel!
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var dataViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mangerequest: UIButton!
    //@IBOutlet weak var requestimage: UIImageView!
     let cal = FSCalendar()
    //@IBOutlet weak var counterimage: UIImageView!
    
    
    @IBAction func menuSelected(_ sender: Any) {
        
        //print("Menu Selected")
    }
    
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    
    var upcomingEvents = [[String:Any]]()
    var calendarEvents = [[String:Any]]()
    
    var showDataViewheight:CGFloat {
        if upcomingEvents.count > 0 {
            upcomingEventsTableView.isHidden = false
            lblNoDataFound.isHidden = true
            return 76.0
        }
        upcomingEventsTableView.isHidden = true
        lblNoDataFound.isHidden = false
        return 40.0
    }
    
    
    @IBOutlet weak var upcomingEventsTableView: UITableView!
    var userCsoLogindata: Dictionary<String, Any>?
    
    @IBOutlet weak var eventCalendar: FSCalendar!
    
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()
    
    var datesWithEvent = ["2019-06-03", "2019-06-06", "2015-05-12", "2015-07-25"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        lblNoDataFound.isHidden = true
//                   viewNoDataFound.isHidden = true
        
        self.profile_pic()
        self.DataFromServer()
        
        self.calendar.reloadData()
        
        
   
        adjustDataView()
    }
    
    @IBAction func manageRequestButton(_ sender: Any) {
        
        self.ManageRequest()
    }
    
    func ManageRequest()
    {
       
     let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "request") as? CSORequest)!
        vc.strShowClose = "YES"
        self.present(vc, animated: true)
     
    }
    
    @IBAction func notification_button(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
          present(obj,animated: true)

        
//        let  eventAlert = ProjectNotificationViewController()
//
//        eventAlert.view.frame = self.view.frame
//        //eventAlert.willMove(toParent: self)
//        self.view.addSubview(eventAlert.view)
//       // self.addChild(eventAlert)
//       // eventAlert.didMove(toParent: self)
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
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        self.DataFromServer()
    }
    func DataFromServer() {
       self.upcomingEventsTableView.rowHeight = 120
                
                let appearance = UITabBarItem.appearance()
                let attributes = [NSAttributedString.Key.font:UIFont(name: "OpenSans-Semibold", size: 14)]
                appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for:.normal)
                
                //requestimage.image = UIImage(named: "request.png")
                //counterimage.image = UIImage(named: "timer.png")
                
                self.setNavigationBarHidden(toHide: true)
        self.title = "Dashboard"
                // Do any additional setup after loading the view.
                
                //print(userCsoLogindata as Any)

                let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                let userID = userIDData["user_id"] as! String
                let serviceHanlder = ServiceHandlers()
                serviceHanlder.getDashboardUpComingEventData(userData: userID as! String) { (responce, isSuccess) in
                    if isSuccess {
                        let eventData = responce as! [String: Any]
                        //print(eventData)
                        if (eventData["event_data"] == nil){
                            self.upcomingEvents = []
                        }else{
                        let eventData2 = eventData["event_data"] as! [[String:Any]]
                        //print(eventData2)
                            let calendarData2 = eventData["calendar_data"] as! [[String:Any]]
                        //print(calendarData2)
                            self.calendarEvents = calendarData2
                        self.upcomingEvents = eventData2
                      self.datesWithEvent.removeAll()
                        let names = calendarData2
                        for name in names {
                            //print(name["shift_date"] as Any)
                            self.datesWithEvent.append(name["shift_date"] as! String)
                        }
                        //print(self.upcomingEvents)
                        }
                        self.upcomingEventsTableView.reloadData()
                        self.eventCalendar.reloadData()
                         self.configureCountDown()
                        self.adjustDataView()
                    }
                }
                
                    
                
        //        counterView.layer.cornerRadius = 5.0
                configureCalander()
               
                
    }
    
    fileprivate func configureCountDown() {
        if(self.upcomingEvents.count != 0){
        let shift_date = self.upcomingEvents.first!["shift_date"] as? String
        let shift_time = self.upcomingEvents.first!["shift_start_time_timer"] as? String
        var shift_date_time = shift_date! + " " + shift_time!
       
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
         //   dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            let date = dateFormatter.date(from: shift_date_time)
           // dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: date!)
         
      let releaseDateString =  dateFormatter.string(from: date!)
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            //print(releaseDateString)
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }else{
            self.upcomingEvents = []
        }
    }
    @objc func updateTime() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
      
        let strday = "\(diffDateComponents.day ?? 00)"
        if  (strday.count < 2){
            daysCounter_value.text = "0"+strday
        }else{
             daysCounter_value.text = strday
        }
       
        // For Hours:
        let strHours = "\(diffDateComponents.hour ?? 00)"
        if(strHours.count < 2){
            counter_hoursValue.text = "0" + strHours
        }else{
           counter_hoursValue.text = strHours
        }
        
            let strMinutes = "\(diffDateComponents.minute ?? 00)"
                   if(strMinutes.count < 2){
                       counter_minutesValue.text = "0" + strMinutes
          }else{
             counter_minutesValue.text = strMinutes
          }
        
        let strSeconds = "\(diffDateComponents.second ?? 00)"
                 if(strSeconds.count < 2){
                   counter_secondsValue.text = "0" + strSeconds
        }else{
           counter_secondsValue.text = strSeconds
        }
  }
    fileprivate func configureCalander() {
        
        eventCalendar.dataSource = self
        eventCalendar.delegate = self
        
        eventCalendar.swipeToChooseGesture.isEnabled = true
        eventCalendar.backgroundColor = UIColor.white
        eventCalendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        self.eventCalendar.accessibilityIdentifier = "calendar"
       // eventCalendar.appearance.eventDefaultColor = .blue
        eventCalendar.appearance.eventDefaultColor = .blue
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = .black
            
    }
    
    func DarkMode(){
    
        view.backgroundColor = .black
        self.lblUpcomingEvents.backgroundColor = .white
        self.lblUpcomingEvents.textColor = .black
        self.lblcount.backgroundColor = .white
        
        self.mangerequest.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        self.mangerequest.backgroundColor = .white
        
        //requestimage.image = UIImage(named: "newIconInterview.png")

        self.lblCountdown.textColor = .black
        self.lblCountdown.backgroundColor = .white
        //self.counterimage.image = UIImage(named: "addShift.png")
        
        self.sideButton.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        lblNoDataFound.textColor = .white
        viewNoDataFound.backgroundColor = .black
         UITabBar.appearance().barTintColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1.0)
                    UITabBar.appearance().tintColor = .white

        
    }
    func LightMode(){
        
        view.backgroundColor = .white
        self.lblUpcomingEvents.backgroundColor = .black
        self.lblUpcomingEvents.textColor = .white
        
        self.mangerequest.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.mangerequest.backgroundColor = .black
        //requestimage.image = UIImage(named: "interview.png")
        
        self.lblCountdown.textColor = .white
        self.lblCountdown.backgroundColor = .black
        //self.counterimage.image = UIImage(named: "lightaddShift.png")
        self.sideButton.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
        
        lblNoDataFound.textColor = .black
        viewNoDataFound.backgroundColor = .white
        
        
    }
    

    func configureTableView()  {
        
    }

    func showEventsList(data:[[String:Any]]) {
        let  eventAlert = CustomDetailViewController()
        eventAlert.delegate=self
        eventAlert.view.frame = self.view.frame
        eventAlert.view.layoutIfNeeded()
        
        eventAlert.contentToShow = data
        eventAlert.willMove(toParent: self)
        self.view.addSubview(eventAlert.view)
        self.addChild(eventAlert)
        eventAlert.didMove(toParent: self)
    }
    
    func showSelectedEventDetails(selectedEventDetail:[String: Any]?)  {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        if let eventData = selectedEventDetail,  let selectedEventVC =  mainSB.instantiateViewController(withIdentifier: "CSOTodaysEventDetailsViewController") as? CSOTodaysEventDetailsViewController {
            
            
            //CSOTodaysEventDetailsViewController()
            selectedEventVC.selectedEvent = eventData
            selectedEventVC.screen = "calender"
            self.present(selectedEventVC,animated: true)

        }
        
    }
    
    func adjustDataView()  {
        dataViewHeightConstraint.constant = showDataViewheight
        self.view.layoutIfNeeded()
    }
}


extension CSODashboardViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardDetailCell", for: indexPath) as! DashboardEventsTableViewCell

        let event = upcomingEvents[indexPath.row]
        
//        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//        if defaults == "Dark Mode" {
//            
//            cell.backgroundColor = .black
//            cell.lblDate.textColor = .white
//            cell.lblDescription1.textColor = .white
//            cell.lblMonth.textColor = .white
//            cell.lblDescription2.textColor = .white
//            cell.TitleLabel.textColor = .white
//            
//        }else if defaults == "Light Mode"{
//            
//            cell.backgroundColor = .white
//            cell.lblDate.textColor = .black
//            cell.lblDescription1.textColor = .black
//            cell.lblMonth.textColor = .black
//            cell.lblDescription2.textColor = .black
//            cell.TitleLabel.textColor = .black
//        }
        
         let date = event["shift_date"] as! String
        
        let dateString = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        
        let dateObj = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd"
        //print("Dateobj: \(dateFormatter.string(from: dateObj!))")
        let dated = dateFormatter.string(from: dateObj!)
        
         dateFormatter.dateFormat = "MM"
         let monthss = dateFormatter.string(from: dateObj!)
          let monthss1 = Int(monthss)
        let month = dateFormatter.monthSymbols![monthss1!-1]
        let mon1:String =  String(month.prefix(3)) 
        //print(mon1)
        
        dateFormatter.dateFormat = "EEE"
                   //print("Week: \(dateFormatter.string(from: dateObj!))")
                   let weekday = Calendar.current.component(.weekday, from: dateObj!)
                   let week:String = dateFormatter.weekdaySymbols![weekday - 1]
                   let WD = String(week.prefix(3))
                   print(WD)
                   
        
        let event_start = event["event_register_start_date"] as! String
        let event_end = event["event_register_end_date"] as! String
        let shift_start_time = event["shift_start_time"] as! String
        let shift_end_time = event["shift_end_time"] as! String
        let labn2 = "Event Date : \(event_start) to \(event_end)"
        let taskName = event["shift_task_name"] as! String
        let labn3 = "\(taskName) : \(shift_start_time) to \(shift_end_time)"
        
        cell.lblDate.text =  "\(dated)\n\(mon1)\n\(WD)"
        cell.TitleLabel.text = event["event_heading"] as? String
       // cell.lblMonth.text = "\(mon1) \n \(WD)"
        cell.lblDescription1.text = labn2 
        cell.lblDescription2.text = labn3 
        return cell
    }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingEvents.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
        
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = upcomingEvents[indexPath.row]
        //print(event)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "CSOTodaysEventDetailsViewController") as! CSOTodaysEventDetailsViewController
        obj.event_id = event["event_id"] as! String
        obj.screen = "DASHBOARD"
        self.present(obj, animated: true)
    }
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
}

//MARK:- FSCalender Delegate & Datasource
extension CSODashboardViewController:  FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let dateString = self.dateFormatter2.string(from: date)
        
        if self.datesWithEvent.contains(dateString) {
            return 1
        }
        
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        
        //   //print("title date",date)
        
        let formater = DateFormatter()
        formater.dateFormat = "MM-dd-yyyy"
        let dateString = formater.string(from: date)
        
        if self.datesWithEvent.contains(dateString) {
            //  //print(dateString)
            var events = [[String:Any]]()
            
            //configureCalander()
            
            for eventData in self.calendarEvents{
                
                if((eventData["shift_date"]as? String) == dateString){
                    //print(eventData)
                    events.append(eventData)
                }
            }
            showEventsList(data: events)
        }
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: title!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.clear])
    }
    func calendar(_ calendar : FSCalendar , appearance : FSCalendarAppearance , titleDefaultColorFor date: Date) -> UIColor? {
        
        let defaultColor = appearance.titleDefaultColor
        
        let dateString = dateFormatter2.string(from: date)
//        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//        if defaults == "Dark Mode"{
//            if !self.datesWithEvent.contains(dateString){
//                calendar.backgroundColor = .black
//                return UIColor.white     //20
//
//            }else if self.datesWithEvent.contains(dateString){
//
//                calendar.backgroundColor = .black
//
//                return UIColor.white
//
//            }
//
//        }else if defaults == "Light Mode" {
            
            if !self.datesWithEvent.contains(dateString){
                calendar.backgroundColor = .white
                return UIColor.black
           
            }else  if self.datesWithEvent.contains(dateString) {
                
                calendar.backgroundColor = .white
                return UIColor.black
                
            }
      //  }
        
        return UIColor.black
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        self.cal.reloadData()
    }
    
    func calendar(_ Calendar : FSCalendar , appearence : FSCalendarAppearance , fillSelectionColorFor Date : Date) -> UIColor {
        
        let dateString = dateFormatter2.string(from: Date)
        
        if self.datesWithEvent.contains(dateString){
            
            return UIColor.yellow    //20
        }
        
        return UIColor.yellow
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
        //Do some checks and return whatever color you want to.
        return UIColor(red: 0.0/255.0, green: 145.0/255.0, blue: 147.0/255.0, alpha: 1.0)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let key = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(key) {
            return [UIColor(red: 0.0/255.0, green: 145.0/255.0, blue: 147.0/255.0, alpha: 1.0), appearance.eventDefaultColor, UIColor.black]
        }
        return nil
    }
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let eventScaleFactor: CGFloat = 2.0
        cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
    }
    
}





extension CSODashboardViewController:CustomDetailViewControllerDelegate {
    func eventSelected(_ eventDetail: [String : Any]?) {
        showSelectedEventDetails(selectedEventDetail: eventDetail)
    }
}
extension CSODashboardViewController:UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        
    }
 
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let csoDasboardVC = viewController as? CSODashboardViewController {
            removeAllOtherViewsOfVC(viewcontroller: csoDasboardVC)
            return true
        }
        if let csoEventVC = viewController as? CSOEventsViewController {
            removeAllOtherViewsOfVC(viewcontroller: csoEventVC)
            return true
        }
        if let csoEventVC = viewController as? volunteerSeeFollowers {
            removeAllOtherViewsOfVC(viewcontroller: csoEventVC)
            return true
        }
        if let csoEventVC = viewController as? CSOMessagingViewController {
            removeAllOtherViewsOfVC(viewcontroller: csoEventVC)
            return true
        }
        if let csoEventVC = viewController as? LockerViewController {
            removeAllOtherViewsOfVC(viewcontroller: csoEventVC)
            return true
        }
        return true
    }
    
}
func removeAllOtherViewsOfVC(viewcontroller:UIViewController)  {
    
    for vc in viewcontroller.children {
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
}


