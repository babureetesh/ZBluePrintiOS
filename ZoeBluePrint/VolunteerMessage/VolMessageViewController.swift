//
//  VolMessageViewController.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 07/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
import SendBirdSDK


class VolMessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,delegateChatGroupList,delegateNewChannelremoved,UIGestureRecognizerDelegate{
    
    @IBOutlet weak var csoProfilePic: UIImageView!
    @IBOutlet weak var volProfilePic: UIImageView!
    @IBOutlet weak var csoHeaderView:UIView!
    @IBOutlet weak var volHeaderView:UIView!
    
    @IBOutlet weak var headerViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var imgCoverPic: UIImageView!
    @IBOutlet weak var tblChatList: UITableView!
    private var groupChannelListQuery: SBDGroupChannelListQuery?
    var channelList = [SBDGroupChannel]()
    var username: String!
    var string_url: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLongPressGesture()
    
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
               // self.csoProfilePic.layer.borderColor = UIColor.black.cgColor
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
                //self.volProfilePic.layer.borderColor = UIColor.black.cgColor
                self.volProfilePic.layer.cornerRadius = self.csoProfilePic.frame.height/2
                self.volProfilePic.clipsToBounds = true
            }
            
        }
        
        self.view.layoutIfNeeded()
    }
    


    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            string_url = userIDData["user_profile_pic"] as! String
            let usertype = userIDData["user_type"] as! String
            
         let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
                let decodedUserdata  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                let userIDdata = NSKeyedUnarchiver.unarchiveObject(with: decodedUserdata) as!  Dictionary<String, Any>
                let userID = userIDdata["user_id"] as! String
                              //print(userID)
                
                let string_url = userIDdata["user_profile_pic"] as! String
                if let url = URL(string: string_url){
                do {
                  let imageData = try Data(contentsOf: url as URL)
                    setProfilePic(imageData: imageData)
  
                } catch {
                    //print("Unable to load data: \(error)")
                }
                }
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(true)
        
        // Do any additional setup after loading the view.
                   let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                             let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                   self.username = userIDData["user_email"] as? String
                   
                   ActivityLoaderView.startAnimating()
                   SBDMain.connect(withUserId: username) { (user, error) in
                             guard error == nil else {   // Error.
                                 return
                               ActivityLoaderView.stopAnimating()
                             }
                       //print(user?.userId as Any)
                             //print(user?.nickname)
                             //print(user?.profileUrl)
                       self.loadChannels()
                   }
    }
    
    func loadChannels() {
        self.groupChannelListQuery = SBDGroupChannel.createMyGroupChannelListQuery()
        self.groupChannelListQuery?.limit = 100
        
        if self.groupChannelListQuery?.hasNext == false {
            return
        }
        
        self.groupChannelListQuery?.loadNextPage(completionHandler: { (channels, error) in
            if error != nil {
                print ("error")
                ActivityLoaderView.stopAnimating()
                return
            }
            print(channels![0].name)
            self.channelList.removeAll()
            for channel in channels! {
                self.channelList.append(channel)
               print(channel.joinedMemberCount)
                let channelMember = channel.members!
                print(channelMember[0])
                
                print(channel.memberCount)
                print(channel.channelUrl)
                print(channel.coverUrl)
                print(channel.name)
                print(channel.lastMessage)
                let arrMembers = channel.members //as! SBDMember)
                let member = (arrMembers![0] as! SBDMember)
                let url = member.profileUrl
                print(url as Any)
                 print("********************")
                
            }
                        if self.channelList.count>0{
                            self.tblChatList.delegate = nil
                            self.tblChatList.dataSource = nil
                            self.tblChatList.delegate = self
                            self.tblChatList.dataSource = self
                            self.tblChatList.reloadData()
                            ActivityLoaderView.stopAnimating()
                        }
         
        })
        
    }
   
    func getCustomChannelName(channel: SBDGroupChannel) -> String{
            var modifiedChannelName = ""
            
            print(channel.customType)
            
            if !(channel.customType == "Channel" ){
            if (channel.memberCount < 2 || self.username == nil) {
                return "No Members";
            } else if (channel.memberCount == 2) { // logic for more than 2 member
                for member in channel.members! {
                    let memberDet = member as! SBDMember
                    if (memberDet.userId == self.username){
                        continue
                    }else if (memberDet.nickname == ""){
                        modifiedChannelName.append(", " + memberDet.userId)
                    }else {
                        modifiedChannelName.append(memberDet.nickname!)
                    }
                    print("MODIFIED CHANNEL NAME ->> " + modifiedChannelName )
                }
                return modifiedChannelName
            }
            }else{
                let components = channel.name.components(separatedBy: "(")
                 var strNewName = ""
                if (components.count > 1){
                 strNewName = components[1]
                 strNewName = strNewName.replacingOccurrences(of: ")", with: "")
                strNewName = strNewName.trimmingCharacters(in: .whitespaces)
                 strNewName = strNewName.capitalized
                strNewName = strNewName.replacingOccurrences(of: " ", with: "_")
                    strNewName = "# " + strNewName
                }else{
                    strNewName = channel.name
                    strNewName = strNewName.trimmingCharacters(in: .whitespaces)
                     strNewName = strNewName.capitalized
                    strNewName = strNewName.replacingOccurrences(of: " ", with: "_")
                    strNewName = "# " + strNewName
                }
                return strNewName
               
            }
            return channel.name
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channelList.count
          }
          
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tblChatList.dequeueReusableCell(withIdentifier: "cell_chatList") as! ChatGroupListTableViewCell
        print("*********\(self.channelList[indexPath.row].name)***********")
        cell.lblChatGroupName.text = self.getCustomChannelName(channel: self.channelList[indexPath.row])
        //cell.lblChatGroupName.text = self.channelList[indexPath.row].name
                cell.delegate = self
                cell.btnMember.tag = indexPath.row
        cell.btnPlus.tag = indexPath.row
        cell.btnMember.setTitle("\(String(self.channelList[indexPath.row].memberCount)) Members", for: .normal)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        if self.channelList[indexPath.row].data == self.username &&  self.channelList[indexPath.row].customType == "Channel" && self.channelList[indexPath.row].memberCount > 2 {
            cell.btnPlus.isHidden = false
        }else{
            
            cell.btnPlus.isHidden = true
        }
        if self.channelList[indexPath.row].coverUrl!.hasPrefix("https://static.sendbird.com") { // true
            cell.imgGroupChat.downloadImageFrom(link: string_url, contentMode: UIView.ContentMode.scaleAspectFill)
            cell.imgGroupChat.layer.cornerRadius = cell.imgGroupChat.frame.size.width / 2
            cell.imgGroupChat.clipsToBounds = true
            
        }else{
            cell.imgGroupChat.downloadImageFrom(link: self.channelList[indexPath.row].coverUrl!, contentMode: UIView.ContentMode.scaleAspectFill)
           
        }
        
        
        if self.channelList[indexPath.row].lastMessage is SBDUserMessage {
            cell.lblChatLastMsg.isHidden =  false
            cell.lblChatLastMsgDate.isHidden = false
            let lastMessage = self.channelList[indexPath.row].lastMessage as! SBDUserMessage
            cell.lblChatLastMsg.text = lastMessage.message
            let lastMessageDateFormatter = DateFormatter()
                   var lastMessageDate: Date?
                   var lastUpdatedTimestamp: Int64 = 0
                   if self.channelList[indexPath.row].lastMessage != nil {
                       lastUpdatedTimestamp = (self.channelList[indexPath.row].lastMessage?.createdAt)!
                   }
                   
                   if String(lastUpdatedTimestamp).count == 10 {
                       lastMessageDate = Date(timeIntervalSince1970: Double(lastUpdatedTimestamp))
                   }
                   else {
                       lastMessageDate = Date(timeIntervalSince1970: Double(lastUpdatedTimestamp) / 1000.0)
                   }
                   
                   let currDate = Date()
                   
                   let lastMessageDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: lastMessageDate!)
                   let currDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: currDate)
                   
                   if lastMessageDateComponents.year != currDateComponents.year || lastMessageDateComponents.month != currDateComponents.month || lastMessageDateComponents.day != currDateComponents.day {
                       lastMessageDateFormatter.dateStyle = .medium
                       lastMessageDateFormatter.timeStyle = .none
                       print(lastMessageDateFormatter.string(from: lastMessageDate!))
                       let fullDate: String = lastMessageDateFormatter.string(from: lastMessageDate!)
                       let fullDateArr = fullDate.components(separatedBy: ",")

                       let firstDate: String = fullDateArr[0]
                       cell.lblChatLastMsgDate.text = firstDate
                   }
                   else {
                       lastMessageDateFormatter.dateStyle = .none
                       lastMessageDateFormatter.timeStyle = .short
                       print(lastMessageDateFormatter.string(from: lastMessageDate!))
                       cell.lblChatLastMsgDate.text = lastMessageDateFormatter.string(from: lastMessageDate!)
                   }
        }else{
            cell.lblChatLastMsg.isHidden =  true
            cell.lblChatLastMsgDate.isHidden = true
        }
       
        if (self.channelList[indexPath.row].unreadMessageCount > 0 ){
            cell.lblUnReadMsgCount.isHidden = false
        cell.lblUnReadMsgCount.layer.cornerRadius = cell.lblUnReadMsgCount.frame.width/2
        cell.lblUnReadMsgCount.text = String(self.channelList[indexPath.row].unreadMessageCount)
        }else{
            cell.lblUnReadMsgCount.isHidden = true
        }
       // cell.lblChatLastMsgDate.text = String(self.channelList[indexPath.row].lastMessage!.createdAt)
                return cell
          }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
      /*
        let sb = UIStoryboard(name: "Main", bundle: nil)
                             let obj = sb.instantiateViewController(withIdentifier: "chatwindow") as! ChatViewController
        obj.channel = self.channelList[indexPath.row]
                               present(obj,animated: true)*/
        
        let vc = GroupChannelChatViewController.init(nibName: "GroupChannelChatViewController", bundle: nil)
        vc.channel = self.channelList[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
    func memberClicked(selectedRow:Int){
        
     print(selectedRow)
        
        let controller:MemberListViewController = self.storyboard!.instantiateViewController(withIdentifier: "memberlist") as! MemberListViewController
        controller.channel =  self.channelList[selectedRow]
        controller.view.frame = self.view.bounds;
        controller.willMove(toParent: self)
        self.view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)
        
    }
    func plusClicked(selectedRow: Int) {
        print(selectedRow)
        
        print(selectedRow)
        
        let controller:AddMemberToChannelViewController = self.storyboard!.instantiateViewController(withIdentifier: "newmembertoaddlist") as! AddMemberToChannelViewController
        controller.channel =  self.channelList[selectedRow]
        controller.view.frame = self.view.bounds;
        controller.willMove(toParent: self)
        self.view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)
        
        
    }

    
    @IBAction func showNewChannelOnetoOneChatView(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
                      let obj = sb.instantiateViewController(withIdentifier: "newchannel") as! NewChannelOneToOneChatViewController
        obj.delegate = self
                        present(obj,animated: true)
    }
    
    func viewRemoved(){
       
        self.refreshChannelList()
    }
    
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self
        self.tblChatList.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: self.self.tblChatList)
            if let indexPath = self.tblChatList.indexPathForRow(at: touchPoint) {
                print("\(indexPath.row) uigesture")
                
                if self.channelList[indexPath.row].data == self.username{
                   // Delete Channel
                    let alert = UIAlertController(title: self.channelList[indexPath.row].name , message: nil, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "Delete Channel", style: UIAlertAction.Style.default, handler: { action in
                        self.delChannel(channel: self.channelList[indexPath.row])
                    }))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }else{
                    //cell.btnPlus.isHidden = true
                    //Leave channel
                    let alert = UIAlertController(title: self.channelList[indexPath.row].name , message: nil, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "Leave Channel", style: UIAlertAction.Style.default, handler: { action in
                        
                        self.leaveChannel(channel: self.channelList[indexPath.row])

                    }))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func delChannel(channel : SBDGroupChannel){
        
        print("Delete channle called")
        channel.delete(completionHandler:{ (error) in
            guard error == nil else {   // Error.
                print(error?.localizedDescription)
                return
            }
            self.refreshChannelList()
        })
        
    }
    
    func leaveChannel(channel : SBDGroupChannel){
        print("Leave Channel called")
        channel.leave(completionHandler: { (error) in
                   guard error == nil else {   // Error.
                    print(error?.localizedDescription)
                       return
                   }
                   self.refreshChannelList()
               })
        
    }
    
    func refreshChannelList(){
        
        SBDMain.disconnect(completionHandler: nil)
                 let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                                          let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                                self.username = userIDData["user_email"] as? String
                                
                                ActivityLoaderView.startAnimating()
                                SBDMain.connect(withUserId: username) { (user, error) in
                                          guard error == nil else {   // Error.
                                              return
                                            ActivityLoaderView.stopAnimating()
                                          }
                                    //print(user?.userId as Any)
                                          //print(user?.nickname)
                                          //print(user?.profileUrl)
                                    self.loadChannels()
                                }
        
    }
    @IBAction func notificationBellTapped(_ sender: Any) {
              
              let sb = UIStoryboard(name: "Main", bundle: nil)
              let obj = sb.instantiateViewController(withIdentifier: "notify") as! VolunteerNotificationViewController
                     self.present(obj, animated: true)
          }
    
}
extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        let replacedStr = link.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask( with: NSURL(string:replacedStr)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
