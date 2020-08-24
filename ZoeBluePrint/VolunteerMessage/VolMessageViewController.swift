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
    
    
    @IBOutlet weak var tblChatList: UITableView!
    private var groupChannelListQuery: SBDGroupChannelListQuery?
    var channelList = [SBDGroupChannel]()
    var username: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLongPressGesture()
    
        
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
       
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
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channelList.count
          }
          
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tblChatList.dequeueReusableCell(withIdentifier: "cell_chatList") as! ChatGroupListTableViewCell
        print("*********\(self.channelList[indexPath.row].data)***********")
        cell.lblChatGroupName.text = self.channelList[indexPath.row].name
                cell.delegate = self
                cell.btnMember.tag = indexPath.row
        cell.btnPlus.tag = indexPath.row
        cell.btnMember .setTitle("\(String(self.channelList[indexPath.row].memberCount)) Member", for: .normal)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        if self.channelList[indexPath.row].data == self.username{
            cell.btnPlus.isHidden = false
        }else{
            cell.btnPlus.isHidden = true
        }
                return cell
          }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    
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
                    alert.addAction(UIAlertAction(title: "Delete Channel", style: UIAlertAction.Style.destructive, handler: { action in
                        
                        self.delChannel(channel: self.channelList[indexPath.row])

                    }))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    //cell.btnPlus.isHidden = true
                    //Leave channel
                    
                    let alert = UIAlertController(title: self.channelList[indexPath.row].name , message: nil, preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "Leave Channel", style: UIAlertAction.Style.destructive, handler: { action in
                        
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
    
    
}

