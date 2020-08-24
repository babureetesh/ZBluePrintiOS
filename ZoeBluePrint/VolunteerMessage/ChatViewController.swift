//
//  ChatViewController.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 20/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
import SendBirdSDK

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var channel: SBDGroupChannel!
    var arrChatMessages: [SBDBaseMessage]!
    @IBOutlet weak var tblChatMessages: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        print(self.channel.channelUrl)
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                  let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        
        
        SBDGroupChannel.getWithUrl(self.channel.channelUrl, completionHandler: { (groupChannel, error) in
            guard error == nil else {   // Error.
                print(error?.localizedDescription)
                return
            }
print(groupChannel)
            self.loadPreviousMessages()
            // TODO: Implement what is needed with the contents of the response in the groupChannel parameter.
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadPreviousMessages(){
        
        // There should be only one single instance per channel.
        let previousMessageQuery = self.channel.createPreviousMessageListQuery()
        previousMessageQuery?.includeMetaArray = true   // Retrieve a list of messages along with their metaarrays.
       // previousMessageQuery?.includeReactions = true   // Retrieve a list of messages along with their reactions.

        // Retrieving previous messages.
        previousMessageQuery?.loadPreviousMessages(withLimit: 100, reverse: false, completionHandler: { (messages, error) in
            guard error == nil else {   // Error.
                return
            }
            print(messages)
            self.arrChatMessages = messages
            if self.arrChatMessages.count>0{
                self.tblChatMessages.delegate = self
                       self.tblChatMessages.dataSource = self
                self.tblChatMessages.reloadData()
            }
            var message: SBDBaseMessage!
            message = messages![0]
            print(message)
            print(message.metaArrays)
            print(message.data)
            print(message.mentionedUsers)
        
            var cuser: SBDUser!
            cuser = SBDMain.getCurrentUser()
            print(cuser)
            print(cuser.nickname)
            print(cuser.userId)
        })
        
    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell: UITableViewCell = UITableViewCell()
            
             let currMessage = self.arrChatMessages[indexPath.row]
        if currMessage is SBDUserMessage {
            guard let userMessage = currMessage as? SBDUserMessage else { return  cell}
            guard let sender = userMessage.sender else { return cell }
            if sender.userId == SBDMain.getCurrentUser()!.userId {
                 let cell = tblChatMessages.dequeueReusableCell(withIdentifier: "cellSelfMessage") as! SelfMessageTableViewCell
                
    
                cell.lblTime.text = "\(userMessage.createdAt)"
                
                
                cell.lblMessage.text = userMessage.message
                
                return cell
            }
                
            else {
                //
                 let cell = tblChatMessages.dequeueReusableCell(withIdentifier: "cellOtherMessage") as! OthersMessageTableViewCell
                cell.lblTime.text = "\(userMessage.createdAt)"
                cell.lblUserName.text = sender.nickname
                cell.lblmessage.text = userMessage.message
               
                return cell
                
            }
            
            
        } else if currMessage is SBDFileMessage {
            
            guard let fileMessage = currMessage as? SBDFileMessage else { return cell }
            guard let sender = fileMessage.sender else { return cell }
            guard let fileMessageRequestId = fileMessage.requestId else { return cell }
            guard let currentUser = SBDMain.getCurrentUser() else { return cell }
            if sender.userId == currentUser.userId {
                if fileMessage.type.hasPrefix("image/gif") {
                    
                }else if fileMessage.type.hasPrefix("video"){
                    
                }else if fileMessage.type.hasPrefix("audio") {
                    
                }
            }else{
                if fileMessage.type.hasPrefix("image/gif") {
                    
                }else if fileMessage.type.hasPrefix("video"){
                    
                }else if fileMessage.type.hasPrefix("audio") {
                    
                }
            }
            
        }
        return cell
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrChatMessages.count
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    
    }
   
}

