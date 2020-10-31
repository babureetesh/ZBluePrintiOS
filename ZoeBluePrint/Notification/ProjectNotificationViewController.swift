//
//  ProjectNotificationViewController.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 06/12/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class ProjectNotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var noti_data:Array<Any>?
    
  
    @IBOutlet weak var tableNotification: UITableView!
    
    @IBOutlet weak var imgProfilePic: UIImageView!
   @IBOutlet weak var imgCoverPic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCoverImageForRank()
        self.profile_pic()
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let user_id = userIDData["user_id"] as! String
        let serviceHandler = ServiceHandlers()
        serviceHandler.getNotification(userData: user_id){(responce,isSucess) in
            if isSucess{
                self.noti_data = (responce as! Array<Any>)
                self.tableNotification.delegate = self
                self.tableNotification.dataSource = self
                self.tableNotification.reloadData()
            }else{
                let alert = UIAlertController(title: nil, message: "No data found!", preferredStyle: UIAlertController.Style.alert)
                                                               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                                           self.present(alert, animated: true, completion: nil)
            }

        }
        // Do any additional setup after loading the view.
    }
    
    func getCoverImageForRank(){
        
        if let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as? Data, let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Dictionary<String, Any>, let usertype = userIDData["user_type"] as? String, (usertype == "CSO"){
            self.imgCoverPic.image = UIImage(named:UserDefaults.standard.string(forKey: "csocoverpic")!)
            
        } else{
            var strImageNameCover = "cover_cloud.jpg"
            
            if let decoded  = UserDefaults.standard.object(forKey: "VolData") as? Data,let volData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as?  Dictionary<String, Any>, let userAvgRank = volData["user_avg_rank"] as? String
            //print(volData)
            {
                
                
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
            self.imgCoverPic.image = UIImage(named:strImageNameCover)
        }
        
        
    }
    func profile_pic()  {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                   let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                   let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                   if let dirPath          = paths.first
                   {
                      let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
                       if let image    = UIImage(contentsOfFile: imageURL.path){
                                               self.imgProfilePic.image = image
                                                 self.imgProfilePic.layer.borderWidth = 1
                                                 self.imgProfilePic.layer.masksToBounds = false
                                                 self.imgProfilePic.layer.borderColor = UIColor.black.cgColor
                                                 self.imgProfilePic.layer.cornerRadius = self.imgProfilePic.frame.height/2
                                                 self.imgProfilePic.clipsToBounds = true
                       }
                      // Do whatever you want with the image
                   }
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if self.noti_data != nil {
               return noti_data!.count
           }else{
               return 0
           }
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableNotification.dequeueReusableCell(withIdentifier: "notification_cell") as! notificationCell
           
            if (self.noti_data != nil) {
            let data = noti_data![indexPath.row] as! Dictionary<String,Any>
               // //print(data)
//
            cell.LbnProject1.text = data["notification_title"] as? String ?? ""
            cell.lbnNotification.text = data["notification_msg"] as? String ?? ""
                
                
                // Your original code ("dd/MM/yyyy HH:mm:ss" - "dd/MM/yyyy HH:mm a")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = dateFormatter.date(from: (data["notifiation_add_date"] as! String))
//
//                // To convert the date into an HH:mm format (where a stands for AM/PM)
                dateFormatter.dateFormat = "yyyy-MM-dd, HH:mm a"
                let dateString = dateFormatter.string(from: date!)
             //  //print(dateString)
                cell.lbnDateAndTime.text = dateString

            }else{
                let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                self.present(alert, animated: true)
            }
           return cell
         }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }
    
    
    @IBAction func NotifBackButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func back_button(_ sender: Any) {
        performSegueToReturnBack()
        //self.view.removeFromSuperview()
    }
    
}
