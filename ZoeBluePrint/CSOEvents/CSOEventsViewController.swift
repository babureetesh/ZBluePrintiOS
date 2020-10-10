
//
//  CSOEventsViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 23/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit


class CSOEventsViewController: UIViewController,UITabBarDelegate,refreshData{
    func refreshDataList(flagr: Bool) {
        self.viewWillAppear(true)
        self.selectedButton = self.myEventsButton
        self.changeButtonStates(selectedButton:selectedButton!)
    }
    
    var userCsoLogindata: Dictionary<String,Any>?
    var eventList = [[String:Any]]()
    
    var selectedButton:UIButton?
    
    
    @IBOutlet weak var imgViewCsoCover: UIImageView!
    @IBOutlet weak var lbl2NotFound : UILabel!
    @IBOutlet weak var lblNoEventsFound: UILabel!
    @IBOutlet weak var viewNoEventsFound: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newEventLabl: UILabel!
    @IBOutlet weak var myEventLabl: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var addEventsView: UIView!
    @IBOutlet weak var myEventsView: UIView!
    @IBOutlet weak var newEventButton: UIButton!
    @IBOutlet weak var myEventsButton: UIButton!
    @IBOutlet weak var tableViewEventList: UITableView!
    
    @IBAction func notificationButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
        present(obj,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNoEventsFound.isHidden = true
        viewNoEventsFound.isHidden = true
        
        myEventLabl.isHidden = false
        newEventLabl.isHidden = true
        self.tabBarController?.delegate = self
        configureTableView()
        changeButtonStates(selectedButton: myEventsButton)
        //getEventList// Do any additional setup after loading the view.
        
        self.addEventsView.isHidden = true
        
        self.getEventListFromServer()
        self.getCountryList()
    }
    func profile_pic()  {
      /*  let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let params = userIDData["user_id"] as! String
        let serivehandler = ServiceHandlers()
        serivehandler.editProfile(user_id: params){(responce,isSuccess) in
            if isSuccess{
                let data = responce as! Dictionary<String,Any>
                // //print(data)
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
        }*/
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
            if let image    = UIImage(contentsOfFile: imageURL.path){
                                    self.profilePic.image = image
                                      self.profilePic.layer.borderWidth = 1
                                      self.profilePic.layer.masksToBounds = false
                                      self.profilePic.layer.borderColor = UIColor.black.cgColor
                                      self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2
                                      self.profilePic.clipsToBounds = true
            }
           // Do whatever you want with the image
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.profile_pic()
         self.imgViewCsoCover.image = UIImage(named:UserDefaults.standard.string(forKey: "csocoverpic")!)
      /*  let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode"{
            
            DarkMode()
            
            if eventList.count == 0 {
                
                viewNoEventsFound.backgroundColor = .black
                
                lblNoEventsFound.textColor = UIColor.white
                lblNoEventsFound.backgroundColor = .black
                
            }
            
            
            
        }else if defaults == "Light Mode"{
            
            LightMode()
            */
            if eventList.count == 0 {
                
                viewNoEventsFound.backgroundColor = .white
                
                lblNoEventsFound.textColor = UIColor.black
                lblNoEventsFound.backgroundColor = .white
                
            }
            
            
       // }
        
        tableViewEventList.isHidden = false
        let name = UserDefaults.standard.string(forKey: "map")
        tableViewEventList.isHidden = false
        if (name == "close"){
            
            self.tabBarController?.delegate = self
            configureTableView()
            changeButtonStates(selectedButton: myEventsButton)
            //getEventList// Do any additional setup after loading the view.
            
            self.addEventsView.isHidden = true
         
            self.getEventListFromServer()
            self.getCountryList()
        }else{
            UserDefaults.standard.set("close", forKey: "map")
        }
    }
    
    func DarkMode() {
    
        view.backgroundColor = .black
        myEventsView.backgroundColor = .black
        self.lbl2NotFound.textColor = UIColor.white
         self.lbl2NotFound.isHidden = false
        newEventButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        newEventButton.backgroundColor = .black
        
        myEventsButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        myEventsButton.backgroundColor = .black
    
        self.backButton.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        
    }
    func LightMode() {
    
     view.backgroundColor = .white
       
        newEventButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        newEventButton.backgroundColor = .white
        
        myEventsButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        myEventsButton.backgroundColor = .white
        
    }
    
    
    @IBAction func sideMenu(_ sender: Any) {
    }
    
    func getEventListFromServer(){
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        self.userCsoLogindata = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.getEventList(user_id: userCsoLogindata?["user_id"] as! String) { (responce, isSuccess) in
            if isSuccess {
                self.eventList = responce as! [[String : Any]]
                print(self.eventList)
                
                if self.eventList.count > 0 {
                    self.tableViewEventList.reloadData()
                    
                }else{
                    
                    let alert = UIAlertController(title: nil, message: NSLocalizedString("No Events Found", comment: ""), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func configureTableView() {
        let nibName = UINib(nibName: "CSOEventsMainViewTableViewCell", bundle:nil)
        tableViewEventList!.register(nibName, forCellReuseIdentifier: "CSOEventsMainViewTableViewCell")
        tableViewEventList.tableFooterView = UIView()
    }
    @IBAction func myEventsButtonsClicked(_ sender: Any) {
        if let previousSelection = selectedButton, previousSelection == myEventsButton {
            return
        }
        selectedButton = myEventsButton
        changeButtonStates(selectedButton:selectedButton!)
        newEventLabl.isHidden = true
        myEventLabl.isHidden = false
        
        
        
    }
    @IBAction func newEventButtonClicked(_ sender: Any) {

        
        // removing edit event view from my events. 
        for subVC in myEventsView.subviews {
            if subVC.tag == 100 {
                subVC.removeFromSuperview()
            }
        }
        
        if let previousSelection = selectedButton, previousSelection == newEventButton {
            return
        }
        
        
        addEventsView.isHidden = true
        
        selectedButton = newEventButton
        changeButtonStates(selectedButton:selectedButton!)
        newEventLabl.isHidden = false
        myEventLabl.isHidden = true
        lblNoEventsFound.isHidden = true
        viewNoEventsFound.isHidden = true
        
    }
    
    
    func addViewController(viewController:UIViewController)  {
        viewController.willMove(toParent: self)
        self.view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func showSelectedEventDetails(selectedEventDetail:[String: Any]?)  {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        if let eventData = selectedEventDetail,  let selectedEventVC =  mainSB.instantiateViewController(withIdentifier: "CSOTodaysEventDetailsViewController") as? CSOTodaysEventDetailsViewController {
            //CSOTodaysEventDetailsViewController()
            selectedEventVC.selectedEvent = eventData
            addViewController(viewController: selectedEventVC)
        }
        
    }
    
    func showEventActionSelectionForEvent(event:[String:Any])   {
        let  eventAlert = EventActionsViewController()
        eventAlert.delegate=self
        eventAlert.view.frame = self.view.frame
        eventAlert.view.layoutIfNeeded()
        eventAlert.eventDetail = event
        addViewController(viewController: eventAlert)
    
    }
    
    func showAddEventViewControllerWithTitle(title:String, eventDetail:[String:Any]?) {
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        if  let selectedEventVC =  mainSB.instantiateViewController(withIdentifier: "CSOAddEventViewController") as? CSOAddEventViewController {
            
            selectedEventVC.screenTitle = title
            tableViewEventList.isHidden = true
            selectedEventVC.data_refresh = self
            selectedEventVC.myeventview = myEventsView
            selectedEventVC.selectbutton = selectedButton
            selectedEventVC.myeventbtn = myEventsButton
            selectedEventVC.neweventbutton =  newEventButton
            selectedEventVC.view.tag = 100
            selectedEventVC.view.frame.size.height = myEventsView.frame.size.height
            if let eventData = eventDetail {
                selectedEventVC.eventDetail = eventData
            }
            selectedEventVC.willMove(toParent: self)
           
            if title.caseInsensitiveCompare("ADD EVENT DETAILS") == .orderedSame {
                for subVC in addEventsView.subviews {
                    if subVC.tag == 100 {
                        subVC.removeFromSuperview()
                    }
                }
                addEventsView.addSubview(selectedEventVC.view)
            } else {
                
                myEventsView.addSubview(selectedEventVC.view)
            }
            
            self.addChild(selectedEventVC)
            selectedEventVC.didMove(toParent: self)
            
            
            
            

            
            
        }
    }
    
    func changeButtonStates(selectedButton:UIButton)  {
        
        if selectedButton == myEventsButton {
            
           // if defaults == "Light Mode" {
           myEventLabl.isHidden = false
            newEventLabl.isHidden = true
            myEventsButton.isHidden = false
            newEventButton.setTitleColor(.gray, for: .normal)
            myEventsButton.setTitleColor(.black, for: .normal)
        
         //   } else if defaults == "Dark Mode" {
                
           //     newEventButton.setTitleColor(.gray, for: .normal)
             //   myEventsButton.setTitleColor(.white, for: .normal)
                
           // }
            
           
            addEventsView.isHidden = true
           myEventsView.isHidden = false
          tableViewEventList.isHidden = false
            
        } else {
            
            myEventsButton.setTitleColor(.gray, for: .normal)
            newEventButton.setTitleColor(.black, for: .normal)
            addEventsView.isHidden = false
            myEventsView.isHidden = true
            lbl2NotFound.isHidden = true
            
            showAddEventViewControllerWithTitle(title:"ADD EVENT DETAILS", eventDetail: nil)

        }
    }
    
    

    
    func checkForNilAndReturnDefaultValue(checkString:Any?, defaultValue:String) -> String {
        if let notNil = checkString as? String {
            return notNil
        }
        return defaultValue
    }
    
    func getDateFromString(dateString:Any?) -> String {
        if let dateStr = dateString as? String {
            if dateStr.components(separatedBy: "-").count > 2 {
                return dateStr.components(separatedBy: "-")[1]
            }
            return ""
        }
        return ""
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
    
    func getDayValueForDate(dateString:Any?) -> String {
        if let dateStr = dateString as? String, dateStr.count > 0 {
            if  let dateValue = Utility.getDateFromString(dateString: dateStr) {
                if let dayValue = Utility.getDayOfTheWeek(myDate: dateValue) {
                    return dayValue
                }
            }
        }
        return ""
    }
}
// Table View

extension CSOEventsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CSOEventsMainViewTableViewCell", for: indexPath) as! CSOEventsMainViewTableViewCell
        let eventData = self.eventList[indexPath.row]
        // //print(eventData)
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        if defaults == "Dark Mode"{
//
//            cell.backgroundColor = .black
//            cell.lblDay.textColor = .white
//            cell.lblDate.textColor = .white
//            cell.lblMonth.textColor = .white
//            cell.lblEventTitle.textColor = .white
//            cell.lblEvenRegistration.textColor = .white
//            cell.lbnevnetTime.textColor = .white
//
//        }else if defaults == "Light Mode"{
//
//            cell.backgroundColor = .white
//            cell.lblDay.textColor = .black
//            cell.lblDate.textColor = .black
//            cell.lblMonth.textColor = .black
//            cell.lblEventTitle.textColor = .black
//            cell.lblEvenRegistration.textColor = .black
//            cell.lbnevnetTime.textColor = .black
//
//        }
        
        cell.lblDate.text = getDateFromString(dateString: eventData["event_register_start_date"])
        cell.lblMonth.text = NSLocalizedString(getMonthFromString(monthStrin: eventData["event_register_start_date"]), comment: "")     //6th May
        cell.lblDay.text = NSLocalizedString(getDayValueForDate(dateString: eventData["event_register_start_date"]), comment: "")
        cell.lblEventTitle.text = checkForNilAndReturnDefaultValue(checkString: eventData["event_heading"], defaultValue: "")
        cell.lblEvenRegistration.text = checkForNilAndReturnDefaultValue(checkString: eventData["event_details"], defaultValue: "")
        cell.lbnevnetTime.text = NSLocalizedString("Event Time : ", comment: "") + checkForNilAndReturnDefaultValue(checkString:eventData["event_start_time_format"], defaultValue: "") + " - " + checkForNilAndReturnDefaultValue(checkString:eventData["event_end_time_format"] , defaultValue: "")
        let status  = self.checkForNilAndReturnDefaultValue(checkString: eventData["event_status"], defaultValue: "")
        if status == "10" {
            // green icon
            cell.eventActionButton.setImage(UIImage(named: "tick.png"), for: .normal)
        } else {
            // red icon
            cell.eventActionButton.setImage(UIImage(named: "close.png"), for: .normal)
        }
        
        cell.actionBlock = {
            //print( "button clicked \(indexPath.row)")
            let status  = self.checkForNilAndReturnDefaultValue(checkString: eventData["event_status"], defaultValue: "")
            if status == "10" {
                // green icon
                cell.eventActionButton.setImage(UIImage(named: "tick.png"), for: .normal)
                
                let alert = UIAlertController.init(title: NSLocalizedString("CONFIRM UNPUBLISH?", comment: ""), message: NSLocalizedString("Are you sure you want to Unpublish the Event?", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (UIAlertAction) in
                    // handle alert yes button tap
                    //user_id:String, user_type:String,user_device:String, event_id:String, action_type:String,
                    let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                    self.userCsoLogindata = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                    let serviceHanlder = ServiceHandlers()
                    serviceHanlder.publishUnpublishEvent(user_id: self.userCsoLogindata?["user_id"] as! String,user_type: "CSO", event_id:self.checkForNilAndReturnDefaultValue(checkString: eventData["event_id"], defaultValue: ""),action_type:"u" ) { (responce, isSuccess) in
                        if isSuccess {
                            let pubUnpubRes = responce as? [String: Any]
                            //  //print(pubUnpubRes!)
                            self.reloadTableData()
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "NO", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                // red icon
                cell.eventActionButton.setImage(UIImage(named: "close.png"), for: .normal)
                let alert = UIAlertController.init(title: NSLocalizedString("CONFIRM PUBLISH?", comment: ""), message: NSLocalizedString("Are you sure you want to publish the Event?", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: .default, handler: { (UIAlertAction) in
                    // handle alert yes button tap
                    
                    let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                    self.userCsoLogindata = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                    let serviceHanlder = ServiceHandlers()
                    serviceHanlder.publishUnpublishEvent(user_id: self.userCsoLogindata?["user_id"] as! String,user_type: "CSO", event_id:self.checkForNilAndReturnDefaultValue(checkString: eventData["event_id"], defaultValue: ""),action_type:"p" ) { (responce, isSuccess) in
                        if isSuccess {
                            let pubUnpubRes = responce as? [String: Any]
                            //print(pubUnpubRes!)
                            self.reloadTableData()
                            
                          /*  let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let eventDescription  = storyboard.instantiateViewController(withIdentifier: "CSOTodaysEventDetailsViewController") as! CSOTodaysEventDetailsViewController
                            self.present(eventDescription, animated: true, completion: nil)*/
                            
                            
                        }
                    }
                    
                }))
                alert.addAction(UIAlertAction(title: "NO", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.eventList.count) == 0 {
            
            lblNoEventsFound.isHidden = false
            viewNoEventsFound.isHidden = false
            
            return 0
        }else {
            
            lblNoEventsFound.isHidden = true
            viewNoEventsFound.isHidden = true
            lbl2NotFound.isHidden = true
            
            return self.eventList.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventData = self.eventList[indexPath.row]
        //  //print(eventData)
        showEventActionSelectionForEvent(event: eventData)
    }
}

extension CSOEventsViewController:CustomDetailViewControllerDelegate {
    func eventSelected(_ eventDetail: [String : Any]?) {
        // showSelectedEventDetails(selectedEventDetail: eventDetail)
    }
}

extension CSOEventsViewController:EventActionsViewControllerDelegate {
    func eventSelected(eventDetail: [String : Any]?, eventType: EventActionsViewController.SelectedEventType) {
        switch eventType {
        case .Event_Delete:
            // //print("delete")
            if (eventDetail!["event_status"] as! String) != "10"{
                let alert = UIAlertController(title: nil, message: NSLocalizedString("Are you sure you want to delete?", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: {(_alert)-> Void in
                    let serviceHanlder = ServiceHandlers()
                    serviceHanlder.deleteEvent(event_id: self.checkForNilAndReturnDefaultValue(checkString: eventDetail!["event_id"], defaultValue: "")) { (responce, isSuccess) in
                        if isSuccess {
                            let delResData = responce as! [String: Any]
                            // //print(delResData)
                            let alert = UIAlertController(title: nil, message:
                                NSLocalizedString("Delete Successfully", comment: ""), preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                            self.present(alert,animated: true)
                            self.reloadTableData()
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "NO", style: .default, handler: nil))
                self.present(alert, animated: true)
            }else{
                let alert = UIAlertController(title: nil, message: NSLocalizedString("Please Unpublish event first", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        case .Event_View:
            //  //print("view")
            showSelectedEventDetails(selectedEventDetail: eventDetail)
        case .Event_Edit:
            
            //print("edit")
            if (eventDetail!["event_status"] as! String) != "10"{

                showAddEventViewControllerWithTitle(title:"UPDATE EVENT DETAILS", eventDetail: eventDetail)
               
                
            }else{
                let alert = UIAlertController(title: nil, message: NSLocalizedString("Please Unpublish event first", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
        case .Shift_Add:
            if (eventDetail!["event_status"] as! String) != "10"{
                let mainSB = UIStoryboard(name: "Main", bundle: nil)
                if  let addShiftVC =  mainSB.instantiateViewController(withIdentifier: "CSOAddShiftViewController") as? CSOAddShiftViewController {
                    
                    addShiftVC.eventId = self.checkForNilAndReturnDefaultValue(checkString: eventDetail!["event_id"], defaultValue: "")
                    //  //print(eventDetail as Any)
                    addShiftVC.eventDetail = eventDetail!
                    addShiftVC.view.frame.size.height = (self.view.frame.size.height)
                    self.addViewController(viewController: addShiftVC)
                    
                }
                
            }else{
                let alert = UIAlertController(title: nil, message: NSLocalizedString("Please Unpublish event first", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
        case .Shift_View:
            //   //print("shift view")
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            if let shiftVC = mainSB.instantiateViewController(withIdentifier: "CSOEventShiftViewController") as? CSOEventShiftViewController, eventDetail != nil {
                NSLog("%@",eventDetail!)
                shiftVC.shiftDetails = eventDetail!
                self.present(shiftVC, animated: true)
                
                //                self.addViewController(viewController: shiftVC)
            }
        case.Event_Duplicate:
            // //print("Duplicate")
            let serviceHanlder = ServiceHandlers()
            serviceHanlder.duplicateEvent(event_id: self.checkForNilAndReturnDefaultValue(checkString: eventDetail!["event_id"], defaultValue: "")) { (responce, isSuccess) in
                if isSuccess {
                    let dupResData = responce as! [String: Any]
                    //  //print(dupResData)
                    
                    let alert = UIAlertController(title: NSLocalizedString("CONFIRM DUPLICATE ?", comment: ""), message: NSLocalizedString("Are you sure you want to duplicate the event?", comment: ""), preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ action in
                        
                        let alert = UIAlertController(title: NSLocalizedString("Success!", comment: ""), message: NSLocalizedString("Duplicate Event Created Successfully!", comment: ""), preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.getEventListFromServer()
                        
                    }))
                    alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        default:
            print("none")
        }
    }
    
    func reloadTableData() -> Void {
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        self.userCsoLogindata = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.getEventList(user_id: userCsoLogindata?["user_id"] as! String) { (responce, isSuccess) in
            if isSuccess {
                self.eventList = responce as! [[String : Any]]
                //  //print(self.eventList)
                self.tableViewEventList.reloadData()
            }
        }
    }
    
    func getCountryList()-> Void{
        
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.selectCountry() { (responce, isSuccess) in
            if isSuccess {
                let countryList = responce as? [String: Any]
                //print(countryList!)
                self.getStateList()
            }
        }
    }
    
    func getStateList()-> Void{
        
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.getStateList(country_id:"1") { (responce, isSuccess) in
            if isSuccess {
                let stateList = responce as? NSArray
                //   //print(stateList!)
                
            }
        }
        
    }
    
    
    
}
