//
//  OrganizationViewController.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 18/08/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class OrganizationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,delegateOrganizationCell,UISearchBarDelegate {

//     @IBOutlet weak var lblHeadingName: UILabel!
     @IBOutlet weak var profilepic: UIImageView!
     @IBOutlet weak var coverpic: UIImageView!
    @IBOutlet weak var lblMyOrgSel: UILabel!
    @IBOutlet weak var lblSearchOrgSel: UILabel!
    
    @IBOutlet weak var btnMyOrg: UIButton!
    @IBOutlet weak var btnSearchOrg: UIButton!
    @IBOutlet weak var tblOrganizationList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    var arrOrgList:[[String:Any]] = []
    var searchSelected: Bool = false
    var filteredData:Array<Any> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnMyOrg.setTitleColor(.black, for: .normal)
        btnSearchOrg.setTitleColor(.gray, for: .normal)
        lblSearchOrgSel.isHidden = true
        lblMyOrgSel.isHidden = false
         self.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            self.getCoverImageForRank()
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
            if let image    = UIImage(contentsOfFile: imageURL.path){
                                    self.profilepic.image = image
                                      self.profilepic.layer.borderWidth = 1
                                      self.profilepic.layer.masksToBounds = false
                                      self.profilepic.layer.borderColor = UIColor.black.cgColor
                                      self.profilepic.layer.cornerRadius = self.profilepic.frame.height/2
                                      self.profilepic.clipsToBounds = true
            }
           // Do whatever you want with the image
        }
        
        
        searchSelected = false
        
        
//        self.tblOrganizationList.frame = CGRect(x: 0, y: 248, width: 374, height: 419)
        tableViewTopConstraint.constant = 0
         self.view.layoutIfNeeded()
        self.callForMyOrganizationData()
       
              }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getCoverImageForRank(){
        
        var strImageNameCover = "cover_cloud.jpg"
        
        if let decoded  = UserDefaults.standard.object(forKey: "VolData") as? Data, let volData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as?  Dictionary<String, Any>, let userAvgRank = volData["user_avg_rank"] as? String
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
        self.coverpic.image = UIImage(named:strImageNameCover)
        
        
    }
    @IBAction func BellButton(_ sender: Any) {
        
   let sb = UIStoryboard(name: "Main", bundle: nil)
    let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
      present(obj,animated: true)
    
    }
    
    @IBAction func myOrgSelected(_ sender: Any) {
        btnMyOrg.setTitleColor(.black, for: .normal)
        btnSearchOrg.setTitleColor(.gray, for: .normal)
        lblSearchOrgSel.isHidden = true
        lblMyOrgSel.isHidden = false
         searchSelected = false
        self.callForMyOrganizationData()
//        self.tblOrganizationList.frame = CGRect(x: 0, y: 248, width: 374, height: 419)
        tableViewTopConstraint.constant = 0
        self.view.layoutIfNeeded()
        
    }
    
    @IBAction func searchOrgSelected(_ sender: Any) {
        btnMyOrg.setTitleColor(.gray, for: .normal)
        btnSearchOrg.setTitleColor(.black, for: .normal)
        lblSearchOrgSel.isHidden = false
        lblMyOrgSel.isHidden = true
         searchSelected = true
//        self.tblOrganizationList.frame = CGRect(x: 0, y: 292, width: 374, height: 375)
        tableViewTopConstraint.constant = 61
        self.view.layoutIfNeeded()
        self.callForSearchOrganizationData()
        
        
        
    }
    
    func callForMyOrganizationData(){
        self.tblOrganizationList.delegate = nil
        self.tblOrganizationList.dataSource = nil
         let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let user_id = userIDData["user_id"] as! String
        self.arrOrgList.removeAll()
        self.filteredData.removeAll()
        let servicehandler = ServiceHandlers()
                       servicehandler.myOrgList(user_id:user_id){(responce,isSuccess) in
                           if isSuccess{
                            
                            self.arrOrgList = responce as! [[String : Any]]
                            
                            print(self.arrOrgList)
                            if (self.arrOrgList.count > 0){
                                self.filteredData = self.arrOrgList
                                self.tblOrganizationList.delegate = nil
                                self.tblOrganizationList.dataSource = nil
                                self.tblOrganizationList.delegate = self
                                self.tblOrganizationList.dataSource = self
                                self.tblOrganizationList.reloadData()
                            }else{
                                let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                self.present(alert, animated: true)
                                self.tblOrganizationList.delegate = nil
                                self.tblOrganizationList.dataSource = nil
                                self.tblOrganizationList.reloadData()
                            }
                              
                           }else{
                            let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                            self.present(alert, animated: true)
                            self.tblOrganizationList.delegate = nil
                            self.tblOrganizationList.dataSource = nil
                            self.tblOrganizationList.reloadData()
                        }
        }
    }
    func callForSearchOrganizationData(){
        self.tblOrganizationList.delegate = nil
        self.tblOrganizationList.dataSource = nil
         let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let user_id = userIDData["user_id"] as! String
        self.arrOrgList.removeAll()
        self.filteredData.removeAll()
        let servicehandler = ServiceHandlers()
                       servicehandler.searchOrgList(user_id:user_id){(responce,isSuccess) in
                           if isSuccess{
                            self.arrOrgList.removeAll()
                            self.filteredData.removeAll()
                            self.arrOrgList = responce as! [[String : Any]]
                            print(self.arrOrgList)
                            if (self.arrOrgList.count > 0){
                                self.filteredData = self.arrOrgList
                                self.tblOrganizationList.delegate = nil
                                self.tblOrganizationList.dataSource = nil
                                self.tblOrganizationList.delegate = self
                                self.tblOrganizationList.dataSource = self
                                self.tblOrganizationList.reloadData()
                            }else{
                                let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                self.present(alert, animated: true)
                                self.tblOrganizationList.delegate = nil
                                self.tblOrganizationList.dataSource = nil
                                self.tblOrganizationList.reloadData()
                            }
                           }else{
                            
                            let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                            self.present(alert, animated: true)
                            self.tblOrganizationList.delegate = nil
                            self.tblOrganizationList.dataSource = nil
                            self.tblOrganizationList.reloadData()
                        }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           
        return self.filteredData.count
        }
       
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
            return 70
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
                let cell = tblOrganizationList.dequeueReusableCell(withIdentifier: "cellorg", for: indexPath) as! OrganizationTableViewCell
            
            let data:NSDictionary = self.filteredData[indexPath.row] as! NSDictionary
                print(data)
               cell.delegate = self
                cell.btnLink.tag = indexPath.row
            if searchSelected {
            cell.orgName.text = data["cso_name"] as? String
            cell.orgEmail.text = data["csoa_email"] as? String
               
                if ((data["link_status"] as? String) == "20") {
                    cell.btnLink.setTitle("LINK", for: .normal)
                }else{
                    cell.btnLink.setTitle("UNLINK", for: .normal)
                }
        
            }else{
                cell.orgName.text = data["cso_name"] as? String
                cell.orgEmail.text = data["user_email"] as? String
                cell.btnLink.setTitle("UNLINK", for: .normal)
                }
            
            return cell
                
    
        }
    
    
    func linkUnlink(selectedRow:Int){
        
        if !searchSelected{
            
            let alert = UIAlertController(title: NSLocalizedString("UNLINK USER", comment: ""), message: NSLocalizedString("Do you want to unlink?", comment: ""), preferredStyle: UIAlertController.Style.alert)
                           alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: { _ in
                           //Cancel Action
                       }))
                       alert.addAction(UIAlertAction(title: "YES",
                                                     style: UIAlertAction.Style.default,
                                                     handler: {(_: UIAlertAction!) in
                                                      self.unLinkUser(selectedIndex: selectedRow)
                       }))
                       self.present(alert, animated: true, completion: nil)
            
            
            
            
        }else{
            let data:NSDictionary = self.filteredData[selectedRow] as! NSDictionary
            
            if ((data["link_status"] as? String) == "20") {
                let alert = UIAlertController(title: NSLocalizedString("LINK USER", comment: ""), message: NSLocalizedString("Do you want to Link?", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                          alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: { _ in
                                          //Cancel Action
                                      }))
                                      alert.addAction(UIAlertAction(title: "YES",
                                                                    style: UIAlertAction.Style.default,
                                                                    handler: {(_: UIAlertAction!) in
                                                                     self.linkUser(selectedIndex: selectedRow)
                                      }))
                                      self.present(alert, animated: true, completion: nil)
                
            }else{
                
                 let alert = UIAlertController(title: NSLocalizedString("UNLINK USER", comment: ""), message: NSLocalizedString("Do you want to unlink?", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                          alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: { _ in
                                          //Cancel Action
                                      }))
                                      alert.addAction(UIAlertAction(title: "YES",
                                                                    style: UIAlertAction.Style.default,
                                                                    handler: {(_: UIAlertAction!) in
                                                                     self.unLinkUser(selectedIndex: selectedRow)
                                      }))
                                      self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    func unLinkUser(selectedIndex: Int){
        
        print(selectedIndex)
        let data:NSDictionary = self.filteredData[selectedIndex] as! NSDictionary
               print(data)
               
               let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                      let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                      let user_id = userIDData["user_id"] as! String
               let cso_id = data["cso_id"] as! String
               let user_device = UIDevice.current.identifierForVendor!.uuidString
        let user_name = data["cso_name"] as! String
                      let servicehandler = ServiceHandlers()
                                     servicehandler.unLinkUser(user_id:user_id,cso_id: cso_id,user_device:user_device ){(responce,isSuccess) in
                                         if isSuccess{
                                          let alert = UIAlertController(title: nil, message: "\(user_name) unlinked successfully", preferredStyle: .alert)
                                                                                   alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                                                                   self.present(alert, animated: true)
                                            self.reloadTableDataAfterLinkUnlink()
                                      }else{
                                          let alert = UIAlertController(title: nil, message: NSLocalizedString("Error Occured!", comment: ""), preferredStyle: .alert)
                                          alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                          self.present(alert, animated: true)
                                      }
                      }
    }
    
    func linkUser(selectedIndex: Int){
        
        print(selectedIndex)
        let data:NSDictionary = self.filteredData[selectedIndex] as! NSDictionary
               print(data)
               //cso_id
               
               let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                      let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                      let user_id = userIDData["user_id"] as! String
               let cso_id = data["cso_id"] as! String
               let user_device = UIDevice.current.identifierForVendor!.uuidString
         let user_name = data["cso_name"] as! String
                      let servicehandler = ServiceHandlers()
                                     servicehandler.linkUser(user_id:user_id,cso_id: cso_id,user_device:user_device ){(responce,isSuccess) in
                                         if isSuccess{
                                            let alert = UIAlertController(title: nil, message: "\(user_name) linked successfully", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                            self.present(alert, animated: true)
                                            self.reloadTableDataAfterLinkUnlink()
                                            
                                      }else{
                                          let alert = UIAlertController(title: nil, message: NSLocalizedString("Error Occured!", comment: ""), preferredStyle: .alert)
                                          alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                          self.present(alert, animated: true)
                                      }
                      }
    }
    
    func reloadTableDataAfterLinkUnlink(){
        
        if searchSelected {
            self.callForSearchOrganizationData()
        }else{
            
           self.callForMyOrganizationData()
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

               // filterdata  = searchText.isEmpty ? data : data.filter {(item : String) -> Bool in
             
        filteredData = searchText.isEmpty ? self.arrOrgList : arrOrgList.filter { (($0 as AnyObject)["cso_name"] as! String).localizedCaseInsensitiveContains(searchText) }
              tblOrganizationList.reloadData()
       }
    
    
}
