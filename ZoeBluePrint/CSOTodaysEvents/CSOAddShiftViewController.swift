//
//  CSOAddShiftViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 17/08/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import SendBirdSDK

class CSOAddShiftViewController: UIViewController,UITextFieldDelegate{
 

    @IBOutlet weak var lblMinimumRating: UILabel!
    @IBOutlet weak var lblShiftTask: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var HeadingLabel: UILabel!
    @IBOutlet weak var imgViewCsoCover: UIImageView!
    @IBOutlet weak var lblShiftDate: UILabel!
    @IBOutlet weak var RankShiftSelectedLists: UIButton!
    
    @IBOutlet weak var imageShiftDate: UIImageView!
    
    
    
    
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblVolunteerRequired: UILabel!
    
    @IBOutlet weak var lblStartTime: UILabel!
    
    @IBOutlet weak var btnResetPressed: UIButton!
    
    @IBOutlet weak var shiftDateButton: UIButton!
    @IBOutlet weak var txtfldVolReq: UITextField!
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var floatingRatingView: FloatRatingView!
    @IBOutlet weak var startDateButton: UIButton!
  
    @IBOutlet weak var shiftTaskButton: UIButton!
    
    @IBOutlet weak var addShiftButton: UIButton!
    
    
    
    var shiftList = [[String:Any]]()
    var eventId = String ()
    var eventDetail = [String : Any]()
    var selectedShiftTaskId = String ()
    var selectedShiftRankId = String ()
    var sDate = String ()
    var sVolReq = String ()
    var shiftRank = String ()
    var shiftStartTime = String ()
     var shiftEndTime = String ()
    var data_for_update:Dictionary<String,Any>?
    var screen:String?
    var shiftName: String?
    private var groupChannelListQuery: SBDGroupChannelListQuery?
    
   let RankList = [["rank":"0",
                      "shift_rank":"0"],["rank":"1",
                      "shift_rank":"1"],["rank":"2",
                      "shift_rank":"2"],["rank":"3",
                      "shift_rank":"3"],["rank":"4",
                      "shift_rank":"4"],["rank":"5",
                      "shift_rank":"5"]]
                     
            
  
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBAction func back_Button(_ sender: Any) {
       performSegueToReturnBack()
  
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
         txtfldVolReq.delegate = self
         txtfldVolReq.keyboardType = UIKeyboardType.numberPad
        
        let keyboard = UIToolbar()
        keyboard.sizeToFit()
        
        let DoneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .done, target: self, action: #selector(doneClick))
        keyboard.items = [DoneButton]
        txtfldVolReq.inputAccessoryView = keyboard
        
    
        
        let serviceHanlder = ServiceHandlers()
                                  serviceHanlder.getShiftList() { (responce, isSuccess) in
                                      if isSuccess {
                                          self.shiftList = responce as! [[String : Any]]
                                        // //print(self.shiftList)
                                      }
                                  }
        
       
       
        configureRatingView()
       
    }
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBAction func notificationButton(_ sender: Any) {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//             let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
//               present(obj,animated: true)
        Utility.showNotificationScreen(navController: self.navigationController)
    }
    
    override func viewWillAppear(_ animated: Bool){
      
       /* let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode"{
            
            DarkMode()
            
        }else if defaults == "Light Mode"{
            
            LightMode()
        }
        
        */
         self.imgViewCsoCover.image = UIImage(named:UserDefaults.standard.string(forKey: "csocoverpic")!)
        self.profile_pic()
        self.backButton.isHidden = true
        
        if(self.screen == "EDIT SCREEN"){
            //self.backButton.isHidden = false
            self.HeadingLabel.text = NSLocalizedString("Update Shift", comment: "")
            
            self.profile_pic()
            //print("hello sir")
           // //print(self.data_for_update as Any)
            self.shiftDateButton.setTitle(self.data_for_update!["shift_date"] as! String, for: .normal)
            self.sDate = self.data_for_update!["shift_date"] as! String
            self.txtfldVolReq.text = self.data_for_update!["shift_vol_req"] as! String
            self.startDateButton.setTitle(self.data_for_update!["shift_start_time"] as! String, for: .normal)
            self.shiftStartTime = self.data_for_update!["shift_start_time"] as! String
            self.endDateButton.setTitle(self.data_for_update!["shift_end_time"] as! String, for: .normal)
            self.shiftEndTime = self.data_for_update!["shift_end_time"] as! String
          
            self.shiftTaskButton.setTitle(self.data_for_update!["shift_task_name"] as! String, for: .normal)
            self.selectedShiftTaskId = self.data_for_update!["shift_task"] as! String
          
            self.selectedShiftRankId = self.data_for_update!["shift_rank"] as! String // "rank_value" 13 Jan Reetesh
            self.RankShiftSelectedLists.setTitle(self.data_for_update!["shift_rank"] as! String ,for: .normal)
            
            
            self.addShiftButton.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
      }
    }
    
    func DarkMode(){
        
        mainView.backgroundColor = .black
        HeadingLabel.textColor = UIColor.white
        self.lblShiftTask.textColor = .white
        self.lblEndTime.textColor = .white
        self.lblShiftDate.textColor = .white
        self.lblShiftDate.backgroundColor = .black
        
        self.RankShiftSelectedLists.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.RankShiftSelectedLists.backgroundColor = .black
        self.RankShiftSelectedLists.borderColor = .white
        
        lblVolunteerRequired.textColor = .white
        lblStartTime.textColor = .white
        self.shiftDateButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.shiftDateButton.backgroundColor = .black
        self.imageShiftDate.image = UIImage(named: "lightNewCalandar.png")
       
        self.txtfldVolReq.textColor = .white
        self.txtfldVolReq.backgroundColor = .black
        txtfldVolReq.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Volunteer Required", comment: "") ,attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.endDateButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        self.startDateButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.shiftTaskButton.setTitleColor(UIColor.white, for: UIControl.State.normal)

      lblMinimumRating.textColor = .white
        self.shiftTaskButton.borderColor = .white
        

        /*
         @IBOutlet weak var lblMinimumRating: UILabel!
         @IBOutlet weak var lblShiftTask: UILabel!
         @IBOutlet weak var lblEndTime: UILabel!
         @IBOutlet weak var HeadingLabel: UILabel!
         
         @IBOutlet weak var lblShiftDate: UILabel!
         @IBOutlet weak var RankShiftSelectedLists: UIButton!
         
         @IBOutlet weak var lblVolunteerRequired: UILabel!
         
         @IBOutlet weak var lblStartTime: UILabel!
         
         @IBOutlet weak var shiftDateButton: UIButton!
         @IBOutlet weak var txtfldVolReq: UITextField!
         @IBOutlet weak var endDateButton: UIButton!
         @IBOutlet weak var floatingRatingView: FloatRatingView!
         @IBOutlet weak var startDateButton: UIButton!
         
         @IBOutlet weak var shiftTaskButton: UIButton!
         
         @IBOutlet weak var addShiftButton: UIButton!
         */
        
        
    }
    func LightMode(){
        
        mainView.backgroundColor = .white
        HeadingLabel.textColor = UIColor.black
        self.lblShiftTask.textColor = .black
        self.lblEndTime.textColor = .black
        self.lblShiftDate.textColor = .black
        self.RankShiftSelectedLists.setTitleColor(UIColor.black, for: UIControl.State.normal)
        lblVolunteerRequired.textColor = .black
        lblStartTime.textColor = .black
        self.shiftDateButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.txtfldVolReq.textColor = .black
        self.endDateButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.startDateButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.shiftTaskButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        
        
    }
    
    
    @IBAction func btnReset(_ sender: Any) {
        
        
        
        
    }
    
    
    
    
    @objc func doneClick() {
    
        self.view.endEditing(true)
        
    }
    @IBAction func sideMenu(_ sender: Any) {
    }
    func addViewController(viewController:UIViewController)  {
        viewController.willMove(toParent: self)
        self.view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func configureRatingView()  {
       
        self.selectedShiftTaskId = ""
        self.selectedShiftRankId = ""
    }

    
    
    @IBAction func shiftDateButton(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        //print(eventDetail["event_register_start_date"]!)
       // //print(eventDetail["event_register_end_date"]!)
        let startDate = dateFormatter.date(from: eventDetail["event_register_start_date"]! as! String )
      //  //print(startDate)
        let endDate = dateFormatter.date(from: eventDetail["event_register_end_date"]! as! String )
      //  //print(endDate)
     
        let dateSelectionPicker = DateSelectionViewController(startDate: startDate!, endDate:  endDate!)
        dateSelectionPicker.view.frame = self.view.frame
        dateSelectionPicker.view.layoutIfNeeded()
        dateSelectionPicker.captureSelectDateValue(sender, inMode: .date) { (selectedDate) in
            let formatter = DateFormatter()
            // formatter.dateFormat = "dd-MMM-yyyy"
            formatter.dateFormat = "MM-dd-yyyy"
            //08-22-2019
            let dateString = formatter.string(from: selectedDate)
            self.sDate = dateString
            (sender as AnyObject).setTitle(dateString, for:.normal)
            (sender as AnyObject).setImage(nil, for: .normal)
            (sender as AnyObject).setTitleColor(.black, for: .normal)
        }
        addViewController(viewController: dateSelectionPicker)
        
    }
    
    @IBAction func addShift(_ sender: Any) {
        
     //  //print(self.sDate)
      //  //print(self.txtfldVolReq.text!)
     //   //print(self.shiftStartTime)
      //  //print(self.shiftEndTime)
       // //print(self.selectedShiftRankId)
      //  //print(self.selectedShiftTaskId)
      if(validate())
            {
                let strShiftStartTime = self.shiftStartTime
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                let datestart = dateFormatter.date(from: strShiftStartTime)
                dateFormatter.dateFormat = "HH:mm"
                let date24StartTime = dateFormatter.string(from: datestart!)
                
                
                
                let strShiftEndTime = self.shiftEndTime
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "h:mm a"
                let dateend = dateFormatter2.date(from: strShiftEndTime)
                dateFormatter2.dateFormat = "HH:mm"
                let date24EndTime = dateFormatter2.string(from: dateend!)
                
                
                if !(self.screen == "EDIT SCREEN")
                  {
                let serviceHanlder = ServiceHandlers()
                serviceHanlder.addShift(event_id: eventId, shift_date: self.sDate, shift_vol_req: self.txtfldVolReq.text!, shift_start_time: date24StartTime, shift_end_time: date24EndTime, shift_rank: self.selectedShiftRankId, shift_task:  self.selectedShiftTaskId) { (responce, isSuccess) in
                    if isSuccess {
                        let addShiftResponce = responce as? [String: Any]
                      // //print(addShiftResponce)
                        let message = addShiftResponce!["res_status"] as! String
                       // //print(message)
                        if(message == "200"){
                            
                            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                                                         let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                                                         let userEmail = userIDData["user_email"] as! String
                                                         //let userFullName = "\(userIDData["user_f_name"]as! String)\(" ")\( userIDData["user_l_name"]as! String)"
                                         
                                     ActivityLoaderView.startAnimating()
                            self.createChannel(email: userEmail)
                            let alert = UIAlertController(title: NSLocalizedString("Success!", comment: ""), message: NSLocalizedString("Shift Added Succesfully!", comment: ""), preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                }
                    self.view.removeFromSuperview()
                }else{
                    var dict = ["shift_id" : self.data_for_update!["shift_id"] as! String,
                                "shift_date" : self.sDate,
                                "shift_vol_req" : self.txtfldVolReq.text!,
                                "shift_start_time" : date24StartTime ,
                                "shift_end_time" : date24EndTime ,
                                "shift_rank" : self.selectedShiftRankId,
                                "shift_task" : self.selectedShiftTaskId
                    ]
                   // //print(dict)
                    
                    let serviceHanlder = ServiceHandlers()
                    serviceHanlder.updateShift(data_details: dict) { (responce, isSuccess) in
                               if isSuccess {
                                   
                                  
                                let alert = UIAlertController(title: nil, message: "Update Successful", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                self.present(alert , animated: true)
                               
                               }
                           }
                    
                     let objToBeSent = "Test Message from Notification"
                    NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: objToBeSent);
                    performSegueToReturnBack()
                    
            }
        }
    }
    
    func createChannel(email: String) {
        ActivityLoaderView.startAnimating()
        let eventName = "\(eventDetail["event_heading"]! as! String) (\(shiftName ?? ""))"
        SBDMain.connect(withUserId: email) { [self] (user, error) in
                                            guard error == nil else {   // Error.
                                                print("USER NOT CONNECTED")
                                                ActivityLoaderView.stopAnimating()
                                                return
                                             
                                            }
        self.groupChannelListQuery = SBDGroupChannel.createMyGroupChannelListQuery()
        self.groupChannelListQuery?.limit = 100
        self.groupChannelListQuery?.includeEmptyChannel = true
        self.groupChannelListQuery?.channelNameFilter = eventName
        if self.groupChannelListQuery?.hasNext == false {
            print("GROUP CHANNEL LIST QUERY NOT CREATED")
            ActivityLoaderView.stopAnimating()
            return
        }
        
        self.groupChannelListQuery?.loadNextPage(completionHandler: { (channels, error) in
            if error != nil {
                print ("error")
                ActivityLoaderView.stopAnimating()
                print("CHANNELS NOT FOUND")
                return
            }
            
            if channels?.count == 0{
                    var strCoverUrl = ""
                    if let url = eventDetail["event_image"] as? String{
                        strCoverUrl = url
                    }else{
                        strCoverUrl = "https://zbp.progocrm.com/uploads/events/"
                    }
                   // let eventName = "\(eventDetail["event_heading"]! as! String) (\(shiftName ?? ""))"
                    SBDGroupChannel.createChannel(withName: eventName, isDistinct: false, userIds: [ email ], coverUrl: strCoverUrl , data: email, customType: "Channel", completionHandler: { (groupChannel, error) in
                                                         guard error == nil else {   // Error.
                                                            ActivityLoaderView.stopAnimating()
                                                            print("CHANNEL NOT CREATED")
                                                             return
                                                         }
                        print("CHANNEL CREATED")
                        ActivityLoaderView.stopAnimating()
                                                        })
                                          
            }else{
                print("CHANNEL with SAME NAME FOUND")
            }
            
        })
        }
     
    }
    
    func profile_pic()  {
       /*  let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
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
         }*/
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
            if let image    = UIImage(contentsOfFile: imageURL.path){
                                    self.profilePicture.image = image
                                      self.profilePicture.layer.borderWidth = 1
                                      self.profilePicture.layer.masksToBounds = false
                                      self.profilePicture.layer.borderColor = UIColor.black.cgColor
                                      self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height/2
                                      self.profilePicture.clipsToBounds = true
            }
           // Do whatever you want with the image
        }
     }
    @IBAction func startTimeButtonClicked(_ sender: Any) {
   
        let dateSelectionPicker = DateSelectionViewController(startDate: nil, endDate:  nil)
        dateSelectionPicker.view.frame = self.view.frame
        dateSelectionPicker.view.layoutIfNeeded()
        dateSelectionPicker.captureSelectDateValue(sender, inMode: .time) { (selectedDate) in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            let dateString = formatter.string(from: selectedDate)
            self.shiftStartTime = dateString
            (sender as AnyObject).setTitle(dateString, for:.normal)
            (sender as AnyObject).setImage(nil, for: .normal)
            (sender as AnyObject).setTitleColor(.black, for: .normal)
        }
        addViewController(viewController: dateSelectionPicker)
    }
    
   @IBAction func endDateButtonClicked(_ sender: Any) {
    
    let dateSelectionPicker = DateSelectionViewController(startDate:  nil, endDate:  nil)
    dateSelectionPicker.view.frame = self.view.frame
    dateSelectionPicker.view.layoutIfNeeded()
    dateSelectionPicker.captureSelectDateValue(sender, inMode: .time) { (selectedDate) in
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let dateString = formatter.string(from: selectedDate)
        self.shiftEndTime = dateString
        (sender as AnyObject).setTitle(dateString, for:.normal)
        (sender as AnyObject).setImage(nil, for: .normal)
        (sender as AnyObject).setTitleColor(.black, for: .normal)
    }
    addViewController(viewController: dateSelectionPicker)
}
    
    @IBAction func taskShiftSelection(_ sender: Any) {
        
        let controller = DropDownItemsTable(shiftList)
        controller.showPopoverInDestinationVC(destination: self, sourceView: sender as! UIView) { [self] (selectedValue) in
           // //print(selectedValue)
            
            if let selectShiftData = selectedValue as? [String:Any],
                let selectedShiftTaskId1 = selectShiftData[GetAddShiftSelectShiftStrings.keyShiftTaskId] as? String {
                self.selectedShiftTaskId = selectedShiftTaskId1
            }
            
            if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetAddShiftSelectShiftStrings.keyShiftTaskName] as? String {
                (sender as AnyObject).setTitle(title, for: .normal)
                shiftName = title
            }
        }
    }
    @IBAction func ShiftRankListButton(_ sender: Any) {
        
         
        let controller = DropDownItemsTable(RankList)
      //  //print(RankList)
               controller.showPopoverInDestinationVC(destination: self, sourceView: sender as! UIView) { (selectedRankValue) in
                //   //print(selectedRankValue)

                   if let selectShiftData = selectedRankValue as? [String:Any],
                       let selectedShiftRankId1 = selectShiftData[GetShiftRankListStrings.keyRank] as? String {
                       self.selectedShiftRankId = selectedShiftRankId1
                   // //print(self.selectedShiftRankId)
                   }

                   if let selectVal = selectedRankValue as? [String:Any], let title = selectVal[GetShiftRankListStrings.keyRankValue] as? String {
                       (sender as AnyObject).setTitle(title, for: .normal)
                   }
               }
//
        
        
    }
           // Mark
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 5
    }
    
  func validate() -> Bool {
        
        
        let editedDatestartTime = self.shiftStartTime.replacingOccurrences(of: ":", with: "")
       // //print(editedDatestartTime)
        
        let editedDateEndTime = self.shiftEndTime.replacingOccurrences(of: ":", with: "")
       // //print(editedDateEndTime)
    
    let formatter = DateFormatter()
      // formatter.locale = Locale(identifier: "en_US_POSIX")
       formatter.dateFormat = "h:mm a"
       formatter.amSymbol = "AM"
       formatter.pmSymbol = "PM"
       let firstTime = formatter.date(from: shiftStartTime)
       let secondTime = formatter.date(from: shiftEndTime)

//
//       if firstTime?.compare(secondTime!) == .orderedAscending {
//           print("First Time is smaller then Second Time")
//       }
//
        if (self.sDate == "")
        {
            
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Shift Date not selected.", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false;
        
        }else if(self.txtfldVolReq.text! == ""){
            
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Voluteer Required data not provided.", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false;
        
        }else if(self.shiftStartTime == ""){
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Shift Start time not selected", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false;
        }else if(self.shiftEndTime == ""){
            
            
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Shift End Time not selected", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false;
            
        }else if firstTime?.compare(secondTime!) == .orderedDescending {
        
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("End Time can't be before Start Time", comment: ""), preferredStyle: UIAlertController.Style.alert)
                       alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                       
                       return false;
            
           }else if(self.selectedShiftRankId == ""){
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Shift Rank not selected", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
           return false;
        }else if(self.txtfldVolReq.text == "0"){
         let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Volunteer request can't be zero", comment: ""), preferredStyle: UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
        return false;
            
        }else if(self.selectedShiftTaskId == ""){
            
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Shift Task not selected", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false;
        }
        else if let limit = Int(editedDateEndTime), Int(editedDatestartTime)! >= limit {
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Shift End Time should be greater than Shift Start Time", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}

extension CSOAddShiftViewController: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        
        
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        
        self.shiftRank = String(Int(rating))
    }
    
}
