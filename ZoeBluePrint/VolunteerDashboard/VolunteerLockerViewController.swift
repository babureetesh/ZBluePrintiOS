
//
//  VolunteerLockerViewController.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 21/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import Alamofire
import QuartzCore

class VolunteerLockerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,dataPass1, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate,UITextFieldDelegate,XMLParserDelegate  {
    
    struct Connectivity {
        static let sharedInstance = NetworkReachabilityManager()!
        static var isConnectedToInternet:Bool {
            return self.sharedInstance.isReachable
        }
    }
    
    
    
    @IBOutlet weak var imgViewCoverPic: UIImageView!
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var imageDocument: UIImageView!
    
    
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var whiteStarView: FloatRatingView!
    
    @IBOutlet weak var blankLabel: UILabel!
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var View3A: UIView!
    @IBOutlet weak var DocumentTextField: UITextField!
    @IBOutlet weak var lblPleaseEnterTheDocuments: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
//    @IBOutlet weak var lblHeadingName: UILabel!
    @IBOutlet weak var AddButtonTapped: UIButton!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankImage: UIImageView!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var Completedhours: UILabel!
    @IBOutlet weak var DocumentLabel: UILabel!
    @IBOutlet weak var RatingLabel: UILabel!
    @IBOutlet weak var RatingButton: UIButton!
    @IBOutlet weak var DocumentButton: UIButton!
    @IBOutlet weak var Table1: UITableView!
    var DocumentList: [[String:Any]]?
    
    
    var fileUrl:URL!
    var flag1:Bool = false
    var flag2:Bool = false
    var title1: String?
    var img:Data?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
         self.Table1.tableFooterView = UIView(frame: .zero)
        View3.isHidden = true
        View3A.isHidden = true
        
        self.AddButtonTapped.isHidden = false
        self.Table1.delegate = self
        self.Table1.dataSource = self
        self.docTypePressed.setTitle(NSLocalizedString("Document Type", comment: ""), for: .normal)
        
        self.DocumentTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.refreshLoadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getCoverImageForRank()
        self.RatingButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        
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
        
        if Connectivity.isConnectedToInternet {
            self.refreshLoadData()
        } else {
            
            let alert = UIAlertController(title: nil, message: NSLocalizedString("No Internet Connection", comment: ""), preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func notificationBellTapped(_ sender: Any) {
        Utility.showNotificationScreen(navController: self.navigationController)
//          let sb = UIStoryboard(name: "Main", bundle: nil)
//          let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
//            present(obj,animated: true)
      }
    
    func getCoverImageForRank(){
        
        var strImageNameCover = "cover_cloud.jpg"
        
        if let decoded  = UserDefaults.standard.object(forKey: "VolData") as? Data, let volData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Dictionary<String, Any>, let userAvgRank = volData["user_avg_rank"] as? String
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
        self.imgViewCoverPic.image = UIImage(named:strImageNameCover)
        
        
    }

    
    func tagNumber(tag: Int) {
        let alert = UIAlertController(title: NSLocalizedString("DOWNLOAD DOCUMENT?", comment: ""), message: NSLocalizedString("Are you sure want to download document?", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: {(_ action: UIAlertAction) -> Void in
            ActivityLoaderView.startAnimating()
            let document_file_url = [self.DocumentList![tag]][0]["document_file_name"] as? String
            
            let fullName    = document_file_url
            let fullNameArr = fullName!.components(separatedBy: "/")
            let fileName = fullNameArr.last
            
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                documentsURL.appendPathComponent(fileName!)
                return (documentsURL, [.removePreviousFile])
            }
            
            Alamofire.download(document_file_url!, to: destination).responseData { response in
                if let destinationUrl = response.destinationURL {
                    self.fileUrl = destinationUrl as URL
                    //print("destinationUrl \(destinationUrl.absoluteURL)")
                    ActivityLoaderView.stopAnimating()
                    self.saveDataToPhone(fileName: fileName!)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func saveDataToPhone(fileName:String)
    {
        
        do {
            let fileData = try Data(contentsOf: self.fileUrl as URL)
            let activityController = UIActivityViewController(activityItems: [fileData], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        } catch {
            //print("Unable to load data: \(error)")
        }
        
    }
    
    func tagdown(tag: Int) {
        
        let alert = UIAlertController(title: NSLocalizedString("DELETE DOCUMENT ?", comment: ""), message: NSLocalizedString("Do you want to delete the document?", comment: ""), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ action in
            
            
            let document_id = [self.DocumentList![tag]][0]["document_id"]
            
            // User_id
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            let user_id = userIDData["user_id"] as! String
            
            let user_type = "VOL"
            let user_device = UIDevice.current.identifierForVendor!.uuidString
            
            let data1:[String:Any] = ["document_id": document_id as! String,"user_id": user_id,"user_type": user_type,"user_device": user_device]
            //print(data1)
            let serviceHanlder = ServiceHandlers()
            serviceHanlder.deletelocker(data_details:data1){ (data, isSuccess) in
                if isSuccess {
                    if let EventTypeData = data as? String {
                        self.lockerlistfunction()
                        
                    }
                }
                
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let c = DocumentList?.count
        {
            return c
            
        }else{
            
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Locker", for: indexPath) as! VolunteerLockerTableViewCell
        
        
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
       
//        if defaults == "Dark Mode" {
//
//            self.Table1.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
//            cell.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
//            cell.DocumentTitle.textColor = .white
//            cell.DocDescription.textColor = .white
//            cell.DateLabel.textColor = .lightGray
//            cell.DeleteButtonPressed.setBackgroundImage(UIImage(named: "newDeletedIcon.png"), for: UIControl.State.normal)
//            cell.DownloadButtonPressed.setBackgroundImage(UIImage(named: "downloading.png"), for: UIControl.State.normal)
//
//        }else if defaults == "Light Mode"{
//
//            self.Table1.backgroundColor = .white
//            cell.backgroundColor = UIColor.clear
//            cell.DocDescription.textColor = .black
//            cell.DocumentTitle.textColor = .black
//            cell.DateLabel.textColor = .gray
//            cell.DeleteButtonPressed.setBackgroundImage(UIImage(named: "newDeletedIcon.png"), for: UIControl.State.normal)
//            cell.DownloadButtonPressed.setBackgroundImage(UIImage(named: "downloading.png"), for: UIControl.State.normal)
//
//
//        }
        let docUrlString: String = [DocumentList![indexPath.row]][0]["document_file_name"] as! String
        let docUrlArr = docUrlString.components(separatedBy: ".")
        
        let fileType: String = docUrlArr.last!
        //print(fileType)
        if fileType == "png" || fileType == "PNG"{
            cell.ImageLabel.image = UIImage(named: "circle+png.png")
            
        }
        else if fileType == "pdf" || fileType == "PDF"{
            cell.ImageLabel.image = UIImage(named: "circle+pdf.png")
        }
        else if fileType == "jpg" || fileType == "JPG" || fileType == "JPEG" || fileType == "jpeg"{
            cell.ImageLabel.image = UIImage(named: "dark+jpg.png")
        }
        else if fileType == "xls" || fileType == "XLS"{
            cell.ImageLabel.image = UIImage(named: "circle+xls.png")
        }
        else if fileType == "ppt" || fileType == "PPT"{
            cell.ImageLabel.image = UIImage(named: "circle2+ppt.png")
        }
        else if fileType == "txt" || fileType == "TXT"{
            cell.ImageLabel.image = UIImage(named: "darker+txt.png")
        }
        else if fileType == "doc" || fileType == "DOC" || fileType == "Doc"{
            cell.ImageLabel.image = UIImage(named: "dark+docfile.png")
        }
        else if fileType == "TIF" || fileType == "GIF" || fileType == "gif" || fileType == "tif"{
            cell.ImageLabel.image = UIImage(named: "darkcircle+image.png")
            
        }
        else if fileType == "mp3" || fileType == "MP3" {
            cell.ImageLabel.image = UIImage(named: "circle+mp3.png")
            
        }
        else if fileType == "MPG" || fileType == "WEBM" || fileType == "MP2" || fileType == "MPV" || fileType == "MPE" || fileType == "MPEG" || fileType == "MOV" || fileType == "OGG" || fileType == "QT" || fileType == "M4P" || fileType == "FLV" || fileType == "WMV" || fileType == "SWF" || fileType == "AVCHD" || fileType == "M4V"{
            cell.ImageLabel.image = UIImage(named: "dark+video.png")
        }
        else{
            cell.ImageLabel.image = UIImage(named: "circle+undefined.png")
        }
        
        cell.DocumentTitle.text = [DocumentList![indexPath.row]][0]["document_type_name"] as! String
        cell.DocDescription.text = [DocumentList![indexPath.row]][0]["document_name"] as! String
        
        var date = [DocumentList![indexPath.row]][0]["document_add_date"] as! String
        var dte = "Date : \(date)"
        //print(dte)
        cell.DateLabel.text = dte
        
        cell.DownloadButtonPressed.tag = indexPath.row
        cell.DeleteButtonPressed.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89.0
    }
    
    func DarkMode() {
        
        self.topView.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.blankLabel.textColor = .white
     
        self.DocumentButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.DocumentButton.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.View2.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.Completedhours.textColor = .white
        
        self.View3A.backgroundColor = UIColor(red: 66.0/255.0, green: 66.0/255.0, blue: 66.0/255.0, alpha: 1.0)
       
        self.docTypePressed.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageDocument.image = UIImage(named: "whitedrop.png")
        self.DocumentTextField.textColor = .white
        DocumentTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Please Enter the Document Name", comment: "") , attributes : [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.blankLabel.backgroundColor = .white
        self.btnList.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        
        
        docTypePressed.borderColor = .white
        docTypePressed.borderWidth = 1.0

        
    }
    func LightMode() {
        
        self.topView.backgroundColor = .white
        self.RatingButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.RatingButton.backgroundColor = .white
        self.DocumentButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.DocumentButton.backgroundColor = .white
        self.view.backgroundColor = .white
        self.blankLabel.textColor = .black
        self.View2.backgroundColor = .white
        self.Completedhours.textColor = .black
        
        
        self.View3A.backgroundColor = .white
        self.docTypePressed.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.docTypePressed.borderColor = .black
        self.DocumentTextField.textColor = .black
        DocumentTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Please Enter the Document Name", comment: "") , attributes : [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.blankLabel.textColor = .black
        self.btnList.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
        
    }
    
    func refreshLoadData(){
        
        Table1.isHidden = false
        
        View2.isHidden = true
        rankImage.isHidden = true
        //        rankLabel.isHidden = true
        RatingLabel.isHidden = true
        DocumentLabel.isHidden = false
//        self.View3.isHidden = true
//        self.View3A.isHidden = true
        self.lockerlistfunction()
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= 0.0
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func lockerlistfunction() {
        //Get UserId from userDefault
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let params = userIDData["user_id"] as! String
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.lockerList(user_id: params) { (responce, isSuccess) in
            if isSuccess {
                if let EventTypeData = responce as? [[String:Any] ] {
                    self.DocumentList = EventTypeData
                    //print(self.DocumentList!)
                    
                    self.Table1.reloadData()
                    let utility = Utility()
                    utility.fetchDocumentType() { (countryList, isValueFetched) in
                        if let list = countryList {
                            let docdata = list[0]
                            
                            self.title1 = docdata["document_type_id"] as! String
                            let strDocTitle = docdata["document_type_name"] as! String
                           // self.docTypePressed.setTitle(strDocTitle, for: .normal)
                            self.docTypePressed.setTitle("Select Type",for: .normal)
                        }
                    }
                }else{
                    
                    self.DocumentList = nil
                    self.Table1.reloadData()
                    
                }
            }else{
                
                let alert = UIAlertController(title: nil, message: NSLocalizedString("No Data Found", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                self.present(alert,animated: true)
                self.Table1.isHidden = true
                
                
            }
            
        }
    }
    @IBAction func documentType(_ sender: Any) {
        let utility = Utility()
        utility.fetchDocumentType() { (countryList, isValueFetched) in
            if let list = countryList {
                self.showPopoverForView2(view: sender, contents: list)
            }
        }
        self.flag1 = true
    }
    
    @IBAction func DocumentButtonTapped(_ sender: Any) {
        
      //  let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        //if defaults == "Dark Mode"{
        //    self.DocumentButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
          //  self.RatingButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            
        //}else if defaults == "Light Mode"{
            
            self.DocumentButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.RatingButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        //}
        
        self.AddButtonTapped.isHidden = false
        View2.isHidden = true
        rankImage.isHidden = true
        //        rankLabel.isHidden = true
        RatingLabel.isHidden = true
        DocumentLabel.isHidden = false
        Table1.isHidden = false
        
    }
    
    @IBAction func rateButton(_ sender: Any) {
//        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//        if defaults == "Dark Mode"{
//            self.whiteStarView.isHidden = false
//
//            self.RatingButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
//             self.DocumentButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
//
//
//        }else if defaults == "Light Mode"{
          
            
            self.RatingButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.DocumentButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            
       // }
        
        self.AddButtonTapped.isHidden = true
        View2.isHidden = false
        rankImage.isHidden = false
        RatingLabel.isHidden = false
        DocumentLabel.isHidden = true
        View3.isHidden = true
        View3A.isHidden = true
        Table1.isHidden = true
        
        Completedhours.isHidden = false
//
//        let decoded1  = UserDefaults.standard.object(forKey: "VolData")
//        let volData1 = NSKeyedUnarchiver.unarchiveObject(with: decoded1 as! Data) as?  Dictionary<String, Any>
//        print(volData1)
        
      if  let decoded  = UserDefaults.standard.object(forKey: "VolData") as? Data,let volData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as?  Dictionary<String, Any>{
             
        if let userAvgRate = volData["user_avg_rate"] as? String {
                    self.ratingView.rating = Double(userAvgRate) ?? 0.0
            self.ratingView.isHidden = false
        }
        let resdata = volData["res_data"] as! Dictionary<String, Any>
        var hoursDone = resdata["vol_hours"] as! String
        hoursDone = hoursDone + " VOLUNTEER HOURS COMPLETED "
        //print(hoursDone)
       
        whiteStarView.isHidden = true
        self.Completedhours.text = hoursDone
        self.rankImage.image = UIImage(named: findingAverageRank(user_hours: volData["user_avg_rank"] as! String))
      } else {
        var hoursDone = "0"
        hoursDone = hoursDone + " VOLUNTEER HOURS COMPLETED "
        //print(hoursDone)
        self.ratingView.isHidden = false
        whiteStarView.isHidden = true
        self.Completedhours.text = hoursDone
        self.rankImage.image = UIImage(named: findingAverageRank(user_hours: "0"))
        
      }
        
        self.ratingView.isUserInteractionEnabled = false
        self.whiteStarView.isUserInteractionEnabled = false
        
        
    }
    
    
    
    func findingAverageRank(user_hours:String)->String{
        
        
        var percent = (user_hours as NSString).integerValue
        //print(percent)
        
        
        if percent >= 0 && percent <= 20 {
            
            //          var Image1 = UIImage(named:"rank_five.png")
            //            //print(Image1)
            return "risenshine.png"    //rank_five.png
        }else
            if percent >= 21 && percent <= 40 {
                
                return "cacke.png"     //rank_four.png
            }else
                if percent >= 41     && percent <= 60  {
                    
                    return "coll.png"    //rank_three.png
                }else
                    if percent >= 61 && percent <= 80{
                        
                        return "truck.png"   //rank_two.png
                        
                    }else
                        if percent >= 81 && percent <= 100{
                            //var Image5 = UIImage(named:"rank_one.png")
                            //         //print(Image5)
                            
                            return "cloud.png"     //rank_one.png
                        }else
                            if percent >= 100 {
                                
                                return "cloud.png"  //rank_one.png
        }
        return "risenshine.png" //rank_five.png
    }
    
    
    @IBAction func bellButtonPressed(_ sender: Any) {
        Utility.showNotificationScreen(navController: self.navigationController)
//      let sb = UIStoryboard(name: "Main", bundle: nil)
//        let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
//          present(obj,animated: true)
        
    }
    
    @IBAction func LockerAddButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: NSLocalizedString("UPLOAD FILES FROM", comment: ""), message: "", preferredStyle: .alert)
        let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
            /** What we write here???????? **/
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = false
            self.present(image, animated: true)
            {
                                self.View3.isHidden = false
                                self.View3A.isHidden = false
            }
            // call method whatever u need
        })
        let camera = UIAlertAction(title: "Camera", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            /** What we write here???????? **/
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.camera
            image.allowsEditing = false
            self.present(image, animated: true)
            {
                self.View3.isHidden = false
                self.View3A.isHidden = false
            }
            // call method whatever u need
        })
        let drive = UIAlertAction(title: NSLocalizedString("Files", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
            /** What we write here???????? **/
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
            
            documentPicker.delegate = self
            documentPicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            
            self.present(documentPicker, animated: true, completion: nil)
            // call method whatever u need
        })
        let noButton = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
        alert.addAction(gallery)
        //  alert.addAction(camera)
        alert.addAction(drive)
        alert.addAction(noButton)
        present(alert, animated: true)
    }
    
    
    @IBOutlet weak var docTypePressed: UIButton!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            self.img =  (image as? UIImage)!.jpegData(compressionQuality: 0.5)!
            self.View3.isHidden = false
            self.View3A.isHidden = false
        }else{
            //print("error")
        }
        self.dismiss(animated: true, completion: nil)
//        performSegueToReturnBack()
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        if controller.documentPickerMode == UIDocumentPickerMode.import {
            
        }
        
        let cico = url as URL
        //print(cico)
        //print(url)
        
        //print(url.lastPathComponent)
        do{
            self.img = try Data(contentsOf: url)
            
        } catch {
            //print(error)
        }
        
        //print(url.pathExtension)
        self.View3.isHidden = false
        self.View3A.isHidden = false
        
    }
    
    
    @IBAction func OKDocumentButton(_ sender: Any) {
        let documentTypeName = self.DocumentTextField.text as? String
        if documentTypeName != "" && documentTypeName != " " {
            self.flag2 = true
        }
        if (self.flag1  && self.flag2 ) && (self.title1 != nil) && (self.DocumentLabel != nil)
        {
            //Submit Button Functionality
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            let params = userIDData["user_id"] as! String
            let apiKey = "1234"
            let Action = "doc_locker_file_upload"
            let user_device = UIDevice.current.identifierForVendor!.uuidString
            var data2:[String:Any] = ["user_id":params,"api_key":apiKey,"action":Action,"document_name":documentTypeName as! String,"user_device":user_device,"user_type":"VOL","document_type":title1 as! String]
            
            
            let imageSize: Int = img!.count
            //print("actual size of image in KB: %f ", Double(imageSize)/1000.0 )
            let limit:Double = 2000.0
            if(Double(imageSize/1000) <= limit)
            {
                //print(data2)
                let serviceHanlder = ServiceHandlers()
                serviceHanlder.uploadLockerFiles(data_details:data2,file:img!) { (responce, isSuccess) in
                    if isSuccess {
                        
                        let name = (responce as! [String : Any])["res_message"]
                        let alert = UIAlertController(title: nil, message: name as! String, preferredStyle: UIAlertController.Style.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                        self.DocumentLabel.text = ""
                        self.docTypePressed.setTitle("Select Type",for: .normal)
                        self.img = nil
                        self.flag1 = false
                        self.flag2 = false
                        self.title1 = nil
                        self.View3.isHidden = true      // 15th May
                        self.View3A.isHidden = true
                        
                        self.lockerlistfunction()
                    }
                    
                }
                
            }else{
                let alert = UIAlertController(title: nil, message: "Image must be less then 5 MB.", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }else {
            
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Fields can not be left blank!", comment: ""), preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func CancelDocumentButton(_ sender: Any) {
        self.View3.isHidden = true
        self.View3A.isHidden = true
        
    }
    fileprivate func showPopoverForView2(view:Any, contents:Any) {
        let controller = DropDownItemsTable(contents)
        let senderButton = view as! UIButton
        controller.showPopoverInDestinationVC(destination: self, sourceView: view as! UIView) { (selectedValue) in
            if let selectVal = selectedValue as? String {
                senderButton.setTitle(selectVal, for: .normal)
                senderButton.setImage(nil, for: .normal)
            } else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetCountryServiceStrings.keyCountryName] as? String {
                senderButton.setTitle(title, for: .normal)
                senderButton.setImage(nil, for: .normal)
            }  else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetStateServiceStrings.keyStateName] as? String {
                senderButton.setTitle(title, for: .normal)
                senderButton.setImage(nil, for: .normal)
            }else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetDocumentType.documentTypeName] as? String {
                self.title1 = selectVal[GetDocumentType.documentTypeID] as! String
                senderButton.setTitle(title, for: .normal)
                senderButton.setImage(nil, for: .normal)
            }
            
        }
    }
    
    
}


