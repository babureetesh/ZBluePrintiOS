//
//  volunteerSeeFollowers.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 27/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import SendBirdSDK

class volunteerSeeFollowers: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,delegateSeeFollowers {
   

  
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var seeFollowersLabels: UILabel!
    
    @IBOutlet weak var VolunteerLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var SearchKey: UITextField!
    
    @IBOutlet weak var tblView: UITableView!
    
    var listDetails:Array<Any> = Array()
    
    @IBOutlet weak var button2view: UIView!
    
    @IBOutlet weak var button1vol: UIButton!
    
    @IBOutlet weak var button2vol: UIButton!
    var filteredData:Array<Any> = Array()
    
    
    @IBOutlet weak var btnUnlinkTapped: UIButton!
    
    let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
    
    @IBAction func NotificationButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
               let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
                 present(obj,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // VolunteerLabel.isHidden = false
//              seeFollowersLabels.isHidden = false
        self.profile_pic()
        tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:150, right: 0)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
//        if defaults == "Dark Mode"{
//
//            DarkMode()
//
//        }else if defaults == "Light Mode"{
//
//            LightMode()
//        }
      self.searchBar.delegate = self
        self.tblView.delegate = self
        self.tblView.dataSource = self
       self.tabBarController?.delegate = self
        
        view.sendSubviewToBack(button2view)
        self.getList()
        VolunteerLabel.isHidden = true // reetesh
        seeFollowersLabels.isHidden = false
      //  if defaults == "Light Mode"{
        button1vol.setTitleColor(.black, for: .normal)
        button2vol.setTitleColor(.gray, for: .normal)
       
//        }else if defaults == "Dark Mode" {
//            button1vol.setTitleColor(.white, for: .normal)
//            button2vol.setTitleColor(.gray, for: .normal)
//
//        }
        self.tblView.reloadData()
    }
    
    func DarkMode() {
      
        self.view.backgroundColor = .black
        self.button1vol.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.button1vol.backgroundColor = .black
        
        self.button2vol.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.button2vol.backgroundColor  = .black
        self.view.backgroundColor = .black
        
        self.searchBar.barTintColor = .black
        tblView.backgroundColor = .black
        self.backButton.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        
      
        
   }
    func LightMode() {
        self.view.backgroundColor = .white
        self.button1vol.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.button1vol.backgroundColor = .white
        
        self.button2vol.setTitleColor(UIColor.black, for: UIControl.State.normal)
         self.button2vol.backgroundColor  = .white
        self.view.backgroundColor = .white
        self.searchBar.barTintColor = .white
        
         self.backButton.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
        
       
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
    func getList() {
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let params = userIDData["user_id"] as! String
    
               // Do any additional setup after loading the view.
             
               let servicehandler = ServiceHandlers()
               servicehandler.searchEvent(data: params){(responce,isSuccess)in
                   if isSuccess{
                   
                    if(responce == nil){
                        
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                        self.present(alert,animated: true)
                        self.tblView.delegate = nil
                        self.tblView.dataSource = nil
                        //self.tblView.isHidden = true
                        self.filteredData.removeAll()
                    self.tblView.setContentOffset(.zero, animated: true)
                    }else{
                        
                        self.listDetails = responce as! Array<Any>
                        print(self.listDetails)
                       self.filteredData.removeAll()
                        if self.listDetails.count > 0 {
                        self.filteredData = self.listDetails
                            self.tblView.delegate = self
                            self.tblView.dataSource = self
                            //self.tblView.isHidden = false
                        self.tblView.reloadData()
                            self.tblView.setContentOffset(.zero, animated: true)
                        
                    }else{
            self.tblView.delegate = nil
            self.tblView.dataSource = nil
                            self.filteredData.removeAll()
                            self.tblView.setContentOffset(.zero, animated: true)
           // self.tblView.isHidden = true
        let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                self.present(alert,animated: true)
                            
                        }
                    }
                   }else{
                    let alert = UIAlertController(title: nil, message: NSLocalizedString("Error Occured!", comment: ""), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                            self.present(alert,animated: true)
                }
                   
               }
               
    }
    func chatClicked(selectedRow:Int){
        
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
    func unlinkClicked(selectedRow:Int){
       
        //print(selectedRow)
        
     
        //print(filteredData[selectedRow])
        
        let unlinkFollowersAlert = UIAlertController(title: NSLocalizedString("UNLINK USER", comment: ""), message: NSLocalizedString("Do you want to unlink?", comment: ""), preferredStyle: UIAlertController.Style.alert)

        unlinkFollowersAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
            self.unlinkFollowers(dataToUnlink: self.filteredData[selectedRow] as! [String : Any])
          }))

        unlinkFollowersAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
          //print("Handle Cancel Logic here")
          }))

        present(unlinkFollowersAlert, animated: true, completion: nil)
        
    }
    func unlinkFollowers(dataToUnlink:[String:Any]){
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>

          
        
        let params = ["cso_id":userIDData["user_id"],"vol_id":dataToUnlink["user_id"] as! String,
                       "user_device":UIDevice.current.identifierForVendor!.uuidString]

                   let servicehandler = ServiceHandlers()
        servicehandler.UnlinkFollowers(params: params) { (responce, isSuccess) in
            if isSuccess{
                       self.getList()
                
                
            }else{
                //self.getList()
                let alert = UIAlertController(title: nil, message: NSLocalizedString("Error Occured!", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                self.tblView.delegate = nil
                self.tblView.dataSource = nil
               // self.tblView.isHidden = true
                self.present(alert, animated: true)
            }
            
            
        }
          }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.filteredData.count == 0{
        return 0
    }else{
        return filteredData.count
    }
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as! SeeFollowersTableViewCell
        if (filteredData.count != 0) {
            let data = filteredData[indexPath.row] as? Dictionary<String,Any>
            //print(data)
//            if defaults == "Dark Mode"{
//
//                cell.backgroundColor =  .black
//                cell.StudentName.textColor = .white
//                cell.emailLAbel.textColor = .white
//                cell.NumberLabel.textColor = .white
//                cell.AttendedHrsLbn.textColor = .white
//                cell.AverageRateView.backgroundColor = .clear
//               cell.lightStarView.isHidden = true
//
//                cell.name.textColor = .white
//                cell.email.textColor = .white
//                cell.rankAverage.textColor = .white
//                cell.attendRating.textColor = .white
//                cell.phone.textColor = .white
//                cell.attendhour.textColor = .white
//
//
//
//
//                if let fullRatingString = data!["user_avg_rating"] as? String {
//                    let yourInt1 = Float(fullRatingString)                        // converting String to Int
//                    var rates = String(format: "%.0f", yourInt1!)             // rounding off the rate
//                    let fullRatingArr = rates.components(separatedBy: ".")
//                    var firstRating: String = fullRatingArr[0]
//                    cell.AverageRateView.rating = Double(firstRating)!
//                }
//
//            }else if defaults == "Light Mode" {
//
                 cell.backgroundColor =  .white
                cell.StudentName.textColor = .black
                cell.emailLAbel.textColor = .black
                cell.NumberLabel.textColor = .black
                cell.AttendedHrsLbn.textColor = .black
                cell.AverageRateView.backgroundColor = .clear
                cell.lightStarView.isHidden = false
             
                
                cell.name.textColor = .black
                cell.email.textColor = .black
                cell.rankAverage.textColor = .black
                cell.attendRating.textColor = .black
                cell.phone.textColor = .black
                cell.attendhour.textColor = .black
                
                if let fullRatingString = data!["user_avg_rating"] as? String {
                    let yourInt1 = Float(fullRatingString)                        // converting String to Int
                    var rates = String(format: "%.0f", yourInt1!)             // rounding off the rate
                    let fullRatingArr = rates.components(separatedBy: ".")
                    var firstRating: String = fullRatingArr[0]
                    cell.lightStarView.rating = Double(firstRating)!
                }
           // }
         let student_f_name = data!["user_f_name"] as! String
            let student_l_name = data!["user_l_name"] as! String
            let std_name:String = "\(student_f_name)  \(student_l_name)"
            cell.StudentName.text = std_name as String
            var Phone = self.formattedNumber(number:(data!["user_phone"] as? String)!)
            //print(Phone)
            cell.NumberLabel.text = Phone
            cell.NumberLabel.isEnabled = true
            cell.delegate = self
//            cell.btnUnlinkFollowersTapped.tag = indexPath.row     prachi
            
            ////print(data!["user_avg_rating"] as! String)
          
//            if let fullRatingString = data!["user_avg_rating"] as? String {
//                let yourInt1 = Float(fullRatingString)                        // converting String to Int
//                var rates = String(format: "%.0f", yourInt1!)             // rounding off the rate
//                let fullRatingArr = rates.components(separatedBy: ".")
//                var firstRating: String = fullRatingArr[0]
//                cell.AverageRateView.rating = Double(firstRating)!
//            }
        cell.AverageRateView.isUserInteractionEnabled = false
            cell.lightStarView.isUserInteractionEnabled = false
            
                       
            cell.RankImage.image = UIImage(named: findingAverageRank(user_hours: data!["user_hours"] as! String , user_hours_req: data!["user_hours_req"] as! String))
           
            cell.emailLAbel.text = data!["user_email"] as? String
            cell.AttendedHrsLbn.text = (data!["user_hours"] as! String + " Hrs")
            let rank_img = self.findRankImages(rank: data!["user_rank"] as! String)
//            cell.RankImage.setBackgroundImage(UIImage(named: rank_img), for: .normal)
        }
        return cell
      }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 277.0
    
    }
    
    func findingAverageRank(user_hours:String , user_hours_req:String)->String{
        
       
    
        var percent = (Int(user_hours)!) * (Int(user_hours_req)!)/100
        //print(percent)
        
        
        if percent >= 0 && percent <= 20 {
            
//          var Image1 = UIImage(named:"rank_five.png")
//            //print(Image1)
            return "rank_five.png"    //risenshine
    }else
            if percent >= 21 && percent <= 40 {
               
//                var Image2 = UIImage(named:"rank_four.png")
//                           //print(Image2)
                return "rank_four.png"    //cacke.png
        }else
                if percent >= 41     && percent <= 60  {
                    
//                    var Image3 = UIImage(named:"rank_three.png")
//                    //print(Image3)
                    return "rank_three.png"   //coll.png
        }else
            if percent >= 61 && percent <= 80{
    
                     //var Image4 = UIImage(named:"rank_two.png")
                     ////print(Image4)
                return "rank_two.png"    //truck.png
        }else
            if percent >= 81 && percent <= 100{
                        //var Image5 = UIImage(named:"rank_one.png")
                          //         //print(Image5)
                
                return "rank_one.png"    // cloud.png
        }else
            if percent >= 100 {
                                
       // var Image6 = UIImage(named:"rank_one.png")
         //   //print(Image6)
                   return "rank_one.png"   // cloud.png
        }
    return "rank_five.png"
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
     @IBAction func button1(_ sender: Any) {
        
        VolunteerLabel.isHidden = true//reetesh
        seeFollowersLabels.isHidden = false
        view.sendSubviewToBack(button2view)
        
     //   if defaults == "Light Mode"{
        button1vol.setTitleColor(.black, for: .normal)
        button2vol.setTitleColor(.gray, for: .normal)
//        }else  if defaults == "Dark Mode"{
//            button1vol.setTitleColor(.white, for: .normal)
//            button2vol.setTitleColor(.gray, for: .normal)
//        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

            // filterdata  = searchText.isEmpty ? data : data.filter {(item : String) -> Bool in
          
        filteredData = searchText.isEmpty ? listDetails : listDetails.filter { (($0 as AnyObject)["user_f_name"] as! String).localizedCaseInsensitiveContains(searchText) }
           tblView.reloadData()
    }
 
 @IBAction func button2(_ sender: Any) {
 
        
        VolunteerLabel.isHidden = false
        seeFollowersLabels.isHidden = true
        
            view.bringSubviewToFront(button2view)
    
   // if defaults == "Light Mode"{
            button1vol.setTitleColor(.gray, for: .normal)
            button2vol.setTitleColor(.black, for: .normal)
//    }else  if defaults == "Dark Mode"{
//        button1vol.setTitleColor(.gray, for: .normal)
//        button2vol.setTitleColor(.white, for: .normal)
//
//    }
    
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "request") as! CSORequest
        obj.strShowClose = "NO"
         obj.view.frame.size.height = button2view.frame.size.height
//        obj.tblViewforAllRequest.frame.size.height = button2view.frame.size.height - 100
        obj.screen = "VolunteerSeeFollowers"
//        obj.table_height = button2view.frame.size.height
        obj.willMove(toParent: self)
        button2view.addSubview(obj.view)
        self.addChild(obj)
        obj.didMove(toParent: self)
    
    self.view.layoutIfNeeded()
    }
 
    func findRankImages(rank:String)->String{
           var r = Int(rank)
           var srank:String = ""
           switch r {
           case 1:
               srank = "cloud.png"   //cloud,rank_one.png
               break
           case 2:
               srank = "truck.png"    //truck,rank_two.png
               break
           case 3:
               srank = "coll.png"    //cucumber,rank_three.png
               break
           case 4:
               srank = "cacke.png"    //cake,rank_four.png
               break
           case 5:
               srank = "risenshine.png"    // sun rise,rank_five.png
               break
           default:
               srank = "risenshine.png"     //sun rise,rank_five.png
           }
           return srank
       }
  
}


extension volunteerSeeFollowers:UITabBarControllerDelegate {

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
             button1vol.setTitleColor(.black, for: .normal)
            button2vol.setTitleColor(.gray, for: .normal)
            view.sendSubviewToBack(button2view)
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
