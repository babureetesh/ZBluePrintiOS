//
//  NewChannelOneToOneChatViewController.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 08/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
import SendBirdSDK

protocol delegateNewChannelremoved{
    func viewRemoved()
    
}

class NewChannelOneToOneChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,delegateConnectedUserlistCell,UITextFieldDelegate {
var delegate :delegateNewChannelremoved?
    
    @IBOutlet weak var csoProfilePic: UIImageView!
    @IBOutlet weak var volProfilePic: UIImageView!
    @IBOutlet weak var csoHeaderView:UIView!
    @IBOutlet weak var volHeaderView:UIView!
    @IBOutlet weak var headerViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var imgCoverPic: UIImageView!
    @IBOutlet weak var imgLoadingArrows: UIImageView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var viewCreateChannel: UIView!
    @IBOutlet weak var btnCheckForInviteAll: UIButton!
    @IBOutlet weak var txtfldChannelName: UITextField!
    @IBOutlet weak var tblConnectedUserList: UITableView!
    @IBOutlet weak var lblUserType: UILabel!
    var connectedUserList = [[String:Any]]()
    var dataArray = [[String:Any]]()
    var selectedData : Array<String> = []
    var strChannelType : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
self.viewCreateChannel.isHidden = true
        self.txtfldChannelName.delegate = self
        // Do any additional setup after loading the view.
        self.showLoader()
        self.callforConnecteduser()
    }
    
    
    func setProfilePic(imageData:Data) {
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let usertype = userIDData["user_type"] as! String
        if (usertype == "CSO"){
            //time to handle Header acording to Cso
            headerViewHeightConstrain.constant = 75 + 44 // 44 is safe area margin
            imgCoverPic.isHidden = true
            volHeaderView.isHidden = true
            if let image = UIImage(data: imageData) {
                self.csoProfilePic.image = image
                self.csoProfilePic.layer.borderWidth = 1
                self.csoProfilePic.layer.masksToBounds = false
                self.csoProfilePic.layer.borderColor = UIColor.black.cgColor
                self.csoProfilePic.layer.cornerRadius = self.csoProfilePic.frame.height/2
                self.csoProfilePic.clipsToBounds = true
            }
            
        } else {
            //time to handle Header acording to VOL
            headerViewHeightConstrain.constant = 150
            self.getCoverImageForRank()
            csoHeaderView.isHidden = true
            if let image = UIImage(data: imageData) {
                self.volProfilePic.image = image
                self.volProfilePic.layer.borderWidth = 1
                self.volProfilePic.layer.masksToBounds = false
                self.volProfilePic.layer.borderColor = UIColor.black.cgColor
                self.volProfilePic.layer.cornerRadius = self.csoProfilePic.frame.height/2
                self.volProfilePic.clipsToBounds = true
            }
            
        }
        
        self.view.layoutIfNeeded()
    }
       
    
    
    
    @IBAction func notificationBellTapped(_ sender: Any) {
                 
                 let sb = UIStoryboard(name: "Main", bundle: nil)
                 let obj = sb.instantiateViewController(withIdentifier: "notify") as! VolunteerNotificationViewController
                        self.present(obj, animated: true)
             }
    
    func showLoader(){
        
        //ActivityLoaderView.startAnimating()
        self.viewLoading.backgroundColor = Backgroud_Color
       
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.25 // or however long you want ...
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.imgLoadingArrows.layer.add(rotation, forKey: "rotationAnimation")
    }
    func removeLoader(){
        
        self.viewLoading.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
               
              
                let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                            let userID = userIDData["user_id"] as! String
                                          //print(userID)
                            
                            let string_url = userIDData["user_profile_pic"] as! String
               
        
              // }
               if let url = URL(string: string_url){
                            do {
                              let imageData = try Data(contentsOf: url as URL)
                                
                                setProfilePic(imageData: imageData)
                                
                            } catch {
                                //print("Unable to load data: \(error)")
                            }
                            }
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
          self.imgCoverPic.image = UIImage(named:strImageNameCover)
          
          
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
                                        self.dataArray = self.connectedUserList
                                        print(self.connectedUserList)
                                        if self.connectedUserList.count > 0 {
                                            self.tblConnectedUserList.delegate = self
                                            self.tblConnectedUserList.dataSource = self
                                            self.tblConnectedUserList.reloadData()
                                           // ActivityLoaderView.stopAnimating()
                                            self.removeLoader()
                                        }else{
                                            let alert = UIAlertController(title: nil, message: "User Not Found", preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                            self.present(alert, animated: true, completion: nil)
                                            //ActivityLoaderView.stopAnimating()
                                            self.removeLoader()
                                        }
                                        
                                     }else{
                                        let alert = UIAlertController(title: nil, message: "Error Occured!", preferredStyle: UIAlertController.Style.alert)
                                                                                       alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                                                   self.present(alert, animated: true, completion: nil)
                                       // ActivityLoaderView.stopAnimating()
                                        self.removeLoader()
                                        
                                    }
                                    
                                        }
        }
        
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblConnectedUserList.dequeueReusableCell(withIdentifier: "cell_ConnectedUserlist") as! ConnectedUserListTableViewCell
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
        
        
        
        
        SBDGroupChannel.createChannel(withName: "\(self.dataArray[indexPath.row]["user_f_name"] ?? " ") \( self.dataArray[indexPath.row]["user_l_name"] ?? "")", isDistinct: true, userIds: [ self.dataArray[indexPath.row]["user_email"] as! String], coverUrl: nil, data: nil, customType: nil, completionHandler: { (groupChannel, error) in
            guard error == nil else {   // Error.
                return
            }
            let vc = GroupChannelChatViewController.init(nibName: "GroupChannelChatViewController", bundle: nil)
                   vc.channel = groupChannel
                   vc.hidesBottomBarWhenPushed = true
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc,animated: true)
        })
        
        
//        SBDGroupChannel.createChannel(withUserIds:[ self.dataArray[indexPath.row]["user_email"] as! String], isDistinct: true , completionHandler: { (groupChannel, error) in
//            guard error == nil else {   // Error.
//                return
//            }
//            let vc = GroupChannelChatViewController.init(nibName: "GroupChannelChatViewController", bundle: nil)
//                   vc.channel = groupChannel
//                   vc.hidesBottomBarWhenPushed = true
//            self.present(vc,animated: true)
//        })
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    
    }
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    }
    func checkMarkClicked(selectedRow:Int){
       
        let myIndexPath = IndexPath(row: selectedRow, section: 0)
        let cell = self.tblConnectedUserList.cellForRow(at: myIndexPath) as! ConnectedUserListTableViewCell
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
    
    @IBAction func selectUserType(_ sender: Any) {
        let contents = ["Volunteer","Organization","All"]
        showPopoverForView(view: sender, contents: contents)
    }
    
    fileprivate func showPopoverForView(view:Any, contents:[String]) {
           let controller = DropDownItemsTable(contents)
           let senderButton = view as! UIButton
           controller.showPopoverInDestinationVC(destination: self, sourceView: view as! UIView) { (selectedValue) in
               let selectVal = selectedValue as! String
               //print(selectVal)
               switch selectVal{
               case "All":
                //self.lblUserType.text = "All"
                self.dataArray.removeAll()
                self.dataArray = self.connectedUserList
                self.selectedData.removeAll()
                self.tblConnectedUserList.reloadData()
                
                   break
               case "Organization":
                  // self.lblUserType.text = "CSO"
                   self.createArrayFor(str: "CSO")
                   break
               default:
                  // self.lblUserType.text = "VOL"
                self.createArrayFor(str: "VOL")
                 
               }
               senderButton.setTitle(selectVal, for: .normal)
               senderButton.setImage(nil, for: .normal)
           }
       }
    
    func createArrayFor(str:String){
        self.dataArray.removeAll()
        self.selectedData.removeAll()
        for user in self.connectedUserList{
            if user["user_type"]as! String == str{
                self.dataArray.append(user)
            }
        }
        self.tblConnectedUserList.reloadData()
    }
    @IBAction func createChannel(_ sender: Any) {
        if self.selectedData.count>0{
            if self.selectedData.count > 1 {
                self.strChannelType = "Individual"
            }else{
                self.strChannelType = "Channel"
            }
            self.viewCreateChannel.isHidden = false
        }else{
            
            let alert = UIAlertController(title: nil, message: "Select users to create channel", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func inviteAllSelection(_ sender: Any) {
        if self.btnCheckForInviteAll.tag == 0{
            self.btnCheckForInviteAll.setImage(UIImage(named: "newtickbox.png"), for: .normal)
            self.btnCheckForInviteAll.tag = 1
        }else{
            self.btnCheckForInviteAll.setImage(UIImage(named: "black-square-png.png"), for: .normal)
            self.btnCheckForInviteAll.tag = 0
        }
    }
    @IBAction func doneCreateChannel(_ sender: Any) {
        if self.txtfldChannelName.text!.count > 0 {
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
            params.coverImage = nil// Or .coverUrl
            params.data = useremail
            params.customType = self.strChannelType

            SBDGroupChannel.createChannel(with: params, completionHandler: { (groupChannel, error) in
                guard error == nil else {
                    let alert = UIAlertController(title: nil, message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)// Error.
                    return
                }
                //print(groupChannel.data)
                    let newMetaData: NSDictionary = ["auto_invite" : String(self.btnCheckForInviteAll!.tag)]

                groupChannel?.createMetaData(newMetaData as! [String : String], completionHandler: { (metaData, error) in
                        guard error == nil else {   // Error.
                            print(error?.localizedDescription)
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
    }
    @IBAction func cancelCreateChannelView(_ sender: Any) {
        self.txtfldChannelName.text = ""
        self.viewCreateChannel.isHidden = true
    }
    
    func hitAPIToSyncChannelToServer(channel: SBDGroupChannel){
        
        //user_id
        //channel_name
        //channel_url
        //channel_auto_invite String(self.btnCheckForInviteAll!.tag)
        //site-data.php?api_key=1234&action=insert_channel
        var preSendMessage: SBDUserMessage?
               preSendMessage = channel.sendUserMessage("Welcome to Group!") { (userMessage, error) in
                   if error != nil {
                       //return
                   }
                print(userMessage)
                print(preSendMessage)
               }
        
        
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
                                       // self.present(alert, animated: true, completion: nil)
                    
                                        self.viewCreateChannel.isHidden = true
                                        /*let vc = GroupChannelChatViewController.init(nibName: "GroupChannelChatViewController", bundle: nil)
                                               vc.channel = channel
                                               vc.hidesBottomBarWhenPushed = true
                                        self.present(vc,animated: true)*/
                                        
                                        let vc = GroupChannelChatViewController.init(nibName: "GroupChannelChatViewController", bundle: nil)
                                        vc.channel = channel
                                        vc.hidesBottomBarWhenPushed = true
                                        vc.modalPresentationStyle = .fullScreen
                                        self.present(vc,animated: true)
                                        
                                    }
                                        }
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func backbuttonClick(_ sender: Any) {
        delegate?.viewRemoved()
        self.dismiss(animated: true, completion: nil)
    }
    
}
