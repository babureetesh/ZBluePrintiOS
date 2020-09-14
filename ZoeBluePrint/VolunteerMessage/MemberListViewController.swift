//
//  MemberListViewController.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 14/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
import SendBirdSDK
class MemberListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,delegateWritePermissionSelection {

    @IBOutlet weak var tblMemberList: UITableView!
    @IBOutlet weak var viewheight:NSLayoutConstraint!
    var mutedUsers: [SBDMember]!
    var userEmail = ""
    var channel: SBDGroupChannel!
    
    
    
    
    override func viewDidLayoutSubviews() {
        
        let dataCount = 48 + channel.members!.count * 100
        viewheight.constant = CGFloat(dataCount)
        
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(channel.members as Any)
        
        self.getListOfMutedUser()
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                       let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        self.userEmail = userIDData["user_email"] as! String
    }
    
    @IBAction func removeView(_ sender: Any) {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent() 
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channel.members!.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = self.tblMemberList.dequeueReusableCell(withIdentifier: "cell_memberList") as! MemberListTableViewCell
            //user_f_name
            var user: SBDMember!
            user =  self.channel.members!.object(at: indexPath.row) as? SBDMember
//            print(user.metaData)
//            print(user.profileUrl)
//            print(user.userId)
//            print(user.originalProfileUrl)
//            print(user.connectionStatus.rawValue)
            cell.lblUserName.text = user.nickname
            cell.lblEmail.text = user.userId
            cell.delegate = self
            cell.btnWritePermission.tag = indexPath.row
            cell.imgViewUser.image = UIImage(named: "user_email.png")
            cell.imgViewUser.downloadImageFrom(link: user.profileUrl! , contentMode: UIView.ContentMode.scaleAspectFill)
            cell.imgViewUser.layer.cornerRadius = cell.imgViewUser.frame.size.width / 2
            cell.imgViewUser.clipsToBounds = true
            
            print(user.userId)
            print(self.channel.data as String!)
            if self.channel.data == self.userEmail {
                
            if  user.userId == self.channel.data {
                cell.btnWritePermission.isHidden = true
                cell.lblWritePermission.isHidden = true
            }else if self.mutedUsers .contains(user) {
                 cell.btnWritePermission.setImage(UIImage(named: "black-square-png.png"), for: .normal)
            }else{
                cell.btnWritePermission.setImage(UIImage(named: "newtickbox.png"), for: .normal)
            }
            }else{
                cell.btnWritePermission.isHidden = true
                cell.lblWritePermission.isHidden = true
            }
            return cell
        }


        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100.0
        
        }
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    //    }
    
    func checkMarkClicked(selectedRow:Int){
        let myIndexPath = IndexPath(row: selectedRow, section: 0)
               let cell = self.tblMemberList.cellForRow(at: myIndexPath) as! MemberListTableViewCell
        print(selectedRow)
        var user: SBDMember!
        user =  self.channel.members!.object(at: selectedRow) as? SBDMember
        
        if channel?.myRole == SBDRole.operator {
            
            if self.mutedUsers .contains(user){
            channel?.unmuteUser(user, completionHandler: { (error) in
                guard error == nil else {   // Error.
                    return
                }
                self.getListOfMutedUser()
                // write permission is disabled
                let alert = UIAlertController(title: nil, message: "\( user.nickname ?? "")'s write permission is disabled", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                // TODO: Custom implementation for what should be done after muting.
            })
            }else{
            channel?.muteUser(user, completionHandler: { (error) in
                guard error == nil else {   // Error.
                    return
                }
                self.getListOfMutedUser()
                //write permission is enable
                let alert = UIAlertController(title: nil, message: "\( user.nickname ?? "")'s write permission is enabled", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                // TODO: Custom implementation for what should be done after unbanning.
            })
                
            }
        }
        
        
    }
    func getListOfMutedUser(){
        
        // Retrieving muted users
        let memberUserListQuery = self.channel?.createMemberListQuery()
        memberUserListQuery?.mutedMemberFilter = SBDGroupChannelMutedMemberFilter.muted
        memberUserListQuery?.loadNextPage(completionHandler: { (members, error) in
            guard error == nil else {   // Error.
                return
            }
            print(members!)
            self.mutedUsers = members
            self.tblMemberList.delegate = nil
            self.tblMemberList.dataSource = nil
            self.tblMemberList.delegate = self
            self.tblMemberList.dataSource = self
            self.tblMemberList.reloadData()
        })
    }

}

