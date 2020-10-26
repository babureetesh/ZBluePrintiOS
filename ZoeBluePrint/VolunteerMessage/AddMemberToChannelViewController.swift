//
//  AddMemberToChannelViewController.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 19/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
import SendBirdSDK
class AddMemberToChannelViewController: UIViewController,delegateNewMemberSelectionlistCell,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var csoProfilePic: UIImageView!
    @IBOutlet weak var volProfilePic: UIImageView!
     @IBOutlet weak var imgViewCsoCover: UIImageView!
    @IBOutlet weak var csoHeaderView:UIView!
    @IBOutlet weak var volHeaderView:UIView!
    @IBOutlet weak var headerViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var imgCoverPic: UIImageView!
    @IBOutlet weak var tblCnnctduserList: UITableView!
    var connectedUserList = [[String:Any]]()
    var channel: SBDGroupChannel!
    var arrExistingUser : Array<String> = []
        var dataArray = [[String:Any]]()
        var selectedData : Array<String> = []
        var strChannelType : String = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
    //self.viewCreateChannel.isHidden = true
            // Do any additional setup after loading the view.
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
             let userid = userIDData["user_id"] as! String
            let usertype = userIDData["user_type"] as! String
            if (usertype == "CSO"){
                //time to handle Header acording to Cso
            }else{
                //time to handle Header acording to VOL
            }
            self.callforConnecteduser()
        }
    
    func setProfilePic()  {
       
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let usertype = userIDData["user_type"] as! String
        if (usertype == "CSO"){
            //time to handle Header acording to Cso
            imgCoverPic.isHidden = true
            volHeaderView.isHidden = true
//            if let image = UIImage(data: imageData) {
//                self.csoProfilePic.image = image
//                self.csoProfilePic.layer.borderWidth = 1
//                self.csoProfilePic.layer.masksToBounds = false
//                self.csoProfilePic.layer.borderColor = UIColor.black.cgColor
//                self.csoProfilePic.layer.cornerRadius = self.csoProfilePic.frame.height/2
//                self.csoProfilePic.clipsToBounds = true
//            }
            
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
            let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if let dirPath          = paths.first
            {
               let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
                if let image    = UIImage(contentsOfFile: imageURL.path){
                                        self.csoProfilePic.image = image
                                          self.csoProfilePic.layer.borderWidth = 1
                                          self.csoProfilePic.layer.masksToBounds = false
                                          self.csoProfilePic.layer.borderColor = UIColor.black.cgColor
                                          self.csoProfilePic.layer.cornerRadius = self.csoProfilePic.frame.height/2
                                          self.csoProfilePic.clipsToBounds = true
                }
               // Do whatever you want with the image
            }
          
        } else {
            //time to handle Header acording to VOL
            self.getCoverImageForRank()
            csoHeaderView.isHidden = true
//            if let image = UIImage(data: imageData) {
//                self.volProfilePic.image = image
//                self.volProfilePic.layer.borderWidth = 1
//                self.volProfilePic.layer.masksToBounds = false
//                self.volProfilePic.layer.borderColor = UIColor.black.cgColor
//                self.volProfilePic.layer.cornerRadius = self.csoProfilePic.frame.height/2
//                self.volProfilePic.clipsToBounds = true
//            }
            
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
            let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if let dirPath          = paths.first
            {
               let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
                if let image    = UIImage(contentsOfFile: imageURL.path){
                                        self.volProfilePic.image = image
                                          self.volProfilePic.layer.borderWidth = 1
                                          self.volProfilePic.layer.masksToBounds = false
                                          self.volProfilePic.layer.borderColor = UIColor.black.cgColor
                                          self.volProfilePic.layer.cornerRadius = self.volProfilePic.frame.height/2
                                          self.volProfilePic.clipsToBounds = true
                }
               // Do whatever you want with the image
            }
         
        }
        
        self.view.layoutIfNeeded()
    }
    
    @IBAction func notificationBellTapped(_ sender: Any) {
                 
                 let sb = UIStoryboard(name: "Main", bundle: nil)
                 let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
                   present(obj,animated: true)
             }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
               let usertype = userIDData["user_type"] as! String
               if (usertype == "CSO"){
                   self.imgViewCsoCover.image = UIImage(named:UserDefaults.standard.string(forKey: "csocoverpic")!)
               }
        
        self.getCoverImageForRank()
                setProfilePic()
                           
    }
    func getCoverImageForRank(){
          
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
         let userid = userIDData["user_id"] as! String
        let usertype = userIDData["user_type"] as! String
        if (usertype == "VOL"){
          var strImageNameCover = "cover_cloud.jpg"
            if let decoded  = UserDefaults.standard.object(forKey: "VolData") as? Data,let volData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as?  Dictionary<String, Any>, (volData["user_avg_rank"] != nil){
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
          self.imgCoverPic.image = UIImage(named:strImageNameCover)
          
        }
      }
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
        func callforConnecteduser(){
            ActivityLoaderView.startAnimating()
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
             let userid = userIDData["user_id"] as! String
            let usertype = userIDData["user_type"] as! String
            //user_email
            //user_type
            let servicehandler = ServiceHandlers()
                                     servicehandler.getConnectedUser(user_id:userid,user_type: usertype){(responce,isSuccess) in
                                         if isSuccess{
                                            self.connectedUserList = responce as! [[String : Any]]
                                           
                                            print(self.connectedUserList)
                                            self.fillterArray()
                                            
                                        }
                                            }
            }
            
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.dataArray.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tblCnnctduserList.dequeueReusableCell(withIdentifier: "memberselectioncell") as! AddChannelMemberSelectionTableViewCell
            //user_f_name
            
            cell.lblUserName.text = "\(self.dataArray[indexPath.row]["user_f_name"] ?? "") \( self.dataArray[indexPath.row]["user_l_name"] ?? "")"
            cell.lblEmail.text = self.dataArray[indexPath.row]["user_email"] as? String
                    cell.delegate = self
                    cell.btnCheckMark.tag = indexPath.row
            cell.imgUserImage.image = UIImage(named: "user_email.png")
            
            if selectedData.contains(self.dataArray[indexPath.row]["user_id"] as! String) {
               // cell.accessoryType = .checkmark
                //newtickbox
                cell.btnCheckMark.setImage(UIImage(named: "newtickbox.png"), for: .normal)
            }else{
                //cell.accessoryType = .none
                 cell.btnCheckMark.setImage(UIImage(named: "black-square-png.png"), for: .normal)
                //black-square-png
            }
            return cell
        }


        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

          /*  if selectedData.contains(self.dataArray[indexPath.row]["user_email"] as! String) {


                if let index = selectedData.index(of: self.dataArray[indexPath.row]["user_email"] as! String) {
                    selectedData.remove(at: index)
                }
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                
            }else {

                selectedData.append(self.dataArray[indexPath.row]["user_email"] as! String)
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            print(selectedData)*/
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100.0
        
        }
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    //    }
        func checkMarkClicked(selectedRow:Int){
           
            let myIndexPath = IndexPath(row: selectedRow, section: 0)
            let cell = self.tblCnnctduserList.cellForRow(at: myIndexPath) as! AddChannelMemberSelectionTableViewCell
            if selectedData.contains(self.dataArray[myIndexPath.row]["user_email"] as! String)  {
                if let index = selectedData.index(of: self.dataArray[myIndexPath.row]["user_email"] as! String) {
                           selectedData.remove(at: index)
                       }
                cell.btnCheckMark.setImage(UIImage(named: "black-square-png.png"), for: .normal)
                print(self.selectedData)
                   }

            else{
                
                let applicationUserListQueryByIds = SBDMain.createApplicationUserListQuery()
                       applicationUserListQueryByIds?.userIdsFilter = [self.dataArray[myIndexPath.row]["user_email"] as! String]
                       applicationUserListQueryByIds?.loadNextPage(completionHandler: { (users, error) in
                           guard error == nil else {// Error.
                               return
                           }
                             //SBDUserConnectionStatus //SBDUserConnectionStatusNonAvailable = 0,
                                      if (users!.count > 0){
                                         if Int(users![0].connectionStatus.rawValue) == 0{
                                            let name = self.dataArray[myIndexPath.row]["user_f_name"] as! String
                                                        let alert = UIAlertController(title: nil, message: " \(name) not registered in messenger", preferredStyle: UIAlertController.Style.alert)
                                                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                        self.present(alert, animated: true, completion: nil)
                                         }else{
                                          self.selectedData.append(self.dataArray[myIndexPath.row]["user_email"] as! String)
                                              cell.btnCheckMark.setImage(UIImage(named: "newtickbox.png"), for: .normal)
                                          }
                                          
                                      }else{
                                          let name = self.dataArray[myIndexPath.row]["user_f_name"] as! String
                                          let alert = UIAlertController(title: nil, message: " \(name) not registered in messenger", preferredStyle: UIAlertController.Style.alert)
                                              alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                          self.present(alert, animated: true, completion: nil)
                                      }
                        print(self.selectedData)
                       })
            }
            
                   
        }
        
        func checkforConnectionStatus(userEmail:String)-> Bool{
            var status = false
            let applicationUserListQueryByIds = SBDMain.createApplicationUserListQuery()
            applicationUserListQueryByIds?.userIdsFilter = [userEmail]
            applicationUserListQueryByIds?.loadNextPage(completionHandler: { (users, error) in
                guard error == nil else {// Error.
                    return
                }
             print(users![0].userId)
                print(users![0].connectionStatus)
                //SBDUserConnectionStatus //SBDUserConnectionStatusNonAvailable = 0,
                if Int(users![0].connectionStatus.rawValue) == 0{
                   status = false
                }else{
                    status = true
                }
            })
            return status
        }
        
       
    func fillterArray(){
        print(self.connectedUserList)
        var indextoDelete : Array<Int> = []
        for index in 0...self.channel.memberCount-1 {
            //print("\(index) times 5 is \(index * 5)")
            var user: SBDMember!
            user =  self.channel.members!.object(at: Int(index)) as? SBDMember
            print(user.userId)
            let index = self.connectedUserList.index(where: { dictionary in
              guard let value = dictionary["user_email"] as? String
                else { return false }
              return value == user.userId
            })
            if let index = index {
              self.connectedUserList.remove(at: index)
            }
        }
        
        print(self.connectedUserList)
        if self.connectedUserList.count>0 {
            self.dataArray = self.connectedUserList
            self.tblCnnctduserList.delegate = self
            self.tblCnnctduserList.dataSource = self
            self.tblCnnctduserList.reloadData()
            
        }else{
            let alert = UIAlertController(title: nil, message: "No User Found!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        ActivityLoaderView.stopAnimating()
    }
    
    
    
        @IBAction func createChannel(_ sender: Any) {
            if self.selectedData.count>0{
                if self.selectedData.count > 1 {
                    self.strChannelType = "Channel"
                }else{
                    self.strChannelType = "Individual"
                }
               // self.viewCreateChannel.isHidden = false
            }else{
                
                let alert = UIAlertController(title: nil, message: "Select users to create channel", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        @IBAction func doneCreateChannel(_ sender: Any) {
           /* if self.txtfldChannelName.text!.count > 0 {
                let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                let useremail = userIDData["user_email"] as! String
               

                var ops: [String] = []
                ops.append(useremail)

                var params = SBDGroupChannelParams()
                params.isPublic = false
                params.isEphemeral = false
                params.isDistinct = false
                params.addUserIds(self.selectedData)
                params.operatorUserIds = ops        // Or .operators
                params.name = self.txtfldChannelName.text
                params.channelUrl = nil    // In a group channel, you can create a new channel by specifying its unique channel URL in a 'GroupChannelParams' object.
                params.coverImage = nil            // Or .coverUrl
                params.data = useremail
                params.customType = self.strChannelType

                SBDGroupChannel.createChannel(with: params, completionHandler: { (groupChannel, error) in
                    guard error == nil else {
                        let alert = UIAlertController(title: nil, message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)// Error.
                        return
                    }
                        let newMetaData: NSDictionary = ["auto_invite" : String(self.btnCheckForInviteAll!.tag)]

                    groupChannel?.createMetaData(newMetaData as! [String : String], completionHandler: { (metaData, error) in
                            guard error == nil else {   // Error.
                                return
                                }
                        self.hitAPIToSyncChannelToServer(channel: groupChannel!)
                        })
                })
                
            }else{
                let alert = UIAlertController(title: nil, message: "Channel name required", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
 */
        }
        @IBAction func cancelCreateChannelView(_ sender: Any) {
           // self.txtfldChannelName.text = ""
            //self.viewCreateChannel.isHidden = true
        }
        
        func hitAPIToSyncChannelToServer(channel: SBDGroupChannel){
          /*
            //user_id
            //channel_name
            //channel_url
            //channel_auto_invite String(self.btnCheckForInviteAll!.tag)
            //site-data.php?api_key=1234&action=insert_channel
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
             let userid = userIDData["user_id"] as! String
            
            let servicehandler = ServiceHandlers()
            servicehandler.syncChannelToServer(user_id: userid, channel_name: channel.name, channel_url: channel.channelUrl, channel_auto_invite: String(self.btnCheckForInviteAll!.tag)){(responce,isSuccess) in
                                         if isSuccess{
                                            let resData = responce as! String
                                            print(resData)
                                             let alert = UIAlertController(title: nil, message: "Channel created succesfully!", preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                            self.present(alert, animated: true, completion: nil)
                        
                                            self.viewCreateChannel.isHidden = true
                                        }
         */
            
    }
    
    
    @IBAction func addMemberClick(_ sender: Any) {
        
        if self.selectedData.count > 0{
            
            
            self.channel.inviteUserIds(selectedData, completionHandler: { (error) in
                guard error == nil else {   // Error.
                    return
                }
                let alert = UIAlertController(title: nil, message: "User Added Successfully!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            })
            
        }else{
            
            let alert = UIAlertController(title: nil, message: "No User Selected!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func backButtonClick(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        self.view.removeFromSuperview()
    }
    
}
    

    //memberselectioncell

