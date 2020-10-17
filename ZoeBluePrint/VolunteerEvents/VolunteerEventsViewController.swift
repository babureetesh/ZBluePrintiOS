//
//  VolunteerEventsViewController.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 23/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import FSCalendar
import  Alamofire
import SendBirdSDK
class VolunteerEventsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate, UITabBarControllerDelegate{
   
    
    
    struct Connectivity {
         static let sharedInstance = NetworkReachabilityManager()!
         static var isConnectedToInternet:Bool {
             return self.sharedInstance.isReachable
           }
       }

    @IBOutlet weak var btnSearchCategory: UIButton!
    var check = false
    var SelectData:Dictionary<String,Any>?
     var calendarEvents = [[String:Any]]()
    @IBOutlet weak var Table1: UITableView!
    @IBOutlet weak var eventStatusViewHeightContraint:NSLayoutConstraint!
    var SearchList : [[String:Any]]?
    var FilterList : [[String:Any]]?
    
     
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var bookButtonTapped: UIButton!
  
    var upcomingEvents = [[String:Any]]()
     var datesWithEvent = ["2019-06-03", "2019-06-06", "2015-05-12", "2015-07-25"]
   
    let cal = FSCalendar()
    
    
   @IBOutlet weak var lblBlankOutTime: UILabel!
    @IBOutlet weak var statusMainStackView: UIStackView!
    
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var lblBlankInTime: UILabel!
    
    @IBOutlet weak var lblBlank2: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var lblBlank: UILabel!
    
    @IBOutlet weak var imageDisshifts: UIImageView!
    
    @IBOutlet weak var imageDisEvents: UIImageView!
    //@IBOutlet weak var lblHeadingName: UILabel!
    
    
     @IBOutlet weak var eventStatus_CurrentStatusView: UIControl!
     @IBOutlet weak var eventStatus_WithdrawView: UIControl!
     @IBOutlet weak var eventStatus_MarkCompleteView: UIControl!
     @IBOutlet weak var eventStatus_ChatView: UIControl!
    
    
    
    @IBOutlet weak var SearchField: UISearchBar!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var BookLabel: UILabel!
    @IBOutlet weak var DiscoverEventsTapped: UIButton!
    @IBOutlet weak var lblEnterClickInOut: UILabel!
    @IBOutlet weak var lblUpdateHrs: UILabel!
    @IBOutlet weak var lblClockOutTime: UILabel!
    @IBOutlet weak var lblClockInTime: UILabel!
    @IBOutlet weak var lblchangeStatusTo: UILabel!
    @IBOutlet weak var lblCurrentStatus: UILabel!
    @IBOutlet weak var lblMyBooking: UILabel!
    @IBOutlet weak var lblView: UIView!
    @IBOutlet weak var lblMyCSOEvents: UILabel!
    @IBOutlet weak var ViewChangeStatusBackground: UIView!
    @IBOutlet weak var ViewChangeStatusPoMain: UIView!
    @IBOutlet weak var ChangeStatusTapped: UIButton!
    @IBOutlet weak var viewButtonTapped: UIButton!
    @IBOutlet weak var InTime: UIButton!
    @IBOutlet weak var OutTime: UIButton!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var StatsView1: UIView!
    @IBOutlet weak var statusview2: UIView!
    @IBOutlet weak var CurrentImage: UIImageView!
    @IBOutlet weak var CurrentStatusName: UILabel!
    @IBOutlet weak var DiscoverShiftView: UIButton!
    @IBOutlet weak var EventShiftView1: UIView!
    @IBOutlet weak var DiscoverEventView: UIButton!
    @IBOutlet weak var EventShiftView2: UIView!
    @IBOutlet weak var DiscoverLabel: UILabel!
    @IBOutlet weak var searchTab: UISearchBar!
    @IBOutlet weak var currentStatusImage: UIImageView!
    @IBOutlet weak var currentstatusName: UILabel!
    @IBOutlet weak var Label1 : UILabel!
   @IBOutlet weak var Label2 : UILabel!
   @IBOutlet weak var Label3 : UILabel!
   @IBOutlet weak var Label4 : UILabel!
   @IBOutlet weak var profilepic: UIImageView!
    
    @IBOutlet weak var currentAccepted : UIButton!    // leave
    @IBOutlet weak var markCompleted: UIButton!        // leave
    @IBOutlet weak var chat: UIButton!                  // leave
    @IBOutlet weak var withdraw: UIButton!               // leave
    @IBOutlet weak var btnMoreInfo: UIButton!
    
    @IBOutlet weak var changeacceptImage: UIImageView!       // acceptImag
    @IBOutlet weak var completedImage: UIImageView!          // decline
    @IBOutlet weak var chatImage: UIImageView!               // verified
    @IBOutlet weak var withdrawImage: UIImageView!             // reject
    @IBOutlet weak var moreinfoimage: UIImageView!
    @IBOutlet weak var lblCSOEvents: UIButton!
//    @IBOutlet weak var UpdateView1: UIView!
    @IBOutlet weak var updateView2: UIView!
    var strFromScreen : String!
    var screen:String!
    @IBOutlet weak var InTimeField: UITextField!
    @IBOutlet weak var OutTimeField: UITextField!
    var boolInTimeselected = true
    @IBOutlet weak var timePickeSelected: UIDatePicker!
    @IBOutlet weak var changestatusLabel: UILabel!
    
    var map_status: String!
    var floatYcoordinateView2: CGFloat!
    var floatHeightView2: CGFloat!
    var strSearchCategorySel: String!
    var strPostalCode: String!
    @IBOutlet weak var imgViewCover: UIImageView!
    
    
    
    
    fileprivate func presentWithNavigationController(viewController:UIViewController) {
//        let navController = UINavigationController(rootViewController: viewController)
//
//        navController.navigationBar.isHidden = true
//        navController.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func changeStatusBtnClick(_ sender: Any) {
        
       
        
        let button = sender as! UIButton
        //print(button.tag)
        
        if button.tag == 0{
            //print("Withdraw")
            self.map_status = "90"
            self.ChangeStatusSelection()
            
            
        }else if button.tag == 1{
           //print("Mark Completed")
            
            statusMainStackView.isHidden = true
//            UpdateView1.isHidden = false
            updateView2.isHidden=false
            self.map_status = "40"
            PreFilledData() // Show Withdraw view
//
            
        }else if button.tag == 2{
                   
                    let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                                let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                                let userEmail = userIDData["user_email"] as! String
                                let userFullName = "\(userIDData["user_f_name"]as! String)\(" ")\( userIDData["user_l_name"]as! String)"
                
            ActivityLoaderView.startAnimating()
                             SBDMain.connect(withUserId: userEmail) { (user, error) in
                                       guard error == nil else {   // Error.
                                           return
                                         ActivityLoaderView.stopAnimating()
                                       }
                                 //print(user?.userId as Any)
                                       //print(user?.nickname)
                                       //print(user?.profileUrl)
                                ActivityLoaderView.stopAnimating()
                                     SBDGroupChannel.createChannel(withName: userFullName, isDistinct: true, userIds: [ userEmail ], coverUrl: nil, data: nil, customType: nil, completionHandler: { (groupChannel, error) in
                                            guard error == nil else {   // Error.
                                                return
                                            }
                                            let vc = GroupChannelChatViewController.init(nibName: "GroupChannelChatViewController", bundle: nil)
                                                   vc.channel = groupChannel
                                                   vc.hidesBottomBarWhenPushed = true
                                        vc.modalPresentationStyle = .overFullScreen
                                        self.present(vc,animated: true)
                                           // self.ChangeStatusSelection()
                                //
                                //            //print("Chat")
                                           })
                             }
            
            
        }else if button.tag == 3{

            
            //print("Accept")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SearchList == nil
        {
            return 0
            
        }else
        {
            
            return SearchList!.count
            
        }
        
    }
    func DataFromServer() {
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Table1.dequeueReusableCell(withIdentifier: "DiscoverEvents", for: indexPath) as! VolunteerEventsTableViewCell
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        
        Table1.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0)
//        if defaults == "Dark Mode"{
//
//            cell.backgroundColor = UIColor.black
//            cell.TitleLabel.textColor = .white
//            cell.DescriptionLabel.textColor = .white
//            cell.DateLabel.textColor = .white
//             cell.DLabel.textColor = .white
//            cell.MonthLabel.textColor = .white
//             cell.WeekLabel.textColor = .white
//
//        }else if defaults == "Light Mode"{
//
//            cell.backgroundColor = UIColor.white
//            cell.TitleLabel.textColor = .black
//            cell.DescriptionLabel.textColor = .black
//            cell.DateLabel.textColor = .black
//            cell.DLabel.textColor = .black
//            cell.MonthLabel.textColor = .black
//            cell.WeekLabel.textColor = .black
//
//        }
        if(SearchList?.count != 0){
            var a = SearchList![indexPath.row]
            //print(a)
            
            cell.TitleLabel.text = a["event_heading"] as! String
            cell.DescriptionLabel.text = a["event_details"] as! String
            
            
            var start_time = a["event_start_time_format"] as! String
            var end_time = a["event_end_time_format"] as! String
            var time = "Event Time : \(start_time) -  \(end_time)"
            //print(time)
            cell.DateLabel.text = time as! String
            
            let dateString = a["event_register_start_date"] as! String
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            dateFormatter.locale = Locale.init(identifier: "en_GB")
            
            let dateObj = dateFormatter.date(from: dateString)    //date is changing into string
            
            dateFormatter.dateFormat = "dd"
            //print("Dateobj: \(dateFormatter.string(from: dateObj!))")  // the date data is coming now to again change from from string to date
            let dated = dateFormatter.string(from: dateObj!)
            cell.DLabel.text = dated as! String
            
            dateFormatter.dateFormat = "MM"
            //print("Monobj: \(dateFormatter.string(from: dateObj!))")
            let Month = dateFormatter.string(from: dateObj!)  // String coming
            let mon = Int(Month)     // changing String into Int
            let month = dateFormatter.monthSymbols[mon! - 1]    // data according to array [0....12]
            let mon2:String = String(month.prefix(3))       // e.g., oct,Nov,Dec....
            //print(mon2)
            cell.MonthLabel.text = mon2 as! String
            
            
            dateFormatter.dateFormat = "EEE"
            //print("Week: \(dateFormatter.string(from: dateObj!))")
            let weekday = Calendar.current.component(.weekday, from: dateObj!)
            let week:String = dateFormatter.weekdaySymbols![weekday - 1]
            let WD = String(week.prefix(3))
            //print(WD)
            cell.WeekLabel.text = WD as! String
            
            
        }
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        EventShiftView1.isHidden = false
        EventShiftView2.isHidden = false
        self.SelectData = SearchList![indexPath.row] as! Dictionary<String,Any>
    }
    func showEventsList(data:[[String:Any]]) {
        let  eventAlert = CustomDetailViewController()
        eventAlert.delegate = self as CustomDetailViewControllerDelegate
        eventAlert.view.frame = self.view.frame
        eventAlert.view.layoutIfNeeded()
        eventAlert.strFromVolCal="VOL"
        eventAlert.contentToShow = data
        eventAlert.willMove(toParent: self)
        eventAlert.view.tag = 99
        self.view.addSubview(eventAlert.view)
        self.addChild(eventAlert)
        eventAlert.didMove(toParent: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
    @IBAction func notificationBellTapped(_ sender: Any) {
           
          let sb = UIStoryboard(name: "Main", bundle: nil)
           let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
             present(obj,animated: true)
       }
    
    func DarkMode() {
    
        
        self.view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        
        self.View2.backgroundColor = .black
        
        self.DiscoverEventsTapped.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        self.lblEnterClickInOut.textColor = .white
        
        self.lblClockOutTime.textColor = .white
        
        self.lblClockInTime.textColor = .white
        
        self.lblView.backgroundColor = .black
       
        self.lblMyCSOEvents.textColor = .white
        
        self.InTime.setTitleColor(UIColor.white, for: UIControl.State.normal)
        InTime.backgroundColor = .black
        
        OutTime.backgroundColor = .black
        self.OutTime.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        self.bookButtonTapped.setTitleColor(UIColor.white, for: UIControl.State.normal)
       
        
        self.DiscoverShiftView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.DiscoverShiftView.backgroundColor = .black
        self.imageDisshifts.image = UIImage(named: "lighteye-open.png")
        
        self.lblBlank.backgroundColor = UIColor.darkGray
        
        self.viewButtonTapped.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.viewButtonTapped.backgroundColor = .black
        self.imageView.image = UIImage(named: "lighteye-open.png")
        
        self.ChangeStatusTapped.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.ChangeStatusTapped.backgroundColor = .black
        self.imageStatus.image = UIImage(named: "")
        
        self.currentstatusName.textColor = .white
        
        self.statusview2.backgroundColor = .black
        
        self.withdraw.setTitleColor(UIColor.white, for: UIControl.State.normal)
        withdraw.backgroundColor = .black
        self.Label1.backgroundColor = UIColor.darkGray
        
        self.markCompleted.setTitleColor(UIColor.white, for: UIControl.State.normal)
        markCompleted.backgroundColor = .black
        self.Label2.backgroundColor = UIColor.darkGray
        
        self.chat.setTitleColor(UIColor.white, for: UIControl.State.normal)
        chat.backgroundColor = .black
        self.Label3.backgroundColor = UIColor.darkGray
        
        self.currentAccepted.setTitleColor(UIColor.white, for: UIControl.State.normal)
            currentAccepted.backgroundColor = .black
        
        self.updateView2.backgroundColor = .black
       self.lblBlankInTime.backgroundColor = .white
        self.lblBlankOutTime.backgroundColor = .white
        self.timeView.backgroundColor = .black
    
        timePickeSelected.setValue(UIColor.white, forKeyPath: "textColor")
        //self.lblCSOEvents.borderColor = .white
       // self.lblCSOEvents.borderWidth = 3.0
        
        ViewChangeStatusPoMain.backgroundColor = .black
        imageStatus.image = UIImage(named: "lightThemePencil.png")
        
        self.btnList.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        
      self.DiscoverEventView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.DiscoverEventView.backgroundColor = .black
        self.imageDisEvents.image = UIImage(named: "lighteye-open.png")
        
    }
    func LightMode() {
        
        self.OutTime.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.InTime.setTitleColor(UIColor.white, for: UIControl.State.normal)
         self.lblMyCSOEvents.textColor = .white
         self.lblView.backgroundColor = .white
        self.lblClockInTime.textColor = .white
        self.lblClockOutTime.textColor = .white
        self.lblEnterClickInOut.textColor = .white
        self.DiscoverEventsTapped.setTitleColor(UIColor.black, for: UIControl.State.normal)
         self.bookButtonTapped.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.View2.backgroundColor = .black
        self.view.backgroundColor = .white
        ViewChangeStatusPoMain.backgroundColor = .white
        
        self.btnList.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
        

    }
    
    func ChangeStatusSelection(){
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                               let user_id = userIDData["user_id"] as! String
             
                let params = ["user_id": user_id,
                "user_type" : "VOL",
                "user_device" : UIDevice.current.identifierForVendor!.uuidString,
                "map_id": SelectData!["map_id"],
                "map_status": self.map_status]
              
                let servicehandler = ServiceHandlers()
                servicehandler.changeStatus(data_details: params){(responce,isSuccess) in
                    if isSuccess{
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("Status change Successfully", comment: ""), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: {(_alert)->Void in
                            self.statusview2.isHidden = true
                            self.StatsView1.isHidden = true
                            self.statusMainStackView.isHidden = true
                            self.refreshLoadData()
        //                    self.tblViewforAllRequest.reloadData()
                        }))
                        self.present(alert,animated: true)
                    }
                }
    }
    
   fileprivate lazy var dateFormatter2: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "MM-dd-yyyy"
          return formatter
      }()
     
    fileprivate func configureCalander() {
          
          calendar.dataSource = self
          calendar.delegate = self
          
          calendar.swipeToChooseGesture.isEnabled = true
         calendar.backgroundColor = UIColor.white
         calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
          self.calendar.accessibilityIdentifier = "calendar"
         // eventCalendar.appearance.eventDefaultColor = .blue
          calendar.appearance.eventDefaultColor = .blue
      }
    let EventList : Array<Any>! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSearchCategory.setDropDownImagWithInset()
        self.strSearchCategorySel = "Postal Code"
        Table1.estimatedRowHeight = 109.0
        Table1.rowHeight = UITableView.automaticDimension
        Table1.tableFooterView = UIView(frame: .zero)
        self.tabBarController?.delegate = self
     
        self.DiscoverEventsTapped.setTitleColor(UIColor.gray, for: UIControl.State.normal)
 
        
        let mytapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(handleTap3(_:)))
        self.searchTab.delegate = self
        timeView.isHidden = true
        floatYcoordinateView2 = CGFloat(View2.frame.origin.y)
        floatHeightView2 = CGFloat(View2.frame.size.height)
      }
    
    
    @IBAction func csoEvents(_ sender: Any) {
        self.searchTab.text = ""
        
 if check {
           lblCSOEvents.setImage(UIImage(named: "black-square-png.png"), for: .normal)
           check = false
          
    let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                         let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                        let user_id = userIDData["user_id"] as! String
                    let data = ["user_id": user_id,
                                  "seach_row_number" : "0",
                                  "search_page_size" : "30",
                                  "search_city": "",
                                  "search_state":"",
                                  "search_org":"",
                                  "search_postcode" :"",
                                  "search_event_type" :"",
                                  "search_my_cso" :"0",
                                  "search_keyword":""]
                      print(data)
               let servicehandler = ServiceHandlers()
               servicehandler.FilterEvents(params: data) { (responce, isSuccess) in
                      if isSuccess{
                       let data = responce as! Array<Any>
                       //print(data)
                         self.FilterList = data as! [[String : Any]]
                       //print(self.FilterList)
                 self.SearchList = self.FilterList
                       self.Table1.reloadData()
                      //print(self.SearchList)
                }
              }
        }else{
          lblCSOEvents.setImage(UIImage(named: "newtickbox.png"), for: .normal)
           check = true
           
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                      let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                     let user_id = userIDData["user_id"] as! String

                 let data = ["user_id": user_id,
                               "seach_row_number" : "0",
                               "search_page_size" : "30",
                               "search_city": "",
                               "search_state":"",
                               "search_org":"",
                               "search_postcode" :"",
                               "search_event_type" :"",
                               "search_my_cso" :"1",
                               "search_keyword":""]
                                
                   print(data)
            let servicehandler = ServiceHandlers()
            servicehandler.FilterEvents(params: data) { (responce, isSuccess) in
                   if isSuccess{
                    let data = responce as! Array<Any>
                      self.FilterList = data as! [[String : Any]]
                    //print(self.FilterList)
              self.SearchList = self.FilterList
                    self.Table1.reloadData()
//                          print(self.SearchList)
             }
           }
         }
      }
    
    @objc func dismissPicker(){

        view.endEditing(true)

    }
  
    @IBAction func inPressed(_ sender: Any) {
        
//        self.timePickeSelected.isHidden = false
        timeView.isHidden = !timeView.isHidden
        boolInTimeselected = true
        
    }
    @IBAction func TimePicker(_ sender: Any) {
        
        
       // timeView.isHidden = true
        let formatter = DateFormatter()
               formatter.locale = Locale(identifier: "en_US_POSIX")
               formatter.dateFormat = "h:mm a"
               formatter.amSymbol = "AM"
               formatter.pmSymbol = "PM"

               let dateString = formatter.string(from: timePickeSelected.date)
               //print(dateString)   // "4:44 PM on June 23, 2016\n"
        
        if boolInTimeselected{
        self.InTime.setTitle(dateString, for: .normal)
        }else{
            
            let strInTime = (InTime.titleLabel?.text)!
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "h:mm a" //Your New Date format as per requirement change it own
          
            let newINDate = formatter.date(from: strInTime) //pass Date here
            //print(newINDate!) //New formatted Date string
            
            let newOutDate = formatter.date(from: dateString)
           
            if newOutDate?.compare(newINDate!) == .orderedDescending
            {
                self.OutTime.setTitle(dateString, for: .normal)
            }
            else{
                
                let alert = UIAlertController(title: nil, message: NSLocalizedString("Out time should not be less than In Time", comment: ""), preferredStyle: UIAlertController.Style.alert)
                
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                            self.present(alert, animated: true, completion: nil)
            }
        
        }
        
       }
    
    @IBAction func OutPressed(_ sender: Any) {
//        self.timePickeSelected.isHidden = false
        timeView.isHidden = !timeView.isHidden
        boolInTimeselected = false
        
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
          self.imgViewCover.image = UIImage(named:strImageNameCover)
          
          
      }

   
    override func viewWillAppear(_ animated: Bool ) {
          super.viewWillAppear(true)
        
        self.getCoverImageForRank()
        
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        self.DiscoverEventsTapped.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
            if let image    = UIImage(contentsOfFile: imageURL.path){
                                    self.profilepic.image = image
                                      self.profilepic.layer.borderWidth = 1
                                      self.profilepic.layer.masksToBounds = false
                                      self.profilepic.layer.borderColor = UIColor.black.cgColor
                                      self.profilepic.layer.cornerRadius = self.profilepic.frame.height/2
                                      self.profilepic.clipsToBounds = true
            }
           // Do whatever you want with the image
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
       
        //if defaults == "Dark Mode"{
            
            //DarkMode()
            //self.bookButtonTapped.setTitleColor(UIColor.white, for: UIControl.State.normal)
          //  self.DiscoverEventsTapped.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            
      //  }else if defaults == "Light Mode"{
            
        //    LightMode()
            self.bookButtonTapped.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.DiscoverEventsTapped.setTitleColor(UIColor.gray, for: UIControl.State.normal)
      //  }
              UserDefaults.standard.string(forKey: "fromscreen")
        if strFromScreen == "DASHBOARD" {
            
            View2.isHidden = false

            self.View2.frame = CGRect(x: View2.frame.origin.x, y: floatYcoordinateView2 - 60.0, width: View2.frame.width, height: floatHeightView2 + 60.0)
            DiscoverLabel.isHidden = false
            BookLabel.isHidden = true
            self.bookButtonTapped.setTitleColor(UIColor.gray, for: UIControl.State.normal)
                       self.DiscoverEventsTapped.setTitleColor(UIColor.black, for: UIControl.State.normal)
            strFromScreen = ""
            if (strPostalCode != nil) {
                self.searchTab.text = self.strPostalCode
                btnSearchCategory.setTitle("Postal Code", for: .normal)
                 self.searchEventByCategory()
            }else{
                btnSearchCategory.setTitle("Search By", for: .normal)
            }
            
        }else{
            self.View2.frame = CGRect(x: View2.frame.origin.x, y: floatYcoordinateView2, width: View2.frame.width, height: floatHeightView2)
            
        }
        
                    
                }
    func refreshLoadData(){
        
//        UpdateView1.isHidden = true
        updateView2.isHidden=true
        EventShiftView1.isHidden = true
        EventShiftView2.isHidden = true
        StatsView1.isHidden = true               // Change Status
        statusview2.isHidden = true
        self.statusMainStackView.isHidden = true
        for subview in view.subviews {
            if subview.tag == 99 { // removing
                subview.removeFromSuperview()
            }
            
        }
        
        ViewChangeStatusBackground.isHidden = true
        ViewChangeStatusPoMain.isHidden = true
        
        volunteerCalender()
        self.searchTab.delegate = self
        View2.isHidden = true
        DiscoverLabel.isHidden = true
        BookLabel.isHidden = false
        
        if self.strPostalCode == nil {
            self.searchTab.text = ""
        let serviceHandler = ServiceHandlers()
        serviceHandler.searchEvents(search_keyword: "", seach_row_number: "0", search_page_size: "30")
        { (responce, isSuccess) in
            if isSuccess {
                let data = responce as! Array<Any>
                //print(data)
                self.FilterList = data as! [[String : Any]]
                
                self.SearchList = self.FilterList
                self.Table1.reloadData()
                //print(self.SearchList)
            }
        }
            self.StatsView1.isHidden = true
            self.ViewChangeStatusBackground.isHidden = true
            self.ViewChangeStatusPoMain.isHidden = true
        }
        
    }

    @objc func handleTap(_ sender:UITapGestureRecognizer){

        self.StatsView1.isHidden = true
        self.statusview2.isHidden = true
         self.statusMainStackView.isHidden = true

    }
    
    @objc func handleTap2(_ sender:UITapGestureRecognizer){

        self.ViewChangeStatusBackground.isHidden = true
        self.ViewChangeStatusPoMain.isHidden = true
        

    }
    @objc func handleTap3(_ sender:UITapGestureRecognizer){

//           self.UpdateView1.isHidden = true
           self.updateView2.isHidden = true
    }
    @objc func handleTap4(_ sender:UITapGestureRecognizer){

           self.EventShiftView1.isHidden = true
           self.EventShiftView2.isHidden = true
    }
    
@IBAction func backbutton(_ sender: Any) {
        
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "notify") as! VolunteerNotificationViewController
               self.present(obj, animated: true)
    }
    
    
    @IBAction func WithdrawPressed(_ sender: Any) {
        
        
        StatsView1.isHidden = true
        statusview2.isHidden = true
         self.statusMainStackView.isHidden = true
        //print("withdraw Button Tapped")

    }
    
    
    @IBAction func CompletePressed(_ sender: Any) {
        
        StatsView1.isHidden = true
        statusview2.isHidden = true
         self.statusMainStackView.isHidden = true
         //print("Mark Complete Button Tapped")
        

    }
    
    @IBAction func UdateCancelButton(_ sender: Any) {
//        UpdateView1.isHidden = true
        updateView2.isHidden = true
        eventStatusoverlayTapped(sender)
        
    }
    
    @IBAction func UpdateDoneButton(_ sender: Any) {
        eventStatusoverlayTapped(sender)
        if OutTime.titleLabel!.text != nil {
        self.UpdateHours()
//        UpdateView1.isHidden = true
        updateView2.isHidden = true
        }else{
            
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Time field cannot be left blank!", comment: ""), preferredStyle: UIAlertController.Style.alert)
                           
                                       // add an action (button)
                                       alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                           // show the alert
                                       self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func DiscoverEventPressed(_ sender: Any) {
        
        
        
        
        EventShiftView1.isHidden = true
        EventShiftView2.isHidden = true
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "Description") as! VolunteerEventDescription
              
       let param = self.SelectData!["event_id"] as! String
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.getSelectedEventDetails(eventId: param) { (responce, isSuccess) in
            if isSuccess {
                
                var data = responce as! [String : Any]
                   //print(data)
                 obj.eventData = data
                obj.event_id = param // Reetesh 24Jan

                self.navigationController?.pushViewController(obj, animated: true)
                //Utility.presentWithNavigationController(destinationVC: obj, currentVC: self)
                }

               //
        
    }
    }
    
    @IBAction func eventStatusoverlayTapped(_ sender: Any) {
        if timeView.isHidden {
            self.StatsView1.isHidden = true
            self.statusview2.isHidden = true
            self.statusMainStackView.isHidden = true
            updateView2.isHidden = true
        } else {
            timeView.isHidden = true
        }
    }
    
    @IBAction func eventAndShiftOverlayTapped(_ sender: Any) {
        self.EventShiftView1.isHidden = true
        self.EventShiftView2.isHidden = true
    }
    
    @IBAction func doneTimeSel(_ sender: Any) {
        timeView.isHidden = true
        
    }
    @IBAction func eventBookingInfoOverlayTapped(_ sender: Any) {
        self.ViewChangeStatusBackground.isHidden = true
        self.ViewChangeStatusPoMain.isHidden = true
    }

    
    @IBAction func ViewButton(_ sender: Any) {
        
       
//           ChangeStatusTapped: UIButton!
//          @IBOutlet weak var viewButtonTapped: UIButton!
        
        //print(SelectData)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "volunteershifts") as! VolunteerShifts
        let servicehandler = ServiceHandlers()
        servicehandler.getAllShift(eventId: self.SelectData!["event_id"] as! String){
            (responce,isSuccess) in
            if isSuccess{
                let data1 = responce as! Array<Any>
                print(data1)
                obj.eventID = self.SelectData!["event_id"] as! String
               self.ViewChangeStatusBackground.isHidden = true
                self.ViewChangeStatusPoMain.isHidden = true
                self.present(obj, animated: true)
            }
        }
    }
    
    
    
    @IBAction func ChangeStatusButton(_ sender: Any) {
        self.ViewChangeStatusBackground.isHidden = true
        self.ViewChangeStatusPoMain.isHidden = true
         self.statusMainStackView.isHidden = false
        statusview2.isHidden = false
        StatsView1.isHidden = false
        resetStatusStackView()
        
//        Test cases
        //let numbers = ["30", "50", "51", "60", "90","20","10","40","70"]
      //  let mapStatus = "20"//numbers.randomElement()
//        print("map status = \(mapStatus)")
        
        
       let mapStatus = SelectData!["map_status"] as! String
        
        
            switch (mapStatus) {
              
                
            case "90":
                
                currentStatusImage.image = UIImage(named: "not_available.png")
                currentstatusName.text = "Not Available"
                
                 self.withdraw.isHidden = true
                 self.chat.isHidden = true
                 self.markCompleted.isHidden = true
                 self.currentAccepted.isHidden = true
                
                 Label1.isHidden = true
                 Label2.isHidden = true
                 Label3.isHidden = true
                 
                 chatImage.isHidden = true
                 withdrawImage.isHidden = true
//                 moreinfoimage.isHidden = true
                changeacceptImage.isHidden = true
                 changestatusLabel.isHidden = true
                 
                
                statusMainStackView.removeArrangedSubview(lblchangeStatusTo)
                statusMainStackView.removeArrangedSubview(changestatusLabel)
                statusMainStackView.removeArrangedSubview(eventStatus_WithdrawView)
                statusMainStackView.removeArrangedSubview(eventStatus_MarkCompleteView)
                statusMainStackView.removeArrangedSubview(eventStatus_ChatView)
                statusMainStackView.removeArrangedSubview(Label1)
                
                lblchangeStatusTo.isHidden = true
                changestatusLabel.isHidden = true
                eventStatus_WithdrawView.isHidden = true
                eventStatus_MarkCompleteView.isHidden = true
                eventStatus_ChatView.isHidden = true
                Label1.isHidden = true
                
                
                // statusview2.frame = CGRect(x: 19, y: 123, width: 338, height: 98)

                 break
                
                case "70":
                    
                    currentStatusImage.image = UIImage(named: "complete-verified.png")
                    currentstatusName.text = "Verified"
                                   
                 self.withdraw.isHidden = true
                 self.chat.isHidden = true
                 self.markCompleted.isHidden = true
                 self.currentAccepted.isHidden = true
                
                 Label1.isHidden = true
                 Label2.isHidden = true
                 Label3.isHidden = true
                 
                 
                 chatImage.isHidden = true
                 withdrawImage.isHidden = true
                 changeacceptImage.isHidden = true
                    completedImage.isHidden = true
                    changestatusLabel.isHidden = true
                 
                    
                    statusMainStackView.removeArrangedSubview(lblchangeStatusTo)
                    statusMainStackView.removeArrangedSubview(changestatusLabel)
                    statusMainStackView.removeArrangedSubview(eventStatus_WithdrawView)
                    statusMainStackView.removeArrangedSubview(eventStatus_MarkCompleteView)
                    statusMainStackView.removeArrangedSubview(eventStatus_ChatView)
                    statusMainStackView.removeArrangedSubview(Label1)
                    
                    lblchangeStatusTo.isHidden = true
                    changestatusLabel.isHidden = true
                    eventStatus_WithdrawView.isHidden = true
                    eventStatus_MarkCompleteView.isHidden = true
                    eventStatus_ChatView.isHidden = true
                    Label1.isHidden = true
                    
                 // statusview2.frame = CGRect(x: 19, y: 226, width: 338, height: 92)
                

                 break
                
                  case "10":
                     
                     currentStatusImage.image = UIImage(named: "pending.png")
                     currentstatusName.text = "Pending"
                    
                      self.withdraw.isHidden = false
                      self.chat.isHidden = true
                      self.markCompleted.isHidden = true
                      self.currentAccepted.isHidden = true
                     
                      Label1.isHidden = true
                      Label2.isHidden = true
                      Label3.isHidden = true
                     
                      
                      chatImage.isHidden = true
                      withdrawImage.isHidden = false
                     completedImage.isHidden = true
                     changeacceptImage.isHidden = true
                     changestatusLabel.isHidden = false
                     withdrawImage.image = UIImage(named: "withdrawn-volunteer.png")
                     
                
                     statusMainStackView.removeArrangedSubview(eventStatus_MarkCompleteView)
                     statusMainStackView.removeArrangedSubview(eventStatus_ChatView)
                     statusMainStackView.removeArrangedSubview(Label1)

                    
                     eventStatus_MarkCompleteView.isHidden = true
                     eventStatus_ChatView.isHidden = true
                     Label1.isHidden = true
                      
       // statusview2.frame = CGRect(x: 19, y: 189, width: 338, height: 187)
                       
                     
                    break
                 
            case "20":
                
                currentStatusImage.image = UIImage(named: "accepted-cso.png")
                currentstatusName.text = "Accepted"
                               
                
                
                      self.withdraw.isHidden = false
                      self.chat.isHidden = true
                      self.currentAccepted.isHidden = true
                      self.markCompleted.isHidden = false
                      
                      Label1.isHidden = false
                      Label2.isHidden = true
                      Label3.isHidden = true
                     
                        withdrawImage.image = UIImage(named: "withdrawn-volunteer.png")
                      chatImage.isHidden = true
                      withdrawImage.isHidden = false
                      changeacceptImage.isHidden = true
                      completedImage.isHidden = false
                completedImage.image = UIImage(named: "completed-volunteer.png")
                changestatusLabel.isHidden = false
                eventStatus_ChatView.isHidden = true
                Label1.isHidden = false
                //  statusview2.frame = CGRect(x: 19, y: 189, width: 338, height: 236)
                      break
                  
                  case "30":
                    
                    currentStatusImage.image = UIImage(named: "declined-cso.png")
                    currentstatusName.text = "Decline"
                      self.withdraw.isHidden = false
                      self.chat.isHidden = false
                      self.markCompleted.isHidden = true
                      self.currentAccepted.isHidden = true
                      
                      Label1.isHidden = true
                      Label2.isHidden = true
                      Label3.isHidden = true
                    
                        chat.isHidden = false
                      chatImage.isHidden = false
                      withdrawImage.isHidden = false
                    changestatusLabel.isHidden = false
                      completedImage.isHidden = true
                      
                    chatImage.image = UIImage(named: "chat.png")
                    chatImage.frame.origin = CGPoint(x: 59, y:149)
                    
          //  statusview2.frame = CGRect (x: 19, y: 189, width: 338, height: 187)
                    
//                    statusMainStackView.removeArrangedSubview(eventStatus_WithdrawView)
                    statusMainStackView.removeArrangedSubview(eventStatus_MarkCompleteView)
                    statusMainStackView.removeArrangedSubview(Label1)
//                    statusMainStackView.removeArrangedSubview(changestatusLabel)
                    statusMainStackView.removeArrangedSubview(eventStatus_ChatView)
                    
//                    eventStatus_WithdrawView.isHidden = true
                    eventStatus_MarkCompleteView.isHidden = true
                    Label1.isHidden = true
//                    changestatusLabel.isHidden = true
                    eventStatus_ChatView.isHidden = true
                 break
                 
                  case "40":
                    currentStatusImage.image = UIImage(named: "completed-volunteer.png")
                    
                    currentstatusName.text = "Complete"
                    
                      self.currentAccepted.isHidden = true
                      self.markCompleted.isHidden = true
                      self.chat.isHidden = true
                      self.withdraw.isHidden = true
                      
                      
                      Label1.isHidden = true
                      Label2.isHidden = true
                      Label3.isHidden = true
                     
                        
                      chatImage.isHidden = true
                      withdrawImage.isHidden = true
                      completedImage.isHidden = true
                      changeacceptImage.isHidden = true
                     changestatusLabel.isHidden = true
                      
                    statusMainStackView.removeArrangedSubview(lblchangeStatusTo)
                    statusMainStackView.removeArrangedSubview(changestatusLabel)
                    statusMainStackView.removeArrangedSubview(eventStatus_WithdrawView)
                    statusMainStackView.removeArrangedSubview(eventStatus_MarkCompleteView)
                    statusMainStackView.removeArrangedSubview(eventStatus_ChatView)
                    statusMainStackView.removeArrangedSubview(Label1)

                    lblchangeStatusTo.isHidden = true
                    changestatusLabel.isHidden = true
                    eventStatus_WithdrawView.isHidden = true
                    eventStatus_MarkCompleteView.isHidden = true
                    eventStatus_ChatView.isHidden = true
                    Label1.isHidden = true
                    
                    
       // statusview2.frame = CGRect (x: 19, y: 226, width: 338, height: 98)
                      
                       break
               
                  case "50":
                    
                    
                    currentStatusImage.image = UIImage(named: "more-info.png")
                    currentstatusName.text = "More Information"
                    
                     
                       self.withdraw.isHidden = false
                      self.chat.isHidden = false
                      self.markCompleted.isHidden = false
                      self.currentAccepted.isHidden = false
                      
                      Label1.isHidden = false
                      Label2.isHidden = false
                      Label3.isHidden = false
                      
                        
                      chatImage.isHidden = false
                      withdrawImage.isHidden = false
                      completedImage.isHidden = false
                      changeacceptImage.isHidden = true
                    
                      chatImage.image = UIImage(named: "chat.png")
                    withdrawImage.image = UIImage(named: "withdrawn-volunteer.png")
                    completedImage.image = UIImage(named: "completed-volunteer.png")
//                    changeacceptImage.image = UIImage(named: "accepted-cso.png")
                      
                   // statusview2.frame = CGRect (x: 18, y: 123, width: 338, height: 333)
                      
                    chat.isHidden = false
                
                      break
                      
                  case "51":
                    
                    
                    currentStatusImage.image = UIImage(named: "more-info.png")
                    currentstatusName.text = "More Information"
                    
                      self.withdraw.isHidden = false
                      self.chat.isHidden = false
                      self.markCompleted.isHidden = true
                      self.currentAccepted.isHidden = true
                      
                      Label1.isHidden = false
                      Label2.isHidden = true
                      Label3.isHidden = true
                      
                       
                      chatImage.isHidden = false
                      withdrawImage.isHidden = false
                      completedImage.isHidden = true
                      changeacceptImage.isHidden = true
                      chat.isHidden = false
        //  statusview2.frame = CGRect (x: 18, y: 189, width: 338, height: 236)
                     
                chatImage.frame.origin = CGPoint(x: 59, y:191)
                chatImage.image = UIImage(named: "chat.png")
                

            
                    statusMainStackView.removeArrangedSubview(eventStatus_MarkCompleteView)
                    statusMainStackView.removeArrangedSubview(eventStatus_ChatView)
                    statusMainStackView.removeArrangedSubview(Label1)

                    eventStatus_MarkCompleteView.isHidden = true
                    eventStatus_ChatView.isHidden = true
                    Label1.isHidden = true
                    
                      break
                      
                  case "60":
                    
                    currentStatusImage.image = UIImage(named: "rejected-cso.png")
                                       currentstatusName.text = NSLocalizedString("Rejected", comment: "")
                    
                      self.currentAccepted.isHidden = true
                      self.markCompleted.isHidden = true
                      self.withdraw.isHidden = true
                      self.chat.isHidden = false
                     
                      Label1.isHidden = true
                      Label2.isHidden = true
                      Label3.isHidden = true
                      
                          
                      chatImage.isHidden = false
                      withdrawImage.isHidden = true
                      completedImage.isHidden = true
                     changeacceptImage.isHidden = true
                    changestatusLabel.isHidden = false
                    chat.isHidden = false
          //    statusview2.frame = CGRect(x: 18, y: 123, width: 338, height: 187)
                      
                    
                     
                      chatImage.frame.origin = CGPoint(x:58 , y:149)
                    chatImage.image = UIImage(named: "chat.png")
                      
                    statusMainStackView.removeArrangedSubview(lblchangeStatusTo)
                    statusMainStackView.removeArrangedSubview(changestatusLabel)
                    statusMainStackView.removeArrangedSubview(eventStatus_ChatView)
                    statusMainStackView.removeArrangedSubview(eventStatus_MarkCompleteView)
                    statusMainStackView.removeArrangedSubview(eventStatus_WithdrawView)
                    
                    statusMainStackView.removeArrangedSubview(Label1)

                    lblchangeStatusTo.isHidden = true
                    changestatusLabel.isHidden = true
                    eventStatus_ChatView.isHidden = true
                    eventStatus_MarkCompleteView.isHidden = true
                    eventStatus_WithdrawView.isHidden = true
                    Label1.isHidden = true
                    
                      break
                      
                  default:
                      self.withdraw.isHidden = true
                      self.btnMoreInfo.isHidden = true
                      self.chat.isHidden = true
                      self.markCompleted.isHidden = true
                      self.currentAccepted.isHidden = true
                      
                      chatImage.isHidden = true
                      withdrawImage.isHidden = true
//                      moreinfoimage.isHidden = true
                      completedImage.isHidden = true
                    changeacceptImage.isHidden = true
                      
                      statusMainStackView.removeArrangedSubview(lblchangeStatusTo)
                      statusMainStackView.removeArrangedSubview(changestatusLabel)
                      statusMainStackView.removeArrangedSubview(lblCurrentStatus)
                      statusMainStackView.removeArrangedSubview(eventStatus_CurrentStatusView)
                      statusMainStackView.removeArrangedSubview(eventStatus_WithdrawView)
                      statusMainStackView.removeArrangedSubview(eventStatus_MarkCompleteView)
                      statusMainStackView.removeArrangedSubview(eventStatus_ChatView)
                      statusMainStackView.removeArrangedSubview(Label1)

                      
                      lblchangeStatusTo.isHidden = true
                      changestatusLabel.isHidden = true
                      lblCurrentStatus.isHidden = true
                      eventStatus_WithdrawView.isHidden = true
                      eventStatus_MarkCompleteView.isHidden = true
                      eventStatus_ChatView.isHidden = true
                      eventStatus_CurrentStatusView.isHidden = true
                      Label1.isHidden = true
                  }
   
        self.view.layoutIfNeeded()
    }

    fileprivate func resetStatusStackView(){
        statusMainStackView.addArrangedSubview(lblCurrentStatus)
        statusMainStackView.addArrangedSubview(eventStatus_CurrentStatusView)
        statusMainStackView.addArrangedSubview(lblchangeStatusTo)
        statusMainStackView.addArrangedSubview(changestatusLabel)
        statusMainStackView.addArrangedSubview(eventStatus_WithdrawView)
        statusMainStackView.addArrangedSubview(Label1)
        statusMainStackView.addArrangedSubview(eventStatus_MarkCompleteView)
        statusMainStackView.addArrangedSubview(eventStatus_ChatView)
        

        chat.isHidden = true
        lblchangeStatusTo.isHidden = false
        changestatusLabel.isHidden = false
        lblCurrentStatus.isHidden = false
        eventStatus_WithdrawView.isHidden = false
        eventStatus_MarkCompleteView.isHidden = false
        eventStatus_ChatView.isHidden = false
        eventStatus_CurrentStatusView.isHidden = false
        Label1.isHidden = false
        
        
        statusMainStackView.removeArrangedSubview(eventStatus_ChatView)
        eventStatus_ChatView.isHidden = true
        
    }
    @IBAction func DiscoverShiftPressed(_ sender: Any) {
        EventShiftView1.isHidden = true
        EventShiftView2.isHidden = true
         
        //print(SelectData)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "volunteershifts") as! VolunteerShifts
        let servicehandler = ServiceHandlers()
        servicehandler.getAllShift(eventId: self.SelectData!["event_id"] as! String){
            (responce,isSuccess) in
            if isSuccess{
                let data1 = responce as! Array<Any>
                obj.eventID = self.SelectData!["event_id"] as! String
                self.presentWithNavigationController(viewController: obj)
            }else{
                
                let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: UIAlertController.Style.alert)
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    func UpdateHours(){
        
       let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                let user_id = userIDData["user_id"] as! String
                let device = UIDevice.current.identifierForVendor!.uuidString
        let InTime = self.InTime.titleLabel?.text
              //print(InTime)
             let OutTime = self.OutTime.titleLabel?.text
             //print(OutTime)
             let map = SelectData!["map_id"] as! String
             //print(map)
             let status = self.map_status
             //print(status)

                let params = ["user_id":user_id,
                              "user_type":"VOL",
                              "user_device":device,
                              "map_id":map,
                              "attend_in_time":InTime,
                              "attend_out_time":OutTime,
                              "map_status":status
                            ]
                //print(params)
                let serviceHanlder = ServiceHandlers()

             serviceHanlder.TimeFilledData(params: params) { (responce, isSuccess) in
                  if isSuccess {

                    let alert = UIAlertController(title: nil, message:NSLocalizedString("Mark Completed Successfully", comment: ""), preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: {(_alert)->Void in
                                        
                                         self.statusMainStackView.isHidden = true
                                        self.statusview2.isHidden = true
                                        self.StatsView1.isHidden = true
                                        self.refreshLoadData()
                  
                                    }))
                                    self.present(alert,animated: true)
                    
                  }else{
                    
                    
                }
             }
    }
    
    func PreFilledData(){
           
         
let formatter = DateFormatter()
       formatter.locale = Locale(identifier: "en_US_POSIX")
       formatter.dateFormat = "h:mm a"
       formatter.amSymbol = "AM"
       formatter.pmSymbol = "PM"

       let dateString = formatter.string(from: Date())

       self.InTime.setTitle(dateString, for: .normal)
}

    func volunteerCalender(){
        self.configureCalander()
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let param = userIDData["user_id"] as! String
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.VolunteerCalenderEvents(user_id: param) { (responce, isSuccess) in
            if isSuccess {
                
                self.calendarEvents = responce as! [[String : Any]]
                //print(self.calendarEvents)
                
                self.datesWithEvent.removeAll()
                let names = self.calendarEvents
                for name in names {
                    //print(name["shift_date"] as Any)
                    self.datesWithEvent.append(name["shift_date"] as! String)
                }
                //print(self.datesWithEvent)
                
                self.calendar.reloadData()
            }
        }

}

    
    func showSelectedEventDetails(selectedEventDetail:[String: Any]?)  {
           let mainSB = UIStoryboard(name: "Main", bundle: nil)
           if let eventData = selectedEventDetail,  let selectedEventVC =  mainSB.instantiateViewController(withIdentifier: "CSOTodaysEventDetailsViewController") as? CSOTodaysEventDetailsViewController {
               
               
               //CSOTodaysEventDetailsViewController()
               selectedEventVC.selectedEvent = eventData
               selectedEventVC.willMove(toParent: self)
               self.view.addSubview(selectedEventVC.view)
               self.addChild(selectedEventVC)
               selectedEventVC.didMove(toParent: self)
           }
           
       }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.SearchList! = searchText.isEmpty ? FilterList! : FilterList!.filter{(($0 as AnyObject)["event_heading"] as! String).localizedCaseInsensitiveContains(searchText)}
        Table1.reloadData()
        }
    @IBAction func searchTypeSelection(_ sender: UIButton) {
        
       let contents = ["Event Name","Event City","Postal Code","State","Organization"]
                     showPopoverForView(view: sender, contents: contents)
        
    }
    fileprivate func showPopoverForView(view:Any, contents:Any) {
            let controller = DropDownItemsTable(contents)
            let senderButton = view as! UIButton
            controller.showPopoverInDestinationVC(destination: self, sourceView: view as! UIView) { (selectedValue) in
                if let selectVal = selectedValue as? String {
                   // self.user_gender = String(selectVal.prefix(1))
                    senderButton.setTitle(selectVal, for: .normal)
                   // senderButton.setImage(nil, for: .normal)
                    self.strSearchCategorySel = selectVal
                } else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetCountryServiceStrings.keyCountryName] as? String {
                   // self.user_countryID = selectVal[GetCountryServiceStrings.keyCountryId] as! String
                    senderButton.setTitle(title, for: .normal)
                   // senderButton.setImage(nil, for: .normal)
                }  else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetStateServiceStrings.keyStateName] as? String {
                   // self.user_stateID = selectVal[GetStateServiceStrings.keyStateId] as! String
                    senderButton.setTitle(title, for: .normal)
                   // senderButton.setImage(nil, for: .normal)
                }else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetDocumentType.documentTypeName] as? String {
                   //self.documentName = selectVal[GetDocumentType.documentTypeName] as! String
                   
                   //self.documentID = selectVal[GetDocumentType.documentTypeID] as! String
                               senderButton.setTitle(title, for: .normal)
                              // senderButton.setImage(nil, for: .normal)
                }else if let selectVal = selectedValue as? [String:Any],
                   let title = selectVal[GetQuestionType.answer_detail] as? String {
                                       senderButton.setTitle(title, for: .normal)
                                //       senderButton.setImage(nil, for: .normal)
                }
            }
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print(searchBar.text as Any)
      searchBar.resignFirstResponder()
        lblCSOEvents.setImage(UIImage(named: "black-square-png.png"), for: .normal)
        check = false
        self.searchEventByCategory()
  }
    func searchEventByCategory(){
       
            
            var strCheckforCso = ""
            if check{
                strCheckforCso = "1"
            }else{
                strCheckforCso = "0"
            }
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                                          let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                                         let user_id = userIDData["user_id"] as! String
            var data:Dictionary<String,String>?
            if let instruction = self.strSearchCategorySel {
                print(instruction)
                switch instruction {
                case "Event Name" :
                    data = ["user_id": user_id,
                                                           "seach_row_number" : "0",
                                                           "search_page_size" : "30",
                                                           "search_city": "",
                                                           "search_state":"",
                                                           "search_org":"",
                                                           "search_postcode" :"",
                                                           "search_event_type" :"",
                                                           "search_my_cso" :strCheckforCso,
                                                           "search_keyword":searchTab.text!]
                case "Event City" :
                    data = ["user_id": user_id,
                    "seach_row_number" : "0",
                    "search_page_size" : "30",
                    "search_city": searchTab.text!,
                    "search_state":"",
                    "search_org":"",
                    "search_postcode" :"",
                    "search_event_type" :"",
                    "search_my_cso" :strCheckforCso,
                    "search_keyword":""]
                case "Postal Code" :
                    data = ["user_id": user_id,
                    "seach_row_number" : "0",
                    "search_page_size" : "30",
                    "search_city": "",
                    "search_state":"",
                    "search_org":"",
                    "search_postcode" :searchTab.text!,
                    "search_event_type" :"",
                    "search_my_cso" :strCheckforCso,
                    "search_keyword":""]
                case "State" :
                    data = ["user_id": user_id,
                    "seach_row_number" : "0",
                    "search_page_size" : "30",
                    "search_city": "",
                    "search_state":searchTab.text!,
                    "search_org":"",
                    "search_postcode" :"",
                    "search_event_type" :"",
                    "search_my_cso" :strCheckforCso,
                    "search_keyword":""]
                case "Organization" :
                    data = ["user_id": user_id,
                    "seach_row_number" : "0",
                    "search_page_size" : "30",
                    "search_city": "",
                    "search_state":"",
                    "search_org":searchTab.text!,
                    "search_postcode" :"",
                    "search_event_type" :"",
                    "search_my_cso" :strCheckforCso,
                    "search_keyword":""]
                default:
                    print("WASNT RECOGNISED CHARACTER")
                }
            }else{
                return
            }
print(data)
                     let servicehandler = ServiceHandlers()
            servicehandler.FilterEvents(params: data!) { (responce, isSuccess) in
                            if isSuccess{
                             let data = responce as! Array<Any>
                                 self.FilterList?.removeAll()
                               self.FilterList = data as! [[String : Any]]
                             self.SearchList?.removeAll()
                       self.SearchList = self.FilterList
                                self.Table1.delegate = self
                                self.Table1.dataSource = self
                             self.Table1.reloadData()
                            }else{
                                self.SearchList?.removeAll()
                                self.Table1.delegate = nil
                                self.Table1.dataSource = nil
                                self.Table1.reloadData()
                                let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data found!", comment: ""), preferredStyle: .alert)
                                                           alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: {(_alert)->Void in
                                                       
                                                           }))
                                                           self.present(alert,animated: true)
                }
            }
        
    }
    
    @IBAction func BookingButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
       // let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        //if defaults == "Dark Mode"{
            
          //  self.bookButtonTapped.setTitleColor(UIColor.white, for: UIControl.State.normal)
            //self.DiscoverEventsTapped.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            
        //}else if defaults == "Light Mode"{
            
            self.bookButtonTapped.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.DiscoverEventsTapped.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        //}
        if screen == "MY BOOKING"{
            
        }
        
        View2.isHidden = true
        DiscoverLabel.isHidden = true
        BookLabel.isHidden = false
       
        self.DiscoverEventsTapped.setTitleColor(UIColor.gray, for: UIControl.State.normal)

        
}
    
    @IBAction func DiscoverEventsPressed(_ sender: Any) {
        self.view.endEditing(true)
 //  let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
   //     if defaults == "Dark Mode"{
     //       self.DiscoverEventsTapped.setTitleColor(UIColor.white, for: UIControl.State.normal)
       //     self.bookButtonTapped.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            
       // }else if defaults == "Light Mode"{
            
            self.DiscoverEventsTapped.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.bookButtonTapped.setTitleColor(UIColor.gray, for: UIControl.State.normal)
       // }
        if screen == "DISCOVER EVENTS"{
           

            }
        
        
        View2.isHidden = false
        DiscoverLabel.isHidden = false
        BookLabel.isHidden = true
        
       
}
    
    // UITabBarDelegate
     func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print("Selected item")
    }

    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       // print("Selected view controller")
       // let className = String(describing: viewController)
        //print(className)
        self.strFromScreen = ""
        
    }
   
    
  }
//MARK:- FSCalender Delegate & Datasource
extension VolunteerEventsViewController:  FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
    
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
            return [UIColor(red:0.0/255.0, green: 145.0/255.0, blue: 147.0/255.0, alpha: 1.0), appearance.eventDefaultColor, UIColor.black]
        }
        return nil
    }
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let eventScaleFactor: CGFloat = 2.0
        cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
    }
    
}



extension VolunteerEventsViewController:CustomDetailViewControllerDelegate {
    func eventSelected(_ eventDetail: [String : Any]?) {
       // showSelectedEventDetails(selectedEventDetail: eventDetail) //Reetesh Jan8
        //print(eventDetail as Any);
        // show "MY Booking - View and ChangeStatus option
        
        if eventDetail == nil{
            ViewChangeStatusBackground.isHidden = true
            ViewChangeStatusPoMain.isHidden = true
        }else{
        ViewChangeStatusBackground.isHidden = false
        ViewChangeStatusPoMain.isHidden = false
        self.SelectData = eventDetail
        
        }
    }
}


