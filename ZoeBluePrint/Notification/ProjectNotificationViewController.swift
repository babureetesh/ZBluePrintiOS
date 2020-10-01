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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
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
            }

        }
        // Do any additional setup after loading the view.
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
        dismiss(animated: true, completion: nil)
        //self.view.removeFromSuperview()
    }
    
}
