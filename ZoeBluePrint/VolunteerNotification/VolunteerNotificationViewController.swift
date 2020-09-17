//
//  VolunteerNotificationViewController.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 17/01/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
class VolunteerNotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var notification:Array<Any>?
    @IBOutlet weak var notificationTable: UITableView!
    
    
override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    self.notificationTable.delegate = self
    self.notificationTable.dataSource = self
    
    let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
           let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
           let user_id = userIDData["user_id"] as! String
           //print(user_id)
    
           let serviceHandler = ServiceHandlers()
    serviceHandler.VolunteerNotification(user_id: user_id) { (responce, isSucess) in
        if isSucess{
           
            self.notification = responce as! Array<Any>
            //print(self.notification)
            self.notificationTable.reloadData()
        }
    }
    
    
               
           }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.notification != nil {
            return notification!.count
        }else{
            return 0
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cell = notificationTable.dequeueReusableCell(withIdentifier: "notificationcell") as! NotificationTableViewCell

        if (self.notification != nil) {
        let notdata = self.notification![indexPath.row] as! Dictionary<String,Any>
        //print(notdata)

        var msg = notdata["notification_msg"] as! String
        //print(msg)
        cell.DescriptionLable.text = msg

        var title = notdata["notification_title"] as! String
        //print(title)
        cell.TitleLabel.text = title

         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: (notdata["notifiation_add_date"] as! String))

// To convert the date into an HH:mm format (where a stands for AM/PM)
        dateFormatter.dateFormat = "yyyy-MM-dd , HH:mm a"
        let dateString = dateFormatter.string(from: date!)
        //print(dateString)
        cell.DateTimeLabel.text = dateString

        }else{
            
            let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: .alert)
                          alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                          self.present(alert, animated: true)
        }
       return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 95
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
}

