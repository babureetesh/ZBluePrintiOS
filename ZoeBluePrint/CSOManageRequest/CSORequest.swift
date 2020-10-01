//
//  CSORequest.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 22/10/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import SendBirdSDK

class CSORequest: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,tagNumberOfButton,UIGestureRecognizerDelegate {
  
    var shiftRank = String ()
    var selectedShiftTaskId = String()
    var c : ViewController! = nil
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var changeStatus_acceptView: UIView!
    @IBOutlet weak var changeStatus_declineView: UIView!
    @IBOutlet weak var changeStatus_verifyView: UIView!
    @IBOutlet weak var changeStatus_rejectView: UIView!
    @IBOutlet weak var changeStatus_moreInfoView: UIView!
    @IBOutlet weak var changeStatus_stackView: UIStackView!
    
    
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblEnterComment: UILabel!
    
    @IBOutlet weak var lblAddComment: UILabel!
    
    @IBOutlet weak var lblNewRating: UILabel!
    
    @IBOutlet weak var lblChangeRating: UILabel!
    
    @IBOutlet weak var lblEnterHours: UILabel!
    
    @IBOutlet weak var lblActualHours: UILabel!
    
    @IBOutlet weak var lblVolunteerHours: UILabel!
    
    @IBOutlet weak var lblFirst: UILabel!
    
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    @IBOutlet weak var volLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    @IBOutlet weak var lblUnderline: UILabel!
    @IBOutlet weak var lblChange: UILabel!
    
    @IBOutlet weak var lblComent: UILabel!
    
    
    @IBOutlet weak var backbuttonpressed: UIButton!
    
    @IBOutlet weak var outerCommentView: UIView!
    
    @IBOutlet weak var mainAddCommentView: UIView!
    
    
    @IBOutlet weak var btnCancelTapped: UIButton!
    
    @IBOutlet weak var btnAddTapped: UIButton!
    @IBOutlet weak var txtAddComment: UITextField!
    @IBOutlet weak var enteringHours: UITextField!
    
    @IBOutlet weak var lblChangeHours: UILabel!
    
    @IBOutlet weak var updateHoursView1: UIView!
    
    @IBOutlet weak var updateHoursView2: UIView!
    
    @IBOutlet weak var StatusView: UIView!
    var screen:String?
    @IBOutlet weak var tblChangeStatus: UITableView!
    @IBOutlet weak var statusBackgroundView: UIView!
    
    @IBOutlet weak var declineCommentLabel: UILabel!
    @IBOutlet weak var RankCommentLAbel: UILabel!
    
//    @IBOutlet weak var rankComment: UILabel!
    @IBOutlet weak var starView: FloatRatingView!
    
    @IBOutlet weak var acceptImage: UIImageView!
    @IBOutlet weak var declineImage: UIImageView!
    @IBOutlet weak var verifyImage: UIImageView!
    @IBOutlet weak var rejectImage: UIImageView!
    @IBOutlet weak var moreinfoimage: UIImageView!
    
    @IBOutlet weak var starViewcell: FloatRatingView!
 
    var mapID:String?
    var rating:String?
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var sideMenu: UIButton!
    @IBOutlet weak var bellButton: UIButton!
    
    
    @IBOutlet weak var statusChangeView: UIView!
    
    @IBOutlet weak var ChangeRank2View: UIView!
    
    @IBOutlet weak var imgRank: UIImageView!
    
    
    @IBOutlet weak var lbnRank: UILabel!
    @IBOutlet weak var changeRank1View: UIView!
   
    @IBOutlet var changeRankField: UITextField!
    
    @IBOutlet weak var tblViewforAllRequest: UITableView!
   
    
    @IBOutlet weak var btnAccept: UIButton!
    
    @IBOutlet weak var btnDecline: UIButton!
    
    @IBOutlet weak var btnVerified: UIButton!
    
    @IBOutlet weak var btnReject: UIButton!
    
    @IBOutlet weak var btnMoreInfo: UIButton!
    
    
    var csoallrequest:[[String:Any]] = []
    var rankimg:String?
    var shiftrank:String?
    var server_data:Dictionary<String,Any>?
    var attend_rank:String?
    var attend_rate:String?
    var table_height:CGFloat?
    var change_status:String?
    var map_id:String?
    var event_id:String?
    var height_of_change_status_button:CGFloat?
    var strShowClose:String?
    var strMoreInfoStatusValue:String?
    var arrSelectedIndexForTick:[Int] = []
     var arrIndexForTick:[Int] = []
    
    @IBOutlet weak var btnCheckAll: UIButton!
    @IBOutlet weak var viewRequesSelButtons: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let tapRecognizerRemhourview = UITapGestureRecognizer(target: self, action:#selector(self.didTapView))
               tapRecognizerRemhourview.delegate = self
        self.updateHoursView2.isUserInteractionEnabled = true
        self.updateHoursView2.isUserInteractionEnabled = true
               self.updateHoursView2.addGestureRecognizer(tapRecognizerRemhourview)
               self.updateHoursView1.addGestureRecognizer(tapRecognizerRemhourview)
        
        starView.isUserInteractionEnabled = true
        starView.isHidden = false
        
        txtAddComment.delegate = self
        enteringHours.delegate = self
        outerCommentView.isHidden = true
        mainAddCommentView.isHidden = true
        
        updateHoursView1.isHidden = true
        updateHoursView2.isHidden = true
        
        self.configureRatingView()
       // self.changeStatusMethod()
        changeRank1View.isHidden = true
        ChangeRank2View.isHidden = true
        statusBackgroundView.isHidden = true
        StatusView.isHidden = true
          tblViewforAllRequest.delegate = self
          tblViewforAllRequest.dataSource = self
        self.volunterData() //reetesh 20 JAn
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tap.delegate = self
        view.isUserInteractionEnabled = true
        statusBackgroundView.addGestureRecognizer(tap)
        
//        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2))
//             tap2.delegate = self
//             view.isUserInteractionEnabled = true
//             updateHoursView1.addGestureRecognizer(tap2)
        
        if screen == "VolunteerSeeFollowers"{
         }
        tblViewforAllRequest.rowHeight = 398
        // Do any additional setup after loading the view.
     volunterData()
        
     self.changeRankField.delegate = self
       
        let tabbar = UITabBarController()
        tabbar.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil )
        //print(strShowClose)
        if strShowClose == "YES"{
            backbuttonpressed.isHidden = false
            backButtonHeightConstraint.constant = 30
//            tblViewforAllRequest.frame = CGRect(x: 0.0, y: 145.0, width: 375.0, height: 522.0)
            //viewRequesSelButtons.frame = CGRect(x: 34.0, y: 4.0, width: 324.0, height: 45.0)
        }else{
            backbuttonpressed.isHidden = true
            backButtonHeightConstraint.constant = 0
            self.profilePicture.isHidden = true
            headerViewHeightConstraint.constant = 0
            self.sideMenu.isHidden = true
            headerView.isHidden = true
            
            //self.lbnHeight.constant = 0
//            viewRequesSelButtons.frame = CGRect(x: 9.0, y: 4.0, width: 324.0, height: 45.0)
//            self.topLable.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
//            tblViewforAllRequest.frame = CGRect(x: 0.0, y: 50.0, width: 375.0, height: 300.0) // height is set from volunteerseefollower class
            self.view.layoutIfNeeded()
        }
        
    }
    override func viewWillAppear(_ animated:Bool) {
           super.viewWillAppear(true)
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        tblViewforAllRequest.reloadData()
        self.profile_pic()
//        if defaults == "Dark Mode"{
//           DarkMode()
//
//        }else if defaults == "Light Mode"{
//           LightMode()
//        }
      
   }
    
    func DarkMode() {
        
        self.view.backgroundColor = .black
        self.StatusView.backgroundColor = .black
     
        self.ChangeRank2View.backgroundColor = .black
        self.lblComent.backgroundColor = .black
        
        self.lblComent.textColor = .white
        self.lblEnterComment.backgroundColor = .black
        
        self.lblEnterComment.textColor = .white
        self.lblEnterComment.backgroundColor = .black
        
        self.lblNewRating.textColor = .white
        self.lblNewRating.backgroundColor = .black
        self.lblFirst.backgroundColor = .lightGray
        self.lblUnderline.backgroundColor = .lightGray
        self.backbuttonpressed.setImage(UIImage(named: "iphoneButton.png"), for: UIControl.State.normal)
        self.sideMenu.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        changeRankField.attributedPlaceholder = NSAttributedString(string: "Enter Comment",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        changeRankField.backgroundColor = .black
        self.updateHoursView2.backgroundColor = .black
        
        self.lblVolunteerHours.textColor = .white
        self.lblVolunteerHours.backgroundColor = .black
        self.lblActualHours.textColor = .white
        self.lblActualHours.backgroundColor = .black
        
        enteringHours.attributedPlaceholder = NSAttributedString(string: "Enter Hours",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.enteringHours.backgroundColor = .black
        self.volLabel.backgroundColor = .lightGray
        self.hoursLabel.backgroundColor = .lightGray
        
        self.mainAddCommentView.backgroundColor = .black
        txtAddComment.attributedPlaceholder = NSAttributedString(string: "Add Comment",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.txtAddComment.backgroundColor = .black
        self.commentLabel.backgroundColor =  .lightGray
        
        
        
    }
    
    func LightMode() {
        self.view.backgroundColor = .white
        
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
     @objc func handleTap(){
        self.statusBackgroundView.isHidden = true
        self.StatusView.isHidden = true
    }
//    @objc func handleTap2(){
//           self.updateHoursView1.isHidden = true
//           self.updateHoursView2.isHidden = true
//       }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= 0.0
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func btnCommentADD(_ sender: Any) {
   
        StatusView.isHidden = true
        statusBackgroundView.isHidden = true
        
        if txtAddComment.text == "" {
        let alert = UIAlertController(title: nil, message: NSLocalizedString("Please enter comment", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                            
              alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
      }
     changeStatusMethod()
      
        print(self.txtAddComment)
        outerCommentView.isHidden = true
        mainAddCommentView.isHidden = true
        
    }
   @IBAction func btnCommentCANCEL(_ sender: Any) {
    
    outerCommentView.isHidden = true
    mainAddCommentView.isHidden = true
    
    }
@IBAction func UpdateButtonPresed(_ sender: Any) {
        
    changeRank1View.isHidden = false
    ChangeRank2View.isHidden = false
    self.tblViewforAllRequest.reloadData()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.tblViewforAllRequest)
            {
                if self.csoallrequest.count == 0{
            return 0
        }else{
                return (self.csoallrequest.count)
              }
        }
       
        return 0
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == self.tblChangeStatus){
        return 70.0
        }else if (tableView == self.tblViewforAllRequest)
        {
            return 398.0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == self.tblViewforAllRequest){
            let cell = tblViewforAllRequest.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CSOManageRequestTableViewCell
        
            let data:NSDictionary = self.csoallrequest[indexPath.row] as NSDictionary
            print(data)
            let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//            if defaults == "Dark Mode"
//            {
//
//                 cell.backgroundColor = .black
//                 cell.LblName?.textColor = .white
//                 cell.EmailDescription?.textColor = .white
//                 cell.titleDescription?.textColor = .white
//                 cell.TaskDescription?.textColor = .white
//                 cell.dateDescription.textColor = .white
//                 cell.timeDescription.textColor = .white
//                 cell.AttendedDesription.textColor = .white
//                 cell.declineComment.textColor = .white
//                 cell.RankComment.textColor = .white
//                 cell.starViewCell.backgroundColor = .clear
//                 cell.lightStarView.isHidden = true
//
//                 cell.starViewCell.rating = Double(data["attend_rank"]as! String ) ?? 0.0
//                 cell.starViewCell.isUserInteractionEnabled = false
//                 starView.isUserInteractionEnabled = true
//
//
//            }else if defaults == "Light Mode" {
//
//                 cell.backgroundColor = .white
//                 cell.LblName?.textColor = .black
//                 cell.EmailDescription?.textColor = .black
//                 cell.titleDescription?.textColor = .black
//                 cell.TaskDescription?.textColor = .black
//                 cell.dateDescription.textColor = .black
//                 cell.timeDescription.textColor = .black
//                 cell.AttendedDesription.textColor = .black
//                 cell.declineComment.textColor = .black
//                 cell.RankComment.textColor = .black
//                 cell.starViewCell.backgroundColor = .clear
//                 cell.lightStarView.isHidden = false
//
                 cell.lightStarView.rating = Double(data["attend_rank"]as! String ) ?? 0.0
            //starView.isHidden = true
            cell.starViewCell.isHidden = true
            //                 starView.isUserInteractionEnabled = true
////                starView.isUserInteractionEnabled = true
     //   }
            
            let f_name = data["user_f_name"] as! String
            let l_name = data["user_l_name"] as! String
            let full_name = "\(f_name) \(l_name)"
      //  //print(full_name)
        cell.LblName?.text = full_name as! String
        cell.EmailDescription?.text = data["user_email"] as! String
        cell.titleDescription?.text = data["event_heading"] as! String
        cell.TaskDescription?.text = data["shift_task_name"] as! String
        cell.dateDescription?.text = data["shift_date"] as! String
         var shift_start = data["shift_start_time"] as! String
         var shift_end = data["shift_end_time"] as! String
         var shift_time = shift_start + " - " + shift_end
        cell.timeDescription?.text = shift_time
//            ["attend_hours"] as! String
           var  strattend_hours = data["attend_hours"] as! String
            strattend_hours = strattend_hours + " Hrs"
            print(strattend_hours)
           cell.AttendedDesription?.text = strattend_hours
            
//             self.enteringHours.text!
            
        cell.RankDescription?.text = "change data"
        cell.statusDescription?.text = "change data"
//        cell.rankPressed.tag = indexPath.row
        cell.statusChanged.tag = indexPath.row
            cell.ChatOptionTapped.tag = indexPath.row
            cell.btnSelection.tag = indexPath.row
            cell.ChatOptionTapped.isHidden = true
            cell.updatebutton.isHidden = true
            
        if (data["map_status"] as! String) == "51" || (data["map_status"] as! String) == "50" {
                
                cell.ChatOptionTapped.isHidden = false
            
            
            }
            var hours = data["attend_hours"] as! String
            print(hours)
            if hours == nil {
           
                cell.AttendedDesription.text = "0 HRS"
          
            }else if hours != nil
            {

                
                cell.AttendedDesription.text = hours + " Hrs"
                
            }
           cell.declineComment?.text = data["map_status_comment"] as! String
           
            if (cell.declineComment.text) == ""{
               
                cell.declineComment.text = "N/A"
                
            }
            let status = data["map_status"]
            let r_status = self.findStatus(mapStatus:status as! String)
            //print(r_status)
            if r_status == "Waiting" {
                cell.btnSelection.isHidden = false
                arrIndexForTick.append(indexPath.row)
                
                if arrSelectedIndexForTick.contains(indexPath.row) {
                  //do something
                    cell.btnSelection.setImage(UIImage(named: "newtickbox.png"), for: .normal)
                }else{
                     cell.btnSelection.setImage(UIImage(named: "black-square-png.png"), for: .normal)
                }
                
                
                
            }else{
                 cell.btnSelection.isHidden = true
            }
        cell.statusDescription?.text = r_status
    
            //        WHEN map_status = 10 THEN 'Pending'
            //        WHEN map_status = 20 THEN 'Accepted'
            //        WHEN map_status = 30 THEN 'Declined'
            //        WHEN map_status = 40 THEN 'Completed'
            //        WHEN map_status = 50 OR map_status = 51 THEN 'MoreInfo'
            //        WHEN map_status = 60 THEN 'Rejected'
            //        WHEN map_status = 70 THEN 'Verified'
            //        WHEN map_status = 90 THEN 'Withdraw'
            
            print(r_status)
          if r_status == "Pending"{
            
//            cell.statusDescription.textColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
            
//            if defaults == "Light Mode"{
//            cell.statusDescription.textColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
//            }else if defaults == "Dark Mode"{
//                cell.statusDescription.textColor = .white
            
//            }
    }else if r_status == "Accepted"{
                         
            cell.statusDescription.textColor = UIColor(red: 39.0/255.0, green: 174.0/255.0, blue: 96.0/255.0, alpha: 1.0)
                 
          }else if r_status == "Declined"{
                         
            cell.statusDescription.textColor = UIColor(red: 247.0/255.0, green: 142.0/255.0, blue: 30.0/255.0, alpha: 1.0)
          
          }else if r_status == "Completed"{
                         
            cell.statusDescription.textColor = UIColor(red: 39.0/255.0, green: 174.0/255.0, blue: 96.0/255.0, alpha: 1.0)
          
          }else if r_status == "More Info"{

            cell.statusDescription.textColor = UIColor(red: 247.0/255.0, green: 142.0/255.0, blue: 30.0/255.0, alpha: 1.0)
           
          }else if r_status == "More Info"{
                         
            cell.statusDescription.textColor = UIColor(red: 247.0/255.0, green: 142.0/255.0, blue: 30.0/255.0, alpha: 1.0)
            
          }else if r_status == "Rejected"{
                         
            cell.statusDescription.textColor = UIColor(red: 192.0/255.0, green: 57.0/255.0, blue: 43.0/255.0, alpha: 1.0)
                     
            }else if r_status == "Verified"{
            
                    cell.statusDescription.text = "Verified"
            cell.statusDescription.textColor = UIColor(red: 39.0/255.0, green: 174.0/255.0, blue: 96.0/255.0, alpha: 1.0)
            
            
          }else if r_status == "Withdrawn"{
            
            cell.statusDescription.textColor = UIColor(red: 247.0/255.0, green: 142.0/255.0, blue: 30.0/255.0, alpha: 1.0)
                     
            }
      
          var Comment = data["map_rank_comment"] as! String
            print(Comment)
            cell.RankComment.text = Comment
            self.changeRankField.text = Comment
            
            if Comment == ""{
                 cell.RankComment.text = " N/A"
        
             }
        let shift_rank = data["attend_rank"] as! String
         self.shiftrank = self.findRankStatus(rank:shift_rank)
        cell.RankDescription?.text = shiftrank
           
            
//            cell.starViewCell.rating = Double(data["attend_rank"]as! String ) ?? 0.0
//            cell.starViewCell.isUserInteractionEnabled = false
//            starView.isUserInteractionEnabled = true
//
            cell.updatebutton.tag = indexPath.row
       
        
            
        var statimg = self.findStatusImage(mapStatus: status as! String)
        cell.statusChanged.setBackgroundImage(UIImage(named:statimg), for: .normal)
        cell.delegateObj = self
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
        return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == self.tblChangeStatus){
            
        let indexPath = tblChangeStatus.indexPathForSelectedRow
                
                //getting the current cell from the index path
            let currentCell = tblChangeStatus.cellForRow(at: indexPath!)! as UITableViewCell
                
                //getting the text of that cell
                let currentItem = currentCell.textLabel!.text
            var selectStatus:String?
            if currentItem == "Decline" {
                selectStatus = "30"
            }else if currentItem == "Accept" {
                selectStatus = "20"
            }else if currentItem == "More Info" {
                selectStatus = "50"
            }else if currentItem == "Verify" {
                selectStatus = "70"
            }else if currentItem == "Reject" {
                selectStatus = "60"
            }
            //print(self.server_data)
            var stat1 = self.server_data!["map_id"] as! String
            //print(stat1)
            //print(selectStatus)
            
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            let params = userIDData["user_id"] as! String
            let user_device = UIDevice.current.identifierForVendor!.uuidString
            let data_dict = ["user_id":params,
                             "user_type":"CSO",
                             "user_device":user_device,
                             "map_id":stat1,
                             "map_status":selectStatus,
                             "attend_rank":shiftrank
                ] as [String : Any]
            let serviceHanlder = ServiceHandlers()
            serviceHanlder.csoChangeRequestStatus(data_dict:data_dict as! Dictionary) { (responce, isSuccess) in
                       if isSuccess {
                       let alert = UIAlertController(title: "Message", message: "", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.statusChangeView.isHidden = true
                        self.statusBackgroundView.isHidden = true
                        self.volunterData()
                        self.tblViewforAllRequest.reloadData()
                       }
                   }
        }
    }
    func configureRatingView()  {
            // Reset float rating view's background color
            starView.backgroundColor = UIColor.clear
            
            /** Note: With the exception of contentMode, type and delegate,
             all properties can be set directly in Interface Builder **/
            starView.delegate = self
            starView.contentMode = UIView.ContentMode.scaleAspectFit
            starView.type = .wholeRatings
            self.shiftRank = "2"
    //        if(self.screen == "EDIT SCREEN"){
    //            self.shiftRank = "3"        }
            self.selectedShiftTaskId = ""
        }
    
    func volunterData() {
        self.tblViewforAllRequest.delegate = nil
        self.tblViewforAllRequest.dataSource = nil
       
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
             let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
             let userID = userIDData["user_id"] as! String
             let serviceHanlder = ServiceHandlers()
             serviceHanlder.CsoAllRequest(user_id: userID as! String) { (responce, isSuccess) in
                 if isSuccess {
                    if (responce != nil) {
                        self.csoallrequest = responce as! [[String : Any]]
                        print(self.csoallrequest)
                        
                        if self.csoallrequest.count > 0 {
                      
                            self.tblViewforAllRequest.delegate = self
                        self.tblViewforAllRequest.dataSource = self
                         self.tblViewforAllRequest.reloadData()
                        }
                       
                    }else{
                        
                            self.tblViewforAllRequest.isHidden = true
                            
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data found", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                                            
                              alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                            
                        self.present(alert, animated: true, completion: nil)
                   }
                
            }
        }
    }
    @IBAction func changestatusbutton(_ sender: Any) {
        
    }
    
  func findRankImages(rank:String)->String{
        var r = Int(rank)
        var srank:String = ""
        switch r {
        case 1:
            srank = "rank_one.png"
            break
        case 2:
            srank = "rank_two.png"
            break
        case 3:
            srank = "rank_three.png"
            break
        case 4:
            srank = "rank_four.png"
            break
        case 5:
            srank = "rank_five.png"
            break
        default:
            srank = "rank_five.png"
        }
        return srank
    }
    func findRankStatus(rank:String)->String
    {
        var r = Int(rank)
        var srank:String = ""
        switch r {
        case 1:
            srank = "On cloud 9"
            break
        case 2:
            srank = "Keep on truckin"
            break
        case 3:
            srank = "Cool as a cucumber"
            break
        case 4:
            srank = "Piece of cake"
            break
        case 5:
            srank = "Rise and shine"
            break
        default:
            srank = "Rise and shine"
        }
        return srank
    }
    func findStatusImage(mapStatus:String)->String{
        let status:Int = Int(mapStatus)!
        var stat:String = ""
        switch status {
        case 10:
            stat = "pending.png"
            break
        case 20:
            stat =  "accepted-cso.png"
            break
        case 30:
            stat = "declined-cso.png"
            break
        case 40:
            stat = "completed-volunteer.png"
            break
        case 50:
            stat = "more-info.png"
            break
        case 51:
            stat = "more-info.png"
            break
        case 60:
            stat = "rejected-cso.png"
            break
        case 70:
            stat = "complete-verified.png"
            break
        case 90:
            stat = "withdrawn-volunteer.png"
            break
        default:
            stat = ""
        }
        //        WHEN map_status = 10 THEN 'Pending'
        //        WHEN map_status = 20 THEN 'Accepted'
        //        WHEN map_status = 30 THEN 'Declined'
        //        WHEN map_status = 40 THEN 'Completed'
        //        WHEN map_status = 50 OR map_status = 51 THEN 'MoreInfo'
        //        WHEN map_status = 60 THEN 'Rejected'
        //        WHEN map_status = 70 THEN 'Verified'
        //        WHEN map_status = 90 THEN 'Withdraw'
        
        return stat
    }
    func findStatus(mapStatus:String)->String {
       
        let status:Int = Int(mapStatus)!
        var stat:String = ""
        switch status {
        case 10:
                stat = "Waiting"
              
               break
        case 20:
                stat =  "Accepted"
                break
        case 30:
               stat = "Declined"
               break
        case 40:
               stat = "Completed"
               break
        case 50:
              stat = "More Info"
              break
        case 51:
              stat = "More Info"
              break
        case 60:
              stat = "Rejected"
              break
        case 70:
              stat = "Verified"
              break
        case 90:
              stat = "Withdrawn"
              break
        default:
            stat = ""
        }
//        WHEN map_status = 10 THEN 'Pending'
//        WHEN map_status = 20 THEN 'Accepted'
//        WHEN map_status = 30 THEN 'Declined'
//        WHEN map_status = 40 THEN 'Completed'
//        WHEN map_status = 50 OR map_status = 51 THEN 'MoreInfo'
//        WHEN map_status = 60 THEN 'Rejected'
//        WHEN map_status = 70 THEN 'Verified'
//        WHEN map_status = 90 THEN 'Withdraw'
        
        return stat
    }
    
    fileprivate func resetChangeStatusStackView(){
        changeStatus_stackView.addArrangedSubview(changeStatus_acceptView)
        changeStatus_stackView.addArrangedSubview(changeStatus_declineView)
        changeStatus_stackView.addArrangedSubview(changeStatus_verifyView)
        changeStatus_stackView.addArrangedSubview(changeStatus_rejectView)
        changeStatus_stackView.addArrangedSubview(changeStatus_moreInfoView)
        changeStatus_acceptView.isHidden = false
        changeStatus_declineView.isHidden = false
        changeStatus_verifyView.isHidden = false
        changeStatus_rejectView.isHidden = false
        changeStatus_moreInfoView.isHidden = false
        
        
    }
    @IBAction func statusFunction(_ sender: Any) {
        
        resetChangeStatusStackView()
        let data = self.server_data!
        print(data["map_status"])
        if !(((data["map_status"] as! String) == "90") || ((data["map_status"] as! String ) == "70") ){
        statusBackgroundView.isHidden = false
            StatusView.isHidden = false
           // view.bringSubviewToFront(self.StatusView)
            self.btnReject.isHidden = false
            self.btnMoreInfo.isHidden = false
            self.btnVerified.isHidden = false
            self.btnAccept.isHidden = false
             self.btnDecline.isHidden = false
      
            
            self.map_id = server_data!["map_id"] as! String
            switch (data["map_status"] as! String) {
            case "10":   // Pending : Gray
                self.strMoreInfoStatusValue = "50"
                self.btnReject.isHidden = true
                self.btnMoreInfo.isHidden = false
                self.btnVerified.isHidden = true
                self.btnDecline.isHidden = false
                self.btnAccept.isHidden = false
               
                
                verifyImage.isHidden = true
                rejectImage.isHidden = true
                moreinfoimage.isHidden = false
                declineImage.isHidden = false
                acceptImage.isHidden = false
                
                
                changeStatus_stackView.removeArrangedSubview(changeStatus_verifyView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_rejectView)
                changeStatus_verifyView.isHidden = true
                changeStatus_rejectView.isHidden = true
                

                break
            case "20":   // Accepted : Green
                self.btnReject.isHidden = true
                self.btnMoreInfo.isHidden = true
                self.btnVerified.isHidden = true
                self.btnAccept.isHidden = true
                self.btnDecline.isHidden = false
                
           
                               
                verifyImage.isHidden = true
                rejectImage.isHidden = true
                moreinfoimage.isHidden = true
                acceptImage.isHidden = true
                declineImage.isHidden = false
                
                changeStatus_stackView.removeArrangedSubview(changeStatus_acceptView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_verifyView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_rejectView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_moreInfoView)
                changeStatus_acceptView.isHidden = true
                changeStatus_verifyView.isHidden = true
                changeStatus_rejectView.isHidden = true
                changeStatus_moreInfoView.isHidden = true
                
                break
            
            case "30":   // Declined : red
                self.btnReject.isHidden = true
                self.btnMoreInfo.isHidden = true
                self.btnVerified.isHidden = true
                self.btnDecline.isHidden = true
                self.btnAccept.isHidden = false
                
                   
                verifyImage.isHidden = true
                rejectImage.isHidden = true
                moreinfoimage.isHidden = true
                declineImage.isHidden = true
                acceptImage.isHidden = false
                
                changeStatus_stackView.removeArrangedSubview(changeStatus_declineView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_verifyView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_rejectView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_moreInfoView)
                changeStatus_declineView.isHidden = true
                changeStatus_verifyView.isHidden = true
                changeStatus_rejectView.isHidden = true
                changeStatus_moreInfoView.isHidden = true
                
                break
           
            case "40":        //Completed: green
                self.strMoreInfoStatusValue = "51"
                self.btnAccept.isHidden = true
                self.btnDecline.isHidden = true
                self.btnVerified.isHidden = false
                self.btnReject.isHidden = false
                self.btnMoreInfo.isHidden = false
                
              
                                                            
                verifyImage.isHidden = false
                rejectImage.isHidden = false
                moreinfoimage.isHidden = false
                declineImage.isHidden = true
                acceptImage.isHidden = true
                
                changeStatus_stackView.removeArrangedSubview(changeStatus_acceptView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_declineView)
                
                changeStatus_acceptView.isHidden = true
                changeStatus_declineView.isHidden = true
                
                
                 break
         
          case "51":         //  More Info : Orange
                self.btnMoreInfo.isHidden = true
                 self.btnReject.isHidden = false
                self.btnVerified.isHidden = false
                self.btnDecline.isHidden = true
                self.btnAccept.isHidden = true
                
                                                                                    
                verifyImage.isHidden = false
                rejectImage.isHidden = false
                moreinfoimage.isHidden = true
                declineImage.isHidden = true
                acceptImage.isHidden = true
                

                changeStatus_stackView.removeArrangedSubview(changeStatus_acceptView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_declineView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_moreInfoView)
                
                
                changeStatus_acceptView.isHidden = true
                changeStatus_declineView.isHidden = true
                changeStatus_moreInfoView.isHidden = true
                

                break
                
            case "50":          //  More Info : Orange
                self.btnMoreInfo.isHidden = true
                self.btnReject.isHidden = true
                self.btnVerified.isHidden = true
                self.btnDecline.isHidden = false
                self.btnAccept.isHidden = false
                                                                                           
                verifyImage.isHidden = true
                rejectImage.isHidden = true
                moreinfoimage.isHidden = true
                declineImage.isHidden = false
                acceptImage.isHidden = false
                
                changeStatus_stackView.removeArrangedSubview(changeStatus_verifyView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_rejectView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_moreInfoView)
                
                
                changeStatus_verifyView.isHidden = true
                changeStatus_rejectView.isHidden = true
                changeStatus_moreInfoView.isHidden = true

                break
                
            case "60":        // Rejected : orange
                self.btnAccept.isHidden = true
                self.btnDecline.isHidden = true
                self.btnReject.isHidden = true
                self.btnMoreInfo.isHidden = false
                self.btnVerified.isHidden = false
                
         
                                                                                          
                verifyImage.isHidden = false
                rejectImage.isHidden = true
                moreinfoimage.isHidden = false
                declineImage.isHidden = true
                acceptImage.isHidden = true
                
                changeStatus_stackView.removeArrangedSubview(changeStatus_declineView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_rejectView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_acceptView)
                
                
                changeStatus_declineView.isHidden = true
                changeStatus_rejectView.isHidden = true
                changeStatus_acceptView.isHidden = true
                
                break
                
            default:
                changeStatus_stackView.removeArrangedSubview(changeStatus_declineView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_rejectView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_acceptView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_verifyView)
                changeStatus_stackView.removeArrangedSubview(changeStatus_moreInfoView)
                
                
                
                changeStatus_declineView.isHidden = true
                changeStatus_rejectView.isHidden = true
                changeStatus_acceptView.isHidden = true
                 changeStatus_verifyView.isHidden = true
                 changeStatus_moreInfoView.isHidden = true
            }
    
        }
        else {
            statusBackgroundView.isHidden = true
                   StatusView.isHidden = true
        }
        
//        self.view.layoutIfNeeded()
    }
    
    @IBAction func cancelStatus(_ sender: Any) {
       
    }
    
    @IBAction func addStatusWithComment(_ sender: Any) {
        
        //print("Add Status")
    }
    
    
    @IBAction func ChangeRankCancelButton(_ sender: Any) {
        
        changeRank1View.isHidden = true
        ChangeRank2View.isHidden = true
        
        
    }
    

       @IBAction func backbutton(_ sender: Any) {
        
            dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func ChangeRankDoneButton(_ sender: Any) {
        
        self.ChangingRank()
        
        updateHoursView1.isHidden = false
        updateHoursView2.isHidden = false
       
    }
    
    func ChangingRank(){
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
               let userID = userIDData["user_id"] as! String
               let comm = self.changeRankField.text

               //print(userID)
               //print(self.starView.rating)
               //print(comm)
             
               let params = ["user_id":userID ,
                             "user_type":"CSO",
                           "user_device":UIDevice.current.identifierForVendor!.uuidString as! String,
                             "vol_id": self.server_data!["user_id"] as! String,
                             "attend_rank":starView.rating,
                             "map_id":self.mapID,
                             "map_rank_comment":comm as! String
                   ] as [String : Any?]
               //print(params)
               let serviceHanlder = ServiceHandlers()
               serviceHanlder.changeRankinVol(data:params) { (responce, isSuccess) in
                   if isSuccess {

                       self.changeRankField.text = ""
                       
                       self.changeRank1View.isHidden = true
                       self.ChangeRank2View.isHidden = true
                    self.StatusView.isHidden = true
                    self.statusBackgroundView.isHidden = true
                      // self.volunterData()
                       //self.tblViewforAllRequest.reloadData()
                   }
               }
    }

    @IBAction func btnAcceptMethod(_ sender: Any) {
        self.change_status = "20"
        changeStatusMethod()
    }
 
    @IBAction func btnDeclineMethod(_ sender: Any) {
         self.change_status = "30"
      
        print("Decline")
       
        StatusView.isHidden = true
        statusBackgroundView.isHidden = true
       
         outerCommentView.isHidden = false
         mainAddCommentView.isHidden = false
       
        self.txtAddComment.text = ""
        
//        changeStatusMethod()
    }

    @objc  func didTapView(){
      self.view.endEditing(true)
    }
    @IBAction func btnVerified(_ sender: Any) {
         self.change_status = "70"
        
        self.lblChangeHours.text = self.server_data!["attend_hours_vol"] as! String
        var rank = self.server_data!["attend_rank"] as! String
               print(rank)
               
               if rank == ""{
   
                StatusView.isHidden = true
                statusBackgroundView.isHidden = true
                
                changeRank1View.isHidden = false
                ChangeRank2View.isHidden = false
                
               }else{
                // go to step for hours
                StatusView.isHidden = true
                statusBackgroundView.isHidden = true
                updateHoursView1.isHidden = false
                updateHoursView2.isHidden = false
        }
       
      //  changeStatusMethod()
}
    @IBAction func btnRejectMethod(_ sender: Any) {
         self.change_status = "60"
        
        let alert = UIAlertController(title: nil, message: NSLocalizedString("Request Rejected", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                            
              alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        changeStatusMethod()
    }
    @IBAction func btnMoreInfoMethod(_ sender: Any) {
        // self.change_status = "50"
      self.change_status = self.strMoreInfoStatusValue
       
         changeStatusMethod()
    }
    
    func changeStatusMethod() {
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                       let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                       let user_id = userIDData["user_id"] as! String

        let params = ["user_id": user_id,
        "user_type" : "CSO",
        "user_device" : UIDevice.current.identifierForVendor!.uuidString,
        "map_id": self.server_data!["map_id"] as! String,
        "map_status": self.change_status,
        "map_status_comment": self.txtAddComment.text] as [String : Any]
        
        print(params)
      
        let servicehandler = ServiceHandlers()
        servicehandler.changeStatus(data_details: params){(responce,isSuccess) in
            if isSuccess{
//
                    self.StatusView.isHidden = true
                    self.statusBackgroundView.isHidden = true
                self.change_status = nil
                    self.volunterData()
            }
        }
    }
    func changeHoursMethod(){
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                             let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                             let user_id = userIDData["user_id"] as! String
           
             let params = ["user_id":user_id,
                            "user_type":"CSO",
                            "user_device":UIDevice.current.identifierForVendor!.uuidString,
                            "map_id":map_id,
                            "attend_hours": self.enteringHours.text!,
                            "vol_id":self.server_data!["user_id"] as! String
              ]
                  print(params)
            
              let servicehandler = ServiceHandlers()
        servicehandler.ChangeHours(data:params) { (responce, isSuccess) in
           if isSuccess{
            
                          self.StatusView.isHidden = true
                          self.statusBackgroundView.isHidden = true
            self.changeStatusMethod()
            // call for change request
                         // self.volunterData()
            
                  }
              }
            }

    @IBAction func btnhoursDone(_ sender: Any) {
        updateHoursView1.isHidden = true
        updateHoursView2.isHidden = true
        
        StatusView.isHidden = true
        statusBackgroundView.isHidden = true
        self.changeHoursMethod()
        
        
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
    }
    
    @IBAction func rank_one(_ sender: Any) {
        self.imgRank.image = UIImage(named: "rank_one.png")
        self.lbnRank.text = "On cloud 9"
        self.attend_rank = "1"
    }
    
    
    
    @IBAction func rank_two(_ sender: Any) {
        self.imgRank.image = UIImage(named: "rank_two.png")
        self.lbnRank.text = "Keep on truckin"
        self.attend_rank = "2"
    }
    
    @IBAction func rank_three(_ sender: Any) {
        self.imgRank.image = UIImage(named: "rank_three.png")
        self.lbnRank.text = "Cool as a cucumber"
        self.attend_rank = "3"
    }
    
    @IBAction func rank_four(_ sender: Any) {
        self.imgRank.image = UIImage(named: "rank_four.png")
        self.lbnRank.text = "Piece of cake"
        self.attend_rank = "4"
    }
    
    
    
    @IBAction func rank_five(_ sender: Any) {
        self.imgRank.image = UIImage(named: "rank_five.png")
        self.lbnRank.text = "Rise and shine"
        self.attend_rank = "5"
    }
    
    @IBAction func rankFunction(_ sender: Any) {
        
                changeRank1View.isHidden = false
                ChangeRank2View.isHidden = false
 
    }
    func tagNumberForchat(tag:Int){
        
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
                                    vc.modalPresentationStyle = .fullScreen
                                        self.present(vc,animated: true)
                                       // self.ChangeStatusSelection()
                            //
                            //            //print("Chat")
                                       })
                         }
        
    }
    
    func tagNumberForStatusChange(tag: Int) {
        self.server_data = self.csoallrequest[tag] as Dictionary // Reetesh 21 Jan

    }
    func tagNumberForRankChange(tag: Int) {
         self.server_data = self.csoallrequest[tag] as Dictionary
        self.mapID = server_data!["map_id"] as! String

        print(tag)
        //print(rating)
        //print(mapID)
        let data:NSDictionary = self.csoallrequest[tag] as NSDictionary
        if change_status == "70"{
        
 self.starView.rating =  Double(data["attend_rank"]as! String ) ?? 0.0
        changeRank1View.isHidden = false
        ChangeRank2View.isHidden = false
        
        }else{

            changeRank1View.isHidden = true
            ChangeRank2View.isHidden = true
        }
      }
    func tagNumberForSelection(tag: Int) {
        print(tag)
        
        let indexPath = NSIndexPath(row: tag, section: 0)
        let cell = self.tblViewforAllRequest.cellForRow(at: indexPath as IndexPath) as! CSOManageRequestTableViewCell
        
        if arrSelectedIndexForTick.contains(tag) {
            self.arrSelectedIndexForTick = self.arrSelectedIndexForTick.filter(){$0 != tag }
           cell.btnSelection.setImage(UIImage(named: "black-square-png.png"), for: .normal)
        }else{
            cell.btnSelection.setImage(UIImage(named: "newtickbox.png"), for: .normal)
            self.arrSelectedIndexForTick.append(tag)
        }
         print(arrSelectedIndexForTick)
        
    }
    
    
    @IBAction func checkUncheckAll(_ sender: Any) {
        
        
        if btnCheckAll.tag == 0{
            
            print("Select all")
          //  print(arrIndexForTick)
           let unique = Array(Set(arrIndexForTick))
            arrSelectedIndexForTick = unique
            btnCheckAll.tag = 1
             print(arrSelectedIndexForTick)
            btnCheckAll.setTitle("Uncheck All Waiting Requests", for: .normal)
        }else{
            print("De Select all")
            
            arrSelectedIndexForTick.removeAll()
            btnCheckAll.tag = 0
            print(arrSelectedIndexForTick)
            btnCheckAll.setTitle("Check All Waiting Requests", for: .normal)
        }
        self.tblViewforAllRequest.reloadData()
        
    }
    
    @IBAction func AcceptAllCheckRequest(_ sender: Any) {
        
        
        // hit for services
        
        print(arrSelectedIndexForTick)
        
        if arrSelectedIndexForTick.count > 0 {
            
            
            let strMapIds =  self.getMapidForIndexes()
            print(strMapIds)
            
            // create the alert
                   let alert = UIAlertController(title: "Group Accept", message: "Are you sure to accept requests in group?", preferredStyle: UIAlertController.Style.alert)

                   // add the actions (buttons)
                   alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: nil))
                  alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { action in

                       // do something like...
                      // Time to call service
                    self.serviceCallforMultipleRequest(strMapIds: (strMapIds))

                   }))

                   // show the alert
                   self.present(alert, animated: true, completion: nil)
               
            
        }else{
            
            let alert = UIAlertController(title: "Check waiting requests to be accepted", message: "", preferredStyle: .alert)

                                   alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                   self.present(alert, animated: true, completion: nil)
        }
    }
    func getMapidForIndexes()->String{
        var strMapids = ""
        for selectedIndex in arrSelectedIndexForTick{
            let data:NSDictionary = self.csoallrequest[selectedIndex] as NSDictionary
                       print(data)
           
            strMapids +=  (data["map_id"] as! String) + ","
        }
        
        strMapids.remove(at: strMapids.index(before: strMapids.endIndex))
        return strMapids
    }
    func serviceCallforMultipleRequest(strMapIds: String ){
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                               let user_id = userIDData["user_id"] as! String

                let params = ["user_id": user_id,
                "user_type" : "CSO",
                "user_device" : UIDevice.current.identifierForVendor!.uuidString,
                "all_map_id": strMapIds,
                "map_status": "20",
                "map_status_comment": ""]
                
                print(params)
              
                let servicehandler = ServiceHandlers()
                servicehandler.acceptMultipleRequest(data_details: params){(responce,isSuccess) in
                    if isSuccess{
        //
                            self.StatusView.isHidden = true
                            self.statusBackgroundView.isHidden = true
                        self.change_status = nil
                        let alert = UIAlertController(title: "Requests Sent Successfully!", message: "", preferredStyle: .alert)

                                               alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                               self.present(alert, animated: true, completion: nil)
                            self.volunterData()
                    }else{
                        
                        let alert = UIAlertController(title: "Error Occured!", message: "", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        
    }
    
    
    
   }

extension CSORequest:UITabBarControllerDelegate {
    
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
    func removeAllOtherViewsOfVC(viewcontroller:UIViewController)  {
    
    for vc in viewcontroller.children {
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
}
 }
extension CSORequest:FloatRatingViewDelegate{
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
           
           
       }
       
       func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
           
           self.shiftRank = String(Int(rating))
       }
    
    
}
