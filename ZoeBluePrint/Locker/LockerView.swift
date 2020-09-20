//
//  LockerView.swift
//  ZoeBlueprint
//
//  Created by iOS Training on 23/09/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import Alamofire
import MobileCoreServices
class LockerView: UIViewController,UITableViewDelegate,UITableViewDataSource,dataPass, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate,UITextFieldDelegate,XMLParserDelegate {
   
    
    @IBOutlet weak var sideMenu: UIButton!
    
    @IBOutlet weak var lblHeadingMain: UILabel!
    @IBOutlet weak var dropdownImage: UIImageView!
    @IBOutlet weak var NoDataView1: UIView!
    
    @IBOutlet weak var NoDataFound2: UILabel!
    
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var documentName: UITextField!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBAction func documentTypeList(_ sender: Any) {
        let utility = Utility()
               utility.fetchDocumentType() { (countryList, isValueFetched) in
                   if let list = countryList {
                       self.showPopoverForView2(view: sender, contents: list)
                   }
               }
        self.flag1 = true
    }
    func profile_pic()  {
           let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
           let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
           let params = userIDData["user_id"] as! String
           let serivehandler = ServiceHandlers()
           serivehandler.editProfile(user_id: params){(responce,isSuccess) in
               if isSuccess{
                   let data = responce as! Dictionary<String,Any>
                  let string_url = data["user_profile_pic"] as! String
                   if let url = URL(string: string_url){
                   do {
                     let imageData = try Data(contentsOf: url as URL)
                       self.profilePic.image = UIImage(data: imageData)
                       self.profilePic.layer.borderWidth = 1
                       self.profilePic.layer.masksToBounds = false
                       self.profilePic.layer.borderColor = UIColor.black.cgColor
                       self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2
                       self.profilePic.clipsToBounds = true
                   } catch {
                       //print("Unable to load data: \(error)")
                   }
                   }
           }
       }
    }
    @IBAction func btnSubmit(_ sender: Any) {
        
        let documentTypeName = self.documentName.text as? String
        if documentTypeName != "" && documentTypeName != " " {
            self.flag2 = true
        }
        if (self.flag1  && self.flag2 ) && (self.title1 != nil) && (self.documentName != nil)
        {
            //Submit Button Functionality
              let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                  let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                  let params = userIDData["user_id"] as! String
             let apiKey = "1234"
              let Action = "doc_locker_file_upload"
            let user_device = UIDevice.current.identifierForVendor!.uuidString
            var data2:[String:Any] = ["user_id":params,"api_key":apiKey,"action":Action,"document_name":documentTypeName as! String,"user_device":user_device,"user_type":"CSO","document_type":title1 as! String]
           
            
            let imageSize: Int = img!.count
            let limit:Double = 2000.0
            if(Double(imageSize/1000) <= limit)
            {
           // //print(data2)
            let serviceHanlder = ServiceHandlers()
                serviceHanlder.uploadLockerFiles(data_details:data2,file:img!) { (responce, isSuccess) in
                           if isSuccess {
                           
     let name = (responce as! [String : Any])["res_message"]
    let alert = UIAlertController(title: nil, message: name as! String, preferredStyle: UIAlertController.Style.alert)
                                      
        alert.addAction(UIAlertAction(title: NSLocalizedString(NSLocalizedString("OK", comment: ""), comment: ""), style: UIAlertAction.Style.default, handler: nil))
  self.present(alert, animated: true, completion: nil)
  self.documentName.text = ""
     self.EventTypeButton.setTitle("Select Type",for: .normal)
      self.img = nil
      self.flag1 = false
       self.flag2 = false
        self.title1 = nil
       self.mainView.isHidden = true
    self.backgroundView.isHidden = true
           self.lockerlistfunction()
               }
                }
            
        }else{
    let alert = UIAlertController(title: nil, message: NSLocalizedString("Image must be less then 2 MB.", comment: ""), preferredStyle: UIAlertController.Style.alert)
          
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
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.mainView.isHidden = true
        
        self.backgroundView.isHidden = true
        
    }
    var fileUrl:URL!
    var flag1:Bool = false
    var flag2:Bool = false
    var title1: String?
    var img:Data?
    var fileType:String?
    var fileImage:String?
    @IBOutlet weak var EventTypeButton: UIButton!
    
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
             if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
             {
                self.img =  (image as? UIImage)!.jpegData(compressionQuality: 1.0)!
                self.mainView.isHidden = false
                self.backgroundView.isHidden = false
             }else{
                 //print("error")
             }
//    if (fileType == "jpg"){
//        fileImage = ""
//    }else if(fileType == "png"){
//        fileImage = ""
//    }
             self.dismiss(animated: true, completion: nil)
         }
         
@IBAction func UploadImage(_ sender: Any) {
        
        let alert = UIAlertController(title: NSLocalizedString("UPLOAD FILES FROM", comment: ""), message: "", preferredStyle: .alert)
               let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                   /** What we write here???????? **/
                    let image = UIImagePickerController()
                          image.delegate = self
                          image.sourceType = UIImagePickerController.SourceType.photoLibrary
                          image.allowsEditing = false
                          self.present(image, animated: true)
                          {
                              
                          }
                   // call method whatever u need
               })
               let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                          /** What we write here???????? **/
                          let image = UIImagePickerController()
                           image.delegate = self
                          image.sourceType = UIImagePickerController.SourceType.camera
                          image.allowsEditing = false
                          self.present(image, animated: true)
                          {
                            self.mainView.isHidden = false
                            
                            self.backgroundView.isHidden = false
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
               alert.addAction(camera)
               alert.addAction(drive)
               alert.addAction(noButton)
               present(alert, animated: true)
        
}
  
    var typeList: [[String:Any]]?
    
    
    @IBOutlet var tblView: UITableView!
    // MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.tblView.tableFooterView = UIView(frame: .zero)
        NoDataView1.isHidden = true
        NoDataFound2.isHidden = true
                   
        self.profile_pic()
        self.EventTypeButton.setTitle(NSLocalizedString("Document Type", comment: ""), for: .normal)
        self.lockerlistfunction()
        documentName.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       /* let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode" {
            
            DarkMode()
        }else  if defaults == "Light Mode"{
         
            LightMode()
        }*/
        self.lockerlistfunction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        documentName.setUnderLineOfColor(color: .black)
    }
    func DarkMode() {
    
        self.view.backgroundColor = .black
        tblView.backgroundColor = .black
        self.mainView.backgroundColor = .darkGray
       
        EventTypeButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        EventTypeButton.backgroundColor = .darkGray
        EventTypeButton.borderColor = .lightGray
        EventTypeButton.cornerRadius = 5.0
        dropdownImage.image = UIImage(named: "whitedrop.png")
        
        NoDataFound2.textColor = .white
        NoDataView1.backgroundColor = .black
        
        documentName.attributedPlaceholder = NSAttributedString(string: "Please enter the Document Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        documentName.textColor = .black
        
    sideMenu.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        
//        lblHeadingMain.backgroundColor = .green
    
    }
    
    func LightMode() {
        
        self.view.backgroundColor = .white
        tblView.backgroundColor = .white
        self.mainView.backgroundColor = .white
        
        EventTypeButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        EventTypeButton.backgroundColor = .white
        EventTypeButton.borderColor = .black
        dropdownImage.image = UIImage(named: "dropdownarrow.png")
        
        NoDataFound2.textColor = .black
        NoDataView1.backgroundColor = .white
        
        documentName.attributedPlaceholder = NSAttributedString(string: "Please enter the Document Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
         documentName.textColor = .white
        sideMenu.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
        
        
        
        
    }
   @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= 0.0
            }
        }
    }
    
    @IBAction func notificationButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
               let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
                 present(obj,animated: true)
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
      
    
    //MARK:- LOCKER LIST FUNCTION
    
    func lockerlistfunction() {
         //Get UserId from userDefault
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let params = userIDData["user_id"] as! String
        //print(params)
        
          let serviceHanlder = ServiceHandlers()
              serviceHanlder.lockerList(user_id: params) { (responce, isSuccess) in
                             if isSuccess {
                                 if let EventTypeData = responce as? [[String:Any] ] {
                                  self.typeList = EventTypeData
                                  //print(self.typeList!)
                                  let utility = Utility()
                                         utility.fetchDocumentType() { (countryList, isValueFetched) in
            if let list = countryList {
            let docdata = list[0]
                                                                             
        self.title1 = docdata["document_type_id"] as! String
    let strDocTitle = docdata["document_type_name"] as! String
        self.EventTypeButton.setTitle(strDocTitle, for: .normal)
                          }
                         }
         self.tblView.reloadData()
                   
                                 }else{
             
             self.typeList = nil
             self.tblView.reloadData()
                                    
                                }
                             }
                             
                         }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    // MARK: - table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if let cc = typeList?.count
        {
            //print(cc)
            
                       NoDataView1.isHidden = true
                       NoDataFound2.isHidden = true
            return cc
            
       
        }else{
            
            NoDataView1.isHidden = false
            NoDataFound2.isHidden = false
            
            return 0
        }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LockerDetailTableViewCell
     
        let docUrlString: String = [typeList![indexPath.row]][0]["document_file_name"] as! String
               let docUrlArr = docUrlString.components(separatedBy: ".")
               
               let fileType: String = docUrlArr.last!
              // //print(fileType)
               if fileType == "png" || fileType == "PNG"{
                cell.imgView.image = UIImage(named: "circle+png.png")
               
           
               }else if fileType == "pdf" || fileType == "PDF"{
                cell.imgView.image = UIImage(named: "circle+pdf.png")
                
    
               }else if fileType == "jpg" || fileType == "JPG" || fileType == "JPEG" || fileType == "jpeg"{
               cell.imgView.image = UIImage(named: "dark+jpg.png")
       
               
               }else if fileType == "xls" || fileType == "XLS"{
                cell.imgView.image = UIImage(named: "circle+xls.png")
       
               
               }else if fileType == "ppt" || fileType == "PPT"{
               cell.imgView.image = UIImage(named: "circle2+ppt.png")
       
               
               }else if fileType == "txt" || fileType == "TXT"{
               cell.imgView.image = UIImage(named: "darker+txt.png")
       
               
               }else if fileType == "doc" || fileType == "DOC" || fileType == "Doc"{
               cell.imgView.image = UIImage(named: "dark+docfile.png")
       
               
               }else if fileType == "TIF" || fileType == "GIF" || fileType == "gif" || fileType == "tif"{
             cell.imgView.image = UIImage(named: "darkcircle+image.png")
                
        
               
               }else if fileType == "mp3" || fileType == "MP3" {
               cell.imgView.image = UIImage(named: "circle+mp3.png")
        
       
               
               }else if fileType == "MPG" || fileType == "WEBM" || fileType == "MP2" || fileType == "MPV" || fileType == "MPE" || fileType == "MPEG" || fileType == "MOV" || fileType == "OGG" || fileType == "QT" || fileType == "M4P" || fileType == "FLV" || fileType == "WMV" || fileType == "SWF" || fileType == "AVCHD" || fileType == "M4V"{
               cell.imgView.image = UIImage(named: "dark+video.png")
       
               }else{
                
                cell.imgView.image = UIImage(named: "circle+undefined.png")
             }
      
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
      /*  let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode"{
            
            cell.backgroundColor = .black
            cell.lbnText.textColor = .white
            cell.lbnDocumentName.textColor  = .white
            cell.lbnDocumentDate.textColor = .lightGray
            
        }else if defaults == "Light Mode"{
            
            cell.backgroundColor = .white
            cell.lbnText.textColor = .black
            cell.lbnDocumentDate.textColor  = .black
            cell.lbnDocumentDate.textColor = .lightGray
        }*/
        
        
        cell.lbnText.text = [typeList![indexPath.row]][0]["document_type_name"] as? String
        
        
    var date = [typeList![indexPath.row]][0]["document_add_date"] as! String
        date = "Date: \(date)"
       // //print(date)
        cell.lbnDocumentDate.text = date as! String
        
        cell.lbnDocumentName.text = [typeList![indexPath.row]][0]["document_name"] as? String
        cell.delegate = self as! dataPass
        cell.btnTrash.tag = indexPath.row
        cell.btnDownload.tag = indexPath.row
           return cell
       }
    
    //MARK:- PROTOCOL METHOD FOR DOWNLOAD FUNCTIONALITY
  func tagdown(tag: Int) {
    let alert = UIAlertController(title: NSLocalizedString("DOWNLOAD DOCUMENT?", comment: ""), message: NSLocalizedString("Do you want to download the document?", comment: ""), preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(_ action: UIAlertAction) -> Void in
        ActivityLoaderView.startAnimating()
        let document_file_url = [self.typeList![tag]][0]["document_file_name"] as? String
        
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
               // //print("destinationUrl \(destinationUrl.absoluteURL)")
                ActivityLoaderView.stopAnimating()
                self.saveDataToPhone(fileName: fileName!)
            }
        }
    }))
    alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
    
    
  }
    
    func saveDataToPhone(fileName:String)
    {
        
        do {
            let fileData = try Data(contentsOf: self.fileUrl as URL)
            let activityController = UIActivityViewController(activityItems: [fileData], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
           // let activityViewController = UIActivityViewController(activityItems: [fileName, fileData], applicationActivities: nil)
           // present(activityViewController, animated: true, completion: nil)
            
        } catch {
            //print("Unable to load data: \(error)")
        }
        
    }
    
    
//MARK:- PROTOCOL METHOD FOR DELETE FUNCTIONALITY
    
   func tagNumber(tag: Int) {
       //Alert View
    
    let alert = UIAlertController(title: NSLocalizedString("DELETE DOCUMENT ?", comment: ""), message: "Do you want to delete the document?", preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ action in
        

        let document_id = [self.typeList![tag]][0]["document_id"]
           
              // User_id
               let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                 let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                 let user_id = userIDData["user_id"] as! String
            
                let user_type = "CSO"
                let user_device = UIDevice.current.identifierForVendor!.uuidString
        
        let data1:[String:Any] = ["document_id": document_id as! String,"user_id": user_id,"user_type": user_type,"user_device": user_device]
            //  //print(data1)
              let serviceHanlder = ServiceHandlers()
                  serviceHanlder.deletelocker(data_details:data1){ (data, isSuccess) in
                             if isSuccess {
                                if let EventTypeData = data as? String {
                                    self.lockerlistfunction()
                                    self.tblView.reloadData()
             let alert = UIAlertController(title: nil, message: NSLocalizedString("Document deleted Succesfully", comment: ""), preferredStyle: UIAlertController.Style.alert)
                      
                                  // add an action (button)
                                  alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                      
                                  // show the alert
                                  self.present(alert, animated: true, completion: nil)
    
             }
          }
                        
        }

        
    }))
    alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))

    self.present(alert, animated: true)
    
    
    
          
      }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {

        if controller.documentPickerMode == UIDocumentPickerMode.import {
               // This is what it should be
            //self.newNoteBody.text
            //var aa:String = String(contentsOfFile: url.path)
           }
        
     let cico = url as URL
     //print(cico)
     //print(url)

    // //print(url.lastPathComponent)
        do{
        self.img = try Data(contentsOf: url)
       
        } catch {
                   //print(error)
               }
        //self.img  = url
    // //print(url.pathExtension)
        self.mainView.isHidden = false
        
        self.backgroundView.isHidden = false
    
}
    //MARK:- THIS FUNCTION IS USE FOR UPLOAD FILE LIKE PDF/TXT ETC
    func file_upload(){
        
        
        
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
