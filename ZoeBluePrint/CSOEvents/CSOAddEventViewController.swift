//
//  CSOAddEventViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 21/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import Alamofire

public enum UIButtonBorderSide {
    case  Bottom
}
protocol refreshData {
    func refreshDataList(flagr:Bool)
}

class CSOAddEventViewController: UIViewController,UINavigationControllerDelegate,UIDocumentPickerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,LatLongdata,UIWebViewDelegate,XMLParserDelegate {
    
     
    @IBOutlet weak var closeButton_webView: UIButton!
    
    var listTimeZone: [[String:Any]]!
    var data_refresh:refreshData?
    @IBOutlet weak var webV: UIWebView!
    
    @IBOutlet weak var lblEventType: UILabel!
    
    
    
    @IBOutlet weak var startEndTimeView: UIView!
    @IBOutlet weak var startEndView: UIView!
    
    @IBOutlet weak var stateLbl: UILabel!
    
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var lblZoneTime: UILabel!
    @IBOutlet weak var backgroundView_webView: UIView!
    @IBOutlet weak var waiverViewHeight: NSLayoutConstraint!
    var myeventview:UIView?
     var typeList: [[String:Any]]?
    var stateCode:String?
    var stateName = String()
   
    
@IBAction func showMap(_ sender: Any) {
    
    if(self.stateName != ""){
         let mainSB = UIStoryboard(name: "Main", bundle: nil)
        if let mapVC = mainSB.instantiateViewController(withIdentifier: "mapview") as? Map {
            UserDefaults.standard.set("open", forKey: "map")
            mapVC.state_code = self.stateCode
            mapVC.state_name = self.stateName
            mapVC.city = self.txtFldCity.text
            mapVC.country = self.btnCountrySel.titleLabel?.text
            mapVC.longitu = self.lang
             mapVC.latitu = self.lat
            mapVC.delegate = self
            self.present(mapVC, animated: true, completion: nil)
        
        }
        
    }else{
        UserDefaults.standard.set("close", forKey: "map")
        let alert = UIAlertController(title: nil, message: NSLocalizedString("Select State", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                             
                                                         // add an action (button)
                                                         alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                                             // show the alert
                                                         self.present(alert, animated: true, completion: nil)
    }
    
    }
    
    var sDate = String ()
    var eDate = String()
    
    
    @IBOutlet weak var lblEvent: UILabel!
    
    @IBOutlet weak var lblTimezone: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    
    @IBOutlet weak var lblStartDateBottomLine: UILabel!
    @IBOutlet weak var imageStartDate: UIImageView!
    @IBOutlet weak var lblEndDateBottomLine: UILabel!
    @IBOutlet weak var imageEndDate: UIImageView!
    
    @IBOutlet weak var startEndBG: UIView!
    
    @IBOutlet weak var imageDrop: UIImageView!
    
    @IBOutlet weak var imageDrop2: UIImageView!
    @IBOutlet weak var endStartTimeBG: UIView!
    
    @IBOutlet weak var imageDrop3: UIImageView!
    
    @IBOutlet weak var imageDrop4: UIImageView!
    
    @IBOutlet weak var lblWaiver: UILabel!
    
    
    @IBOutlet weak var imageStartTime: UIImageView!
    @IBOutlet weak var lblStartTimeBottom: UILabel!
    
    @IBOutlet weak var imageEndTime: UIImageView!
    @IBOutlet weak var lblEndtimeBottomLine: UILabel!
    
    
    
    @IBOutlet weak var lblHaveWaiverDocument: UILabel!
    
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    @IBOutlet weak var btnStartTime: UIButton!
    @IBOutlet weak var btnEndTime: UIButton!
    @IBOutlet weak var btnAddUpdate: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnViewOnMap: UIButton!
    @IBOutlet weak var btnEndDateSel: UIButton!
    @IBOutlet weak var btnStartDateSel: UIButton!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPhone: UITextField!
    @IBOutlet weak var txtFldAddress: UITextField!
    @IBOutlet weak var btnTimeZoneSel: UIButton!
    @IBOutlet weak var txtFldPostalcode: UITextField!
    @IBOutlet weak var txtFldCity: UITextField!
    @IBOutlet weak var btnStateSel: UIButton!
    @IBOutlet weak var btnCountrySel: UIButton!
    @IBOutlet weak var txtFldEventDescription: UITextField!
    @IBOutlet weak var txtfldEventName: UITextField!
    @IBOutlet weak var btnEventSelection: UIButton!
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapview: UIImageView!
    var selectbutton:UIButton?
    var myeventbtn:UIButton?
    var myEventview:UIView?
    var  tabbarCnt :  UITabBarController!
    var waiver:String?
    var screenTitle = String ()
    var eventDetail = [String : Any] ()
    var StartTime:String = ""
    var EndTime:String = ""
    var check = false
    var neweventbutton:UIButton?
    var lang:String = ""
    var lat:String = ""
    
    var eventTypeId:String = ""
    var countryID:String = ""
    var stateID:String = ""
    var timeZoneID:String = ""
    var imgName:String = ""
    var fileName:String = ""
    var eventIdFromServer:String = ""
    var waiverfileupload:Bool?
    var req:String?
    var edit_event_data:Dictionary<String,Any>?
    
    @IBOutlet weak var waiverDocument: UIView!
    
    @IBOutlet weak var waiverText1: UILabel!
    
    @IBOutlet weak var waiverResetButtonOutlet: UIButton!
    @IBOutlet weak var waiverText2: UILabel!
    
    @IBOutlet weak var DetailLabel: UILabel!
    
    
    @IBOutlet weak var waiverFileButtonOutlet: UIButton!
    var file:Data?
    var img:Data?
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addUnderLineToField(color: .black)
        btnEventSelection.setDropDownImagWithInset()
        btnTimeZoneSel.setDropDownImagWithInset()
        btnStateSel.setDropDownImagWithInset()
        btnCountrySel.setDropDownImagWithInset()
        
    }
    
    func addUnderLineToField(color:UIColor)  {
        
        
        txtFldCity.setUnderLineOfColor(color: color)
        txtFldEmail.setUnderLineOfColor(color: color)
        txtFldPhone.setUnderLineOfColor(color: color)
        txtFldAddress.setUnderLineOfColor(color: color)
        txtfldEventName.setUnderLineOfColor(color: color)
        txtFldPostalcode.setUnderLineOfColor(color: color)
        txtFldEventDescription.setUnderLineOfColor(color: color)
        
    }
    
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == self.txtFldPhone){
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)

            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)

            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int

                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()

            if hasLeadingOne {
                formattedString.append("1 ")
                index += 1
            }
            if (length - index) > 3 {
                let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("(%@)", areaCode)
                index += 3
            }
            if length - index > 3 {
                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }

            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        }
        if(textField == txtFldPostalcode){     // 25_Feb Prachi
             
                 guard let textFieldText = textField.text,
                           let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                               return false
                       }
                       let substringToReplace = textFieldText[rangeOfTextToReplace]
                       let count = textFieldText.count - substringToReplace.count + string.count
                       return count <= 5
        }
            return true
        }
    
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {

            if controller.documentPickerMode == UIDocumentPickerMode.import {
                   // This is what it should be
                //self.newNoteBody.text
                //var aa:String = String(contentsOfFile: url.path)
               }
        
         let cico = url as URL
        
        self.fileName = url.lastPathComponent
        self.DetailLabel.text = url.lastPathComponent
       //  //print(url.lastPathComponent)
            do{
            self.file = try Data(contentsOf: url)

            } catch {
                       //print(error)
                   }
            //self.img  = url
        // //print(url.pathExtension)
        self.DetailLabel.text = url.lastPathComponent

    }
    @IBAction func waiverUploadButton(_ sender: Any) {
        
        let alert = UIAlertController(title: NSLocalizedString("UPLOAD FILES FROM", comment: ""), message: "", preferredStyle: .alert)
                      let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                          /** What we write here???????? **/
                        self.waiver = "waiverClassUpload"
                           let image = UIImagePickerController()
                                 image.delegate = self
                                 image.sourceType = UIImagePickerController.SourceType.photoLibrary
                                 image.allowsEditing = false
                         image.modalPresentationStyle = .overCurrentContext
                                 self.present(image, animated: true)
                                 {
                                     
                                 }
                          // call method whatever u need
                      })
                      let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                                 /** What we write here???????? **/
                                 self.waiver = "waiverClassUpload"
                                 let imagePicker = UIImagePickerController()
                                  imagePicker.delegate = self
                                 imagePicker.sourceType = UIImagePickerController.SourceType.camera
                                 imagePicker.allowsEditing = false
                        imagePicker.modalPresentationStyle = .overFullScreen
                                 self.present(imagePicker, animated: true)
                                 {
                                    
                                 }
                                 // call method whatever u need
                             })
               let drive = UIAlertAction(title: NSLocalizedString("Files", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                                       /** What we write here???????? **/
                                      let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
                                           
                                      documentPicker.delegate = self
                                    documentPicker.modalPresentationStyle = .overCurrentContext
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
    @IBAction func checkButton(_ sender: Any) {
        
        if check == false
        {
            check = true
            self.checkButtonOutlet.setImage(UIImage(named: "tick.jpg"), for: .normal)
            self.waiverDocument.isHidden = false
            self.waiverText1.isHidden = false
            self.waiverText2.isHidden = false
            self.waiverFileButtonOutlet.isHidden = false
            self.waiverResetButtonOutlet.isHidden = false
            self.waiverViewHeight.constant = 189.5
        }
        else
        {
            self.check = false
            self.checkButtonOutlet.setImage(UIImage(named: "TickIcon.png"), for: .normal)
            self.waiverFileButtonOutlet.setImage(UIImage(named: "downloaddocument.png"), for: .normal)
            self.waiverDocument.isHidden = true
            self.waiverText1.isHidden = true
                       self.waiverText2.isHidden = true
                       self.waiverFileButtonOutlet.isHidden = true
                       self.waiverResetButtonOutlet.isHidden = true
                      self.waiverViewHeight.constant = 0 
        }
        
        
    }
    
    func mapData(lang:String,lat:String,city:String,postal_code:String,address:String){
        self.lang = lang
        self.lat = lat
        self.txtFldPostalcode.text = postal_code
        self.txtFldAddress.text = address
        self.txtFldCity.text = city
       // UserDefaults.standard.set("close", forKey: "map")
    }
    
    @IBAction func selectFileButton(_ sender: Any) {
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        
        
        self.file = nil
        self.fileName = ""
        self.DetailLabel.text = ""
    }
    
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           picker.dismiss(animated: true)
        if (self.waiver == "waiverClassUpload"){
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            {

             self.file = (image as? UIImage)!.jpegData(compressionQuality: 0.5)!
             guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL
                 else {
                    self.fileName = "File"
                    self.DetailLabel.text = self.fileName
                    return }
             self.fileName = fileUrl.lastPathComponent
                self.DetailLabel.text = fileUrl.lastPathComponent
              // //print(fileName)
            }
        }else if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
           {
            self.imgEvent.image = image
            self.img = (image as? UIImage)!.jpegData(compressionQuality: 0.5)!
            guard let fileURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
            else {
                self.imgName = "image1"
                return
            }
            
            self.imgName = fileURL.lastPathComponent
      
        }else if let cameraImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            self.imgEvent.image = cameraImage
            self.imgEvent.contentMode = .scaleToFill
            
        
        }else{
            // print("error")
    }

           picker.dismiss(animated: true, completion: nil)
       }

    @IBAction func startEventTime(_ sender: Any) {
        let dateSelectionPicker = DateSelectionViewController(startDate: nil, endDate:  nil)
        dateSelectionPicker.view.frame = self.view.frame
        dateSelectionPicker.view.layoutIfNeeded()
        dateSelectionPicker.captureSelectDateValue(sender, inMode: .time) { (selectedDate) in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            let dateString = formatter.string(from: selectedDate)
            self.StartTime = dateString
            (sender as AnyObject).setTitle(dateString, for:.normal)
            (sender as AnyObject).setImage(nil, for: .normal)
        }
        addViewController(viewController: dateSelectionPicker)
        
        
    }
    
    @IBAction func endEventTime(_ sender: Any) {
        let dateSelectionPicker = DateSelectionViewController(startDate: nil, endDate:  nil)
               dateSelectionPicker.view.frame = self.view.frame
               dateSelectionPicker.view.layoutIfNeeded()
               dateSelectionPicker.captureSelectDateValue(sender, inMode: .time) { (selectedDate) in
                   let formatter = DateFormatter()
                   formatter.dateFormat = "hh:mm a"
                   let dateString = formatter.string(from: selectedDate)
                   self.EndTime = dateString
                   (sender as AnyObject).setTitle(dateString, for:.normal)
                   (sender as AnyObject).setImage(nil, for: .normal)
               }
               addViewController(viewController: dateSelectionPicker)
    }
    @IBAction func startEventDate(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
       // //print(eventDetail["event_register_start_date"]!)
       // //print(eventDetail["event_register_end_date"]!)
        let startDate = dateFormatter.date(from: "06-01-2019" )
        let endDate = dateFormatter.date(from: "06-01-2050")
        
        
        let dateSelectionPicker = DateSelectionViewController(startDate: startDate!, endDate:  endDate!)
        dateSelectionPicker.view.frame = self.view.frame
        dateSelectionPicker.view.layoutIfNeeded()
        dateSelectionPicker.captureSelectDateValue(sender, inMode: .date) { (selectedDate) in
            let formatter = DateFormatter()
           // formatter.dateFormat = "dd-MMM-yyyy"
            formatter.dateFormat = "MM-dd-yyyy"
            //08-22-2019
            let dateString = formatter.string(from: selectedDate)
            self.sDate = dateString
            (sender as AnyObject).setTitle(dateString, for:.normal)
            (sender as AnyObject).setImage(nil, for: .normal)
        }
        addViewController(viewController: dateSelectionPicker)
    }
    func addViewController(viewController:UIViewController)  {
           viewController.willMove(toParent: self)
           self.view.addSubview(viewController.view)
           self.addChild(viewController)
           viewController.didMove(toParent: self)
       }
    @IBAction func endEventDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "MM-dd-yyyy"
              // //print(eventDetail["event_register_start_date"]!)
              // //print(eventDetail["event_register_end_date"]!)
               let startDate = dateFormatter.date(from: "06-01-2019" )
               let endDate = dateFormatter.date(from: "06-01-2050")
               
               
               let dateSelectionPicker = DateSelectionViewController(startDate: startDate!, endDate:  endDate!)
               dateSelectionPicker.view.frame = self.view.frame
               dateSelectionPicker.view.layoutIfNeeded()
               dateSelectionPicker.captureSelectDateValue(sender, inMode: .date) { (selectedDate) in
                   let formatter = DateFormatter()
                  // formatter.dateFormat = "dd-MMM-yyyy"
                   formatter.dateFormat = "MM-dd-yyyy"
                   //08-22-2019
                   let dateString = formatter.string(from: selectedDate)
                   self.eDate = dateString
                   (sender as AnyObject).setTitle(dateString, for:.normal)
                   (sender as AnyObject).setImage(nil, for: .normal)
               }
               addViewController(viewController: dateSelectionPicker)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        let alert = UIAlertController(title: NSLocalizedString("Select image from", comment: ""), message: "", preferredStyle: .alert)
        let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
            /** What we write here???????? **/
             let image = UIImagePickerController()
                   image.delegate = self
                   image.sourceType = UIImagePickerController.SourceType.photoLibrary
                   image.allowsEditing = true
             image.modalPresentationStyle = .overCurrentContext
                   self.present(image, animated: true)
                   {
                       
                   }
            // call method whatever u need
        })
        let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                   /** What we write here???????? **/
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                   let imagePicker = UIImagePickerController()
                   imagePicker.delegate = self
                   imagePicker.sourceType = UIImagePickerController.SourceType.camera
//                   imagePicker.allowsEditing = false
            imagePicker.modalPresentationStyle = .overFullScreen
            self.present(imagePicker, animated: true)
                   // call method whatever u need
            }
               })
        let noButton = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
        alert.addAction(gallery)
        alert.addAction(camera)
        alert.addAction(noButton)
        present(alert, animated: true)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         
       let utility = Utility()
       utility.fetchTimeZone { (eventTypeList, isValueFetched) in
           if let list = eventTypeList {
               // self.showPopoverForView(view: sender, contents: list)
               //print(list)
               self.listTimeZone = list
               let decodedUserData  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                                let userData = NSKeyedUnarchiver.unarchiveObject(with: decodedUserData) as!  Dictionary<String, Any>
               
               if userData["user_timezone"] != nil {
                   var userTimeZone = ""
                   userTimeZone = userData ["user_timezone"] as! String
                   for zoneName in self.listTimeZone{
                                          
                   let strZoneCode = zoneName["timezone_code"] as! String
                   let strZoneName = zoneName["timezone_name"] as! String
                   if strZoneCode == userTimeZone {
                   self.btnTimeZoneSel.setTitle(strZoneName, for: .normal)
                    self.timeZoneID = zoneName["timezone_id"] as! String
                                          }
                                      }
               }
                      
                      
               
           }
       }
        self.hideKeyboardWhenTappedAround()

      self.waiverViewHeight.constant = 0
        // Start : Bottom Line Code for all Text
//        /* 1. */
//        var bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y: txtfldEventName.frame.height-1, width: 355.0, height: 1.0)
//        bottomLine.backgroundColor = UIColor.black.cgColor
//        txtfldEventName.borderStyle = UITextField.BorderStyle.none
//        txtfldEventName.layer.addSublayer(bottomLine)
//        /* 2. */
//        var bottomDescription = CALayer()
//        bottomDescription.frame = CGRect(x: 0.0, y: txtFldEventDescription.frame.height-1, width: 355.0, height: 1.0)
//        bottomDescription.backgroundColor = UIColor.black.cgColor
//        txtFldEventDescription.borderStyle = UITextField.BorderStyle.none
//        txtFldEventDescription.layer.addSublayer(bottomDescription)
//        /* 3. */
//        var bottomAddress = CALayer()
//        bottomAddress.frame = CGRect(x: 0.0, y: txtFldAddress.frame.height-1, width: 355.0, height: 1.0)
//        bottomAddress.backgroundColor = UIColor.black.cgColor
//        txtFldAddress.borderStyle = UITextField.BorderStyle.none
//        txtFldAddress.layer.addSublayer(bottomAddress)
//        /* 4. */
//        var bottomCity = CALayer()
//        bottomCity.frame = CGRect(x: 0.0, y: txtFldCity.frame.height-1, width: 355.0, height: 1.0)
//        bottomCity.backgroundColor = UIColor.black.cgColor
//        txtFldCity.borderStyle = UITextField.BorderStyle.none
//        txtFldCity.layer.addSublayer(bottomCity)
//        /* 5. */
//        var bottomZip = CALayer()
//        bottomZip.frame = CGRect(x: 0.0, y: txtFldPostalcode.frame.height-1, width: 355.0, height: 1.0)
//        bottomZip.backgroundColor = UIColor.black.cgColor
//        txtFldPostalcode.borderStyle = UITextField.BorderStyle.none
//        txtFldPostalcode.layer.addSublayer(bottomZip)
//        /* 6. */
//        var bottomPhone = CALayer()
//        bottomPhone.frame = CGRect(x: 0.0, y:txtFldPhone.frame.height-1 , width:355.0 , height: 1.0)
//        bottomPhone.backgroundColor = UIColor.black.cgColor
//        txtFldPhone.borderStyle = UITextField.BorderStyle.none
//        txtFldPhone.layer.addSublayer(bottomPhone)
//        /* 7. */
//        var bottomMail = CALayer()
//        bottomMail.frame = CGRect(x: 0.0, y: txtFldEmail.frame.height-1, width: 355.0, height: 1.0)
//        bottomMail.backgroundColor = UIColor.black.cgColor
//        txtFldEmail.borderStyle = UITextField.BorderStyle.none
//        txtFldEmail.layer.addSublayer(bottomMail)
//        /* 8. */
//      
     /* Stop */
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
       imgEvent.isUserInteractionEnabled = true
       imgEvent.addGestureRecognizer(tapGestureRecognizer)
        
        
       // //print(screenTitle)

        self.txtFldEmail.delegate = self
        self.txtFldPhone.delegate = self
        self.txtFldAddress.delegate = self
        self.txtFldPostalcode.delegate = self
        self.txtFldEventDescription.delegate = self
        self.txtfldEventName.delegate = self
        self.backgroundView_webView.isHidden = true
        
        if screenTitle == "ADD EVENT DETAILS"{
            self.lblScreenTitle.text = NSLocalizedString("ADD EVENT DETAILS", comment: "")

                 let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                                 let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                                 let user_id = userIDData["user_id"] as! String
                 
                 let serviceHanlder = ServiceHandlers()
                 serviceHanlder.getProfileData1(user_id: user_id) { (data, isSuccess) in
                             if isSuccess{
                              //  //print(data!)
                                 var a = data as? Dictionary<String, Any>
                                // //print(a)
                                 
                                 self.txtFldEmail.text = a!["user_email"] as? String
                                 self.txtFldAddress.text = a!["user_address"] as? String
                   
                                 self.txtFldPhone.text =  self.formattedNumber(number:(a!["user_phone"] as? String)!)
                                 self.txtFldPostalcode.text = a!["user_zipcode"] as? String
                                 self.txtFldCity.text = a!["user_city"] as? String
                                 self.btnStateSel.setTitle(a!["user_state_name"] as? String, for: .normal)
                                 self.btnCountrySel.setTitle(a!["user_country_name"] as? String, for: .normal)
                                 self.countryID = (a!["user_country"] as? String)!
                                 self.stateID = (a!["user_state"] as? String)!
                                 let serviceHanlder = ServiceHandlers()
                                 serviceHanlder.getStateList(country_id: self.countryID){(responce,isSuccess) in
                                     if isSuccess{
                                         let state = responce as! Array<Any>
                                         for state_code in state{
                                             let state_code1 = state_code as! Dictionary<String,Any>
                                             if ((state_code1["state_id"] as! String) == (self.stateID )){
                                                 self.stateCode = (state_code1["state_code"] as! String)
                                                 self.stateName = (state_code1["state_name"] as! String)
                                             }
                                         }
                                     }
                                 }
                                self.countryID = (a!["user_country"] as? String)!
                                 self.stateID = (a!["user_state"] as? String)!
                     }
                                   
                 }
        }else{
         self.lblScreenTitle.text = NSLocalizedString("UPDATE EVENT DETAILS", comment: "")
        }
                       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(XXX)XXX-XXXX"

        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 100.0
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewWillAppear(_ animated : Bool) {
        super.viewWillAppear(animated)
//        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//       
//        if defaults == "Dark Mode" {
//            
//            DarkMode()
//        
//        }else if defaults == "Light Mode"{
//            LightMode()
//            
//        }
        
        
       if screenTitle == "UPDATE EVENT DETAILS"{
           self.lblScreenTitle.text = NSLocalizedString("UPDATE EVENT DETAILS", comment: "")
          
       }else{
           self.lblScreenTitle.text = NSLocalizedString("ADD EVENT DETAILS", comment: "")
        }
        
       
      if(screenTitle.caseInsensitiveCompare(NSLocalizedString("UPDATE EVENT DETAILS", comment: "")) == .orderedSame){
        let servicehandler = ServiceHandlers()
        servicehandler.getSelectedEventDetails(eventId: eventDetail["event_id"] as! String){ (responce, isSuccess) in
        if isSuccess {
            let data_of_event = responce as! Dictionary<String,Any>
            self.edit_event_data = data_of_event
            let waiver = data_of_event["event_waiver_req"]
            self.btnAddUpdate.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
            self.btnEndDateSel.setTitle(data_of_event["event_register_end_date"] as? String, for: .normal)
                self.lat = data_of_event["event_latitude"] as! String
            self.eventIdFromServer = self.eventDetail["event_id"] as! String
           
                self.lang = data_of_event["event_longitude"] as! String
                
                self.eDate = data_of_event["event_register_end_date"] as! String
                self.sDate = data_of_event["event_register_start_date"] as! String
            self.btnStartDateSel.setTitle(data_of_event["event_register_start_date"] as? String, for: .normal)
            
//            var Start
                self.btnStartTime.setTitle(data_of_event["event_start_time_format"] as? String, for: .normal)
                self.StartTime = data_of_event["event_start_time_format"] as! String
                self.btnEndTime.setTitle(data_of_event["event_end_time_format"] as? String, for: .normal)
                self.EndTime = data_of_event["event_end_time_format"] as! String
            self.txtFldEmail.text = data_of_event["event_email"] as? String
//           print(data_of_event["event_address"])
//           print((data_of_event["event_postcode"] as? String))
//           print((data_of_event["event_city"] as? String))
//            print((data_of_event["event_phone"] as? String))
//            print(data_of_event["event_heading"] )
//
            print(data_of_event)
          // let add = data_of_event["event_address"]!
            //let strAdd = String(describing: add)
            self.txtFldAddress.text = data_of_event["event_address"] as? String ?? "default value"
            
            //let pcode = data_of_event["event_postcode"]!
            //let strpcode = String(describing: pcode)
            self.txtFldPostalcode.text = data_of_event["event_postcode"] as? String ?? "default value"

            
            //let phone = data_of_event["event_phone"]!
            //let strphone = String(describing: phone)
            self.txtFldPhone.text = self.formattedNumber(number:(data_of_event["event_phone"] as? String)!)

            
            self.timeZoneID = (data_of_event["event_timezone"] as? String)!
             self.txtFldCity.text = (data_of_event["event_city"] as? String)
            self.stateID = data_of_event["event_state"] as! String
             self.stateName = data_of_event["event_state_name"] as! String
             self.btnStateSel.setTitle(data_of_event["event_state_name"] as? String, for: .normal)
             self.btnCountrySel.setTitle(data_of_event["event_country_name"] as? String, for: .normal)
            self.countryID = (data_of_event["event_country"] as? String)!
             self.txtFldEventDescription.text = data_of_event["event_details"] as? String
             self.txtfldEventName.text = data_of_event["event_heading"] as? String
            self.imgName = (data_of_event["event_image"] as? String)!
            
            if (self.listTimeZone != nil){
            for zoneName in self.listTimeZone{
                    
                  let strZoneName = zoneName["timezone_name"] as! String
                    print(strZoneName)
              
                    if strZoneName == data_of_event["event_timezone_name"]as! String
                {
               self.btnTimeZoneSel.setTitle(strZoneName, for: .normal)
                                              }
                    print(data_of_event["event_timezone_name"]as! String)
                    print(strZoneName)
                                          }
            }
             
            let fileUrl = URL(string: data_of_event["event_waiver_doc"] as! String)
            if(fileUrl != nil)
            {
            if let imageData = NSData(contentsOf: (fileUrl!)){
                self.file = imageData as Data
                }
                
            }
            
           
            self.btnEventSelection.setTitle(data_of_event["event_type_name"] as? String, for: .normal)
            if(waiver as! String == "1"){
                
                self.waiverViewHeight.constant = 189.5
                self.DetailLabel.text = data_of_event["event_waiver_doc_name"] as? String
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.TapOnLabel))
               
                tapGesture.numberOfTapsRequired = 1
                tapGesture.numberOfTouchesRequired = 1
                
                self.DetailLabel.addGestureRecognizer(tapGesture)
                self.DetailLabel.isUserInteractionEnabled = true
                self.DetailLabel.attributedText = NSAttributedString(string: self.DetailLabel.text as? String ?? "", attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
                    
                    self.fileName = data_of_event["event_waiver_doc_name"] as! String
                self.waiverDocument.isHidden = false
                self.checkButtonOutlet.setImage(UIImage(named: "tick.jpg"), for: .normal)
                self.waiverText1.isHidden = false
                self.waiverText2.isHidden = false
                self.waiverFileButtonOutlet.isHidden = false
                self.waiverResetButtonOutlet.isHidden = false
            }else{
                self.waiverViewHeight.constant = 0
                self.waiverDocument.isHidden = true
                self.waiverText1.isHidden = true
                self.waiverText2.isHidden = true
                self.waiverFileButtonOutlet.isHidden = true
                self.waiverResetButtonOutlet.isHidden = true
                self.fileName = ""
                self.file = nil
                 self.checkButtonOutlet.setImage(UIImage(named: "TickIcon.png"), for: .normal)
            }
            
            
            if let imageURLstr = data_of_event["event_image"] as? String,
                let imageURL:URL = URL(string: imageURLstr.replacingOccurrences(of: " ", with: "%20")) {
                 let serviceHanlder = ServiceHandlers()
                 serviceHanlder.getImageFromURL(url: imageURL) { (data, isSuccess) in
                     if let imgData = data as? Data {
                         DispatchQueue.main.async() { () -> Void in
                             self.img = imgData
                            if let image = UIImage(data: imgData) {
                                self.imgEvent.image = image
                            }
                             
                         }
                     }
                 }
            }
            
//            let string_url = data_of_event["event_image"] as? String
//                       let replacedStr = string_url!.replacingOccurrences(of: " ", with: "%20")
//                           let imageUrl = URL(string: replacedStr)!
//                           do {
//                               let imageData = try Data(contentsOf: imageUrl as URL)
//                               self.imgEvent.image = UIImage(data: imageData)
//
//                           } catch {
//                               //print("Unable to load data: \(error)")
//                           }
            
            self.eventTypeId = data_of_event["event_type_id"] as! String
                       let servicehandler = ServiceHandlers()
                       servicehandler.getEventType(){(responce,isSuccess) in
                           if isSuccess{
                               let data_event = responce as! Array<Any>
                               for event in data_event{
                                   let d = event as! Dictionary<String,Any>
                                   if (d["event_type_id"] as! String) == self.eventTypeId {
                                       self.btnEventSelection.setTitle(d["event_type_name"] as! String, for: .normal)
                                   }
                               }
                           }
                       }
            
            let sv = ServiceHandlers()
            sv.getStateList(country_id: data_of_event["event_country"] as! String){(responce,isSuccess) in
                if isSuccess{
                    let data = responce as! Array<Any>
                    for state in data{
                        let state_n = state as! Dictionary<String,Any>
                        if(state_n["state_name"] as! String == data_of_event["event_state_name"] as! String)
                        {
                            self.stateCode = state_n["state_code"] as! String
                        }
                    }

                }

            }
                    
            
            
        }
            self.view.setNeedsLayout()
            self.viewDidLayoutSubviews()
            self.view.setNeedsUpdateConstraints()
            self.view.layoutIfNeeded()
        }
            
            
        }
}

    func DarkMode() {
    
        self.contentView.backgroundColor = .black
        self.lblScreenTitle.textColor = .white
        self.lblScreenTitle.backgroundColor = .black
        self.txtfldEventName.textColor = .white
        txtfldEventName.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Title*", comment: ""),attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.txtFldEventDescription.textColor = .white
txtFldEventDescription.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Description*", comment: ""),attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.lblEvent.textColor = .white
        self.lblEvent.backgroundColor = .black
        
        btnEventSelection.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnEventSelection.backgroundColor = .black
        btnEventSelection.borderColor = .white
      
        self.lblZoneTime.textColor = .white
        self.btnTimeZoneSel.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnTimeZoneSel.borderColor = .white
        btnTimeZoneSel.backgroundColor = .black
        
        self.txtFldAddress.textColor = .white
        txtFldAddress.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Address*", comment: ""),attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.txtFldCity.textColor = .white
        txtFldCity.attributedPlaceholder = NSAttributedString(string: "City",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.stateLbl.textColor = .white
        self.btnStateSel.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnStateSel.backgroundColor = .black
        self.btnStateSel.borderColor = .white
        
        self.txtFldPostalcode.textColor = .white
        txtFldPostalcode.attributedPlaceholder = NSAttributedString(string: "Zipcode",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.countryLbl.textColor = .white
        self.btnCountrySel.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnCountrySel.backgroundColor = .black
        btnCountrySel.borderColor = .white
        
        self.txtFldEmail.textColor = .white
        txtFldEmail.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Email*", comment: ""),attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        

        startEndView.backgroundColor = .black
        self.btnStartDate.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnStartDate.backgroundColor = .black
        self.imageStartDate.image = UIImage(named: "lightNewCalandar.png")
         self.lblStartDateBottomLine.backgroundColor = .white
        
        self.btnEndDate.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnEndDate.backgroundColor = .black
         self.imageEndDate.image = UIImage(named: "lightNewCalandar.png")
        self.lblEndDateBottomLine.backgroundColor = .white
        
        
        startEndTimeView.backgroundColor = .black
        self.btnStartTime.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnStartTime.backgroundColor = .black
        self.imageStartTime.image = UIImage(named: "lightaddShift.png")
        self.lblStartTimeBottom.backgroundColor = .white
        
        self.btnEndTime.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnEndTime.backgroundColor = .black
        self.imageEndTime.image = UIImage(named: "lightaddShift.png")
        self.lblEndtimeBottomLine.backgroundColor = .white
        
        
       self.txtFldPhone.textColor = .white
        txtFldPhone.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Phone Number*", comment: ""),attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        
        if check {
            check = true
            
            self.checkButtonOutlet.setImage(UIImage(named: "lightWhiteBox.png"), for: UIControl.State.normal)
            
        }else{
            
            self.checkButtonOutlet.borderColor = .white
            
        }
        
        lblHaveWaiverDocument.textColor = .white
        
        
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txtfldEventName.frame.height-1, width: 355.0, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        txtfldEventName.borderStyle = UITextField.BorderStyle.none
        txtfldEventName.layer.addSublayer(bottomLine)
//        /* 2. */
        var bottomDescription = CALayer()
        bottomDescription.frame = CGRect(x: 0.0, y: txtFldEventDescription.frame.height-1, width: 355.0, height: 1.0)
        bottomDescription.backgroundColor = UIColor.white.cgColor
        txtFldEventDescription.borderStyle = UITextField.BorderStyle.none
        txtFldEventDescription.layer.addSublayer(bottomDescription)
        /* 3. */
        var bottomAddress = CALayer()
        bottomAddress.frame = CGRect(x: 0.0, y: txtFldAddress.frame.height-1, width: 355.0, height: 1.0)
        bottomAddress.backgroundColor = UIColor.white.cgColor
        txtFldAddress.borderStyle = UITextField.BorderStyle.none
        txtFldAddress.layer.addSublayer(bottomAddress)
        /* 4. */
        var bottomCity = CALayer()
        bottomCity.frame = CGRect(x: 0.0, y: txtFldCity.frame.height-1, width: 355.0, height: 1.0)
        bottomCity.backgroundColor = UIColor.white.cgColor
        txtFldCity.borderStyle = UITextField.BorderStyle.none
        txtFldCity.layer.addSublayer(bottomCity)
//        /* 5. */
        var bottomZip = CALayer()
        bottomZip.frame = CGRect(x: 0.0, y: txtFldPostalcode.frame.height-1, width: 355.0, height: 1.0)
        bottomZip.backgroundColor = UIColor.white.cgColor
        txtFldPostalcode.borderStyle = UITextField.BorderStyle.none
        txtFldPostalcode.layer.addSublayer(bottomZip)
        /* 6. */
        var bottomPhone = CALayer()
        bottomPhone.frame = CGRect(x: 0.0, y:txtFldPhone.frame.height-1 , width:355.0 , height: 1.0)
        bottomPhone.backgroundColor = UIColor.white.cgColor
        txtFldPhone.borderStyle = UITextField.BorderStyle.none
        txtFldPhone.layer.addSublayer(bottomPhone)
        /* 7. */
        var bottomMail = CALayer()
        bottomMail.frame = CGRect(x: 0.0, y: txtFldEmail.frame.height-1, width: 355.0, height: 1.0)
        bottomMail.backgroundColor = UIColor.white.cgColor
        txtFldEmail.borderStyle = UITextField.BorderStyle.none
        txtFldEmail.layer.addSublayer(bottomMail)
//
    }
    
    func LightMode() {
    
        
        self.view.backgroundColor = .white
        // textField/Label
        self.txtFldEmail.textColor = .black
        self.txtFldPhone.textColor = .black
        self.txtFldAddress.textColor = .black
        self.txtFldPostalcode.textColor = .black
        self.txtFldEventDescription.textColor = .black
        self.txtfldEventName.textColor = .black
        self.txtFldCity.textColor = .black
        self.lblScreenTitle.textColor = UIColor.black
        
        // Button
        self.btnStartDate.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnEndDate.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnStartTime.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnEndTime.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnEndDateSel.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnStartDateSel.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnTimeZoneSel.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnStateSel.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnCountrySel.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnEventSelection.setTitleColor(UIColor.black, for: UIControl.State.normal)
        
        
    }
    
    
    @objc func TapOnLabel(){
        let wav = self.edit_event_data!["event_waiver_doc"] as! String
//        self.view.bringSubviewToFront(webV)
//        self.backgroundView_webView.isHidden = false
//        webV.scalesPageToFit = true
//
//        webV.loadRequest(NSURLRequest(url: NSURL(string: wav)! as URL) as URLRequest)
//        webV.delegate = self as UIWebViewDelegate;
//        self.view.addSubview(webV)
        
        ActivityLoaderView.startAnimating()
         let destination = DownloadRequest.suggestedDownloadDestination()

         Alamofire.download(wav, to: destination).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
             print("Progress: \(progress.fractionCompleted)")
         } .validate().responseData { ( response ) in
             print(response.destinationURL!.lastPathComponent)
            ActivityLoaderView.stopAnimating()
            let alert = UIAlertController(title: "Download Completed!", message: nil, preferredStyle: UIAlertController.Style.alert)
                                             
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
         }
       
    }
 
    //MARK:- FUNCTIONS
    @IBAction func selectEventClick(_ sender: Any) {
            // //print("Event Type Selected")
    
        
             let utility = Utility()
             utility.fetchEventTypeList { (eventTypeList, isValueFetched) in
                 if let list = eventTypeList {
                     self.showPopoverForView(view: sender, contents: list)
                 }
             }
         }
         
         
         @IBAction func btnSelectState(_ sender: Any) {
             let utility = Utility()
             utility.fetchStateList{ (eventTypeList, isValueFetched) in
                 if let list = eventTypeList {
                     self.showPopoverForView2(view: sender, contents: list)
                 }
             }
             
         }
       @IBAction func btnSelectCountry(_ sender: Any) {
           
            let utility = Utility()
            utility.fetchCountryList{ (eventTypeList, isValueFetched) in
                if let list = eventTypeList {
                    self.showPopoverForView1(view: sender, contents: list)
                }
            }
            
        }
        @IBAction func timeZoneSelected(_ sender: Any) {
                  let utility = Utility()
                  utility.fetchTimeZone{ (eventTypeList, isValueFetched) in
                      if let list = eventTypeList {
                          self.showPopoverForView3(view: sender, contents: list)
                      }
                  }
                  
              }
    
        
    @IBAction func CrossButton(_ sender: Any) {
    }
    
    @IBAction func TickButton(_ sender: Any) {
    }
   
    fileprivate func showPopoverForView(view:Any, contents:Any) {
            let controller = DropDownItemsTable(contents)
            let senderButton = view as! UIButton
            controller.showPopoverInDestinationVC(destination: self, sourceView: view as! UIView) { (selectedValue) in
                if let selectVal = selectedValue as? String {
                    senderButton.setTitle(selectVal, for: .normal)
                    senderButton.setImage(nil, for: .normal)
                } else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetEventType.keyEventTypeName] as? String {
                    self.eventTypeId = selectVal[GetEventType.keyEventTypeId] as! String
                    
                    senderButton.setTitle(title, for: .normal)
                    senderButton.setImage(nil, for: .normal)
                }
            }
        }
        fileprivate func showPopoverForView1(view:Any, contents:Any) {
            let controller = DropDownItemsTable(contents)
            let senderButton = view as! UIButton
            controller.showPopoverInDestinationVC(destination: self, sourceView: view as! UIView) { (selectedValue) in
                if let selectVal = selectedValue as? String {
                    senderButton.setTitle(selectVal, for: .normal)
                    senderButton.setImage(nil, for: .normal)
                } else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetCountryServiceStrings.keyCountryName] as? String {
                    self.countryID = selectVal[GetCountryServiceStrings.keyCountryId] as! String
                    senderButton.setTitle(title, for: .normal)
                    senderButton.setImage(nil, for: .normal)
                }  else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetStateServiceStrings.keyStateName] as? String {
                    
                    senderButton.setTitle(title, for: .normal)
                    senderButton.setImage(nil, for: .normal)
                }
            }
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
                    self.stateID = selectVal[GetStateServiceStrings.keyStateId] as! String
                    self.stateCode = selectVal[GetStateServiceStrings.keyStateCode] as! String
                    self.stateName = selectVal[GetStateServiceStrings.keyStateName] as! String
                    senderButton.setTitle(title, for: .normal)
                    senderButton.setImage(nil, for: .normal)
                }
            }
        }
        fileprivate func showPopoverForView3(view:Any, contents:Any) {
            let controller = DropDownItemsTable(contents)
            let senderButton = view as! UIButton
            controller.showPopoverInDestinationVC(destination: self, sourceView: view as! UIView) { (selectedValue) in
                if let selectVal = selectedValue as? String {
                    senderButton.setTitle(selectVal, for: .normal)
                    senderButton.setImage(nil, for: .normal)
                } else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetTimeZone.timeZoneName] as? String {
                    self.timeZoneID = selectVal[GetTimeZone.timeZoneId] as! String
                    senderButton.setTitle(title, for: .normal)
                    senderButton.setImage(nil, for: .normal)
               }
           //         else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetStateServiceStrings.keyStateName] as? String {
    //                senderButton.setTitle(title, for: .normal)
    //                senderButton.setImage(nil, for: .normal)
    //            }
            }
        }
      
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.view.sendSubviewToBack(webV)
        self.backgroundView_webView.isHidden = true
    }
    
    
    
    @IBAction func addUpdateEvent(_ sender: Any) {
        
        if lblScreenTitle == neweventbutton{
            
            self.lblScreenTitle.text = NSLocalizedString("ADD EVENT DETAILS", comment: "")
           // //print(self.lblScreenTitle)
        }else{
            self.lblScreenTitle.text = NSLocalizedString("UPDATE EVENT DETAILS", comment: "")
             //print(self.lblScreenTitle)
        }
        
        if(screenTitle.caseInsensitiveCompare("UPDATE EVENT DETAILS") == .orderedSame){
            if(validate()){
                if(fileName == ""){
                               req = "0"
                               self.waiverfileupload = false
                           }else{
                               req = "1"
                               self.waiverfileupload = true
                           }
            let serviceHanlder = ServiceHandlers()
             
                serviceHanlder.updateEvent(event_id:self.eventIdFromServer,event_type_id:self.eventTypeId ,event_heading:txtfldEventName.text!,event_details:txtFldEventDescription.text!,event_address:txtFldAddress.text!,event_country:self.countryID,event_state:self.stateID,event_city:txtFldCity.text!,event_postcode:txtFldPostalcode.text!,event_timezone:self.timeZoneID,event_latitude:self.lat,event_longitude:self.lang,event_email:txtFldEmail.text!,event_phone:txtFldPhone.text!,event_image:self.imgName,event_register_start_date:self.sDate, event_register_end_date:self.eDate, event_end_time: self.EndTime, event_start_time: self.StartTime, event_waiver_doc: self.fileName,event_waiver_req:req!) { (responce, isSuccess) in
                 if isSuccess {
                    let resdata = responce as! [String: Any]
                 //   //print(resdata)
                    if(self.img != nil){
                                     self.uploadImage()
                }else  if self.waiverfileupload! && (self.file != nil){
                            
                        self.uploadWaiverFile()
                        
                }else{
        self.txtFldEventDescription.text = ""
                    self.txtfldEventName.text = ""
                self.btnTimeZoneSel.setTitle(NSLocalizedString("Select Time Zone", comment: ""), for: .normal)
        self.btnEventSelection.setTitle(NSLocalizedString("Select Event Type", comment: ""), for: .normal)
                        self.timeZoneID = ""
                            self.eventTypeId = ""
            self.btnStartDate.setTitle("", for: .normal)
                    self.sDate = ""
    self.btnEndDate.setTitle("", for: .normal)
                    self.eDate = ""
        self.btnStartTime.setTitle("", for: .normal)
                    self.StartTime = ""
    self.btnEndTime.setTitle("", for: .normal)
        self.EndTime = ""
        self.file = nil
        self.fileName = ""
        self.img = nil
    self.lat = ""
                self.lang = ""
  let alert = UIAlertController(title: nil, message: NSLocalizedString("Event Added Successfully", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                         
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
                                   
                    }
                }
                   
            }
                // self.dismiss(animated: true, completion: nil)
            }
            }else if (validate()){
            
            if(fileName == ""){
                req = "0"
                self.waiverfileupload = false
            }else{
                req = "1"
                self.waiverfileupload = true
            }
            var phone = txtFldPhone.text!
           // //print(phone)
            if phone.count >= 10{
            phone.insert("(", at: phone.startIndex)
            phone.insert(")", at: phone.index(phone.startIndex, offsetBy: 4))
            phone.insert("-", at: phone.index(phone.startIndex, offsetBy: 5))
            phone.insert("-", at: phone.index(phone.startIndex, offsetBy: 9))
            }else {
                let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Please Insert Correct Phone Number", comment: ""), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            let serviceHanlder = ServiceHandlers()
            serviceHanlder.addEvent(event_type_id: eventTypeId, event_heading: txtfldEventName.text!, event_details: txtFldEventDescription.text!, event_address: txtFldAddress.text!, event_country: countryID, event_state: stateID, event_city: txtFldCity.text!, event_postcode: txtFldPostalcode.text!, event_timezone: timeZoneID, event_latitude: lat, event_longitude: lang, event_email: txtFldEmail.text!, event_phone: txtFldPhone.text!, event_image: imgName, event_register_start_date: sDate, event_register_end_date: eDate, event_start_time: StartTime, event_end_time: EndTime, event_waiver_doc: fileName, event_waiver_req: req!){ (responce, isSuccess) in
                if isSuccess {
                    let resdata = responce as! [String: Any]
                    self.eventIdFromServer = resdata["event_id"] as! String
                   // //print(resdata)
                    if(self.img != nil){
                    self.uploadImage()
                    }else  if self.waiverfileupload! && (self.file != nil) {
                                               self.uploadWaiverFile()
                    }else{
                        self.txtFldEventDescription.text = ""
                                                  self.txtfldEventName.text = ""
                                                  self.btnTimeZoneSel.setTitle(NSLocalizedString("Select Time Zone", comment: ""), for: .normal)
                                                  self.btnEventSelection.setTitle(NSLocalizedString("Select Event Type", comment: ""), for: .normal)
                                                  self.timeZoneID = ""
                                                  self.eventTypeId = ""
                                                  self.btnStartDate.setTitle("", for: .normal)
                                                  self.sDate = ""
                                                  self.btnEndDate.setTitle("", for: .normal)
                                                  self.eDate = ""
                                                  self.btnStartTime.setTitle("", for: .normal)
                                                  self.StartTime = ""
                                                  self.btnEndTime.setTitle("", for: .normal)
                                                  self.EndTime = ""
                                                  self.file = nil
                                                  self.fileName = ""
                                                  self.img = nil
                                                  self.lat = ""
                                                  self.lang = ""
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("Event Added Successfully", comment: ""), preferredStyle: UIAlertController.Style.alert)
                        
                           alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                           self.present(alert, animated: true, completion: nil)
                        
                    }
                }
            }
            self.data_refresh?.refreshDataList(flagr: true)
              view.removeFromSuperview()
            self.myeventview?.isHidden = false
          
        }}
    

    //MARK:- UPLOAD IMAGE IN ADD EVENT
    
    func uploadImage() {
        
                let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                let params = userIDData["user_id"] as! String
                let eventId = eventIdFromServer
                let apiKey = "1234"
                let Action = "cso_event_file_upload"
                let user_device = UIDevice.current.identifierForVendor!.uuidString
        var data2:[String:Any] = ["event_id":eventId,"user_id":params,"api_key":apiKey,"action":Action,"img_name":imgName]
        if(img != nil){
                let imageSize: Int = img!.count
              //  //print("actual size of image in KB: %f ", Double(imageSize)/1000.0 )
                let limit:Double = 2000.0
                if(Double(imageSize/1000) <= limit)
                {
                 //   //print(data2)
                    let serviceHanlder = ServiceHandlers()
                    serviceHanlder.addEventImageUpload(data_details:data2,file:img!) { (responce, isSuccess) in
                        if isSuccess {
                         //  //print(responce)
                            if self.waiverfileupload! && (self.file != nil) {
                            self.uploadWaiverFile()
                            }
                            else{
                               
                                self.txtFldEventDescription.text = ""
                self.txtfldEventName.text = ""
        self.btnTimeZoneSel.setTitle(NSLocalizedString("Select Time Zone", comment: ""), for: .normal)
        self.btnEventSelection.setTitle(NSLocalizedString("Select Event Type", comment: ""), for: .normal)
                self.timeZoneID = ""
                self.eventTypeId = ""
                self.btnStartDate.setTitle("", for: .normal)
                                self.imgEvent.image = nil
                            self.sDate = ""
                self.btnEndDate.setTitle("", for: .normal)
                self.eDate = ""
                self.btnStartTime.setTitle("", for: .normal)
            self.StartTime = ""
                self.btnEndTime.setTitle("", for: .normal)
                self.EndTime = ""
                self.file = nil
            self.fileName = ""
                            self.img = nil
                            self.lat = ""
                            self.lang = ""
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Event Updated Successfully", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                                
                                                   alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                                                   self.present(alert, animated: true, completion: nil)
                                
                            }
                            
                        }
                        
                    }
                    self.data_refresh?.refreshDataList(flagr: true)
                     view.removeFromSuperview()
                 self.myeventview?.isHidden = false
                    
                    
                    if !(screenTitle.caseInsensitiveCompare(NSLocalizedString("UPDATE EVENT DETAILS", comment: "")) == .orderedSame){
                        selectbutton = myeventbtn
                               neweventbutton!.setTitleColor(.gray, for: .normal)
                               myeventbtn!.setTitleColor(.black, for: .normal)
                    }
                }else{
                    let alert = UIAlertController(title: nil, message: NSLocalizedString("Image must be upto 5 MB.", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    
    //MARK:- UPLOAD waiver IN ADD EVENT
       
       func uploadWaiverFile() {
                   //Submit Button Functionality
                   let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                   let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                   let params = userIDData["user_id"] as! String
                   let eventId = eventIdFromServer
                   let apiKey = "1234"
                   let Action = "event_doc_upload"
                   let user_device = UIDevice.current.identifierForVendor!.uuidString
           var data2:[String:Any] = ["event_id":eventId,"user_id":params,"api_key":apiKey,"action":Action,"file_name":fileName]
                   let imageSize: Int = file!.count
                  // //print("actual size of image in KB: %f ", Double(imageSize)/1000.0 )
                   let limit:Double = 2000.0
                   if(Double(imageSize/1000) <= limit)
                   {
                      // //print(data2)
                       let serviceHanlder = ServiceHandlers()
                       serviceHanlder.addEventFileUpload(data_details:data2,file:file!) { (responce, isSuccess) in
                           if isSuccess {
                               
                            self.txtFldEventDescription.text = ""
                            self.txtfldEventName.text = ""
                            self.btnTimeZoneSel.setTitle(NSLocalizedString("Select Time Zone", comment: ""), for: .normal)
                            self.btnEventSelection.setTitle(NSLocalizedString("Select Event Type", comment: ""), for: .normal)
                            self.timeZoneID = ""
                            self.eventTypeId = ""
                            self.btnStartDate.setTitle("", for: .normal)
                            self.sDate = ""
                            self.btnEndDate.setTitle("", for: .normal)
                            self.eDate = ""
                            self.btnStartTime.setTitle("", for: .normal)
                            self.StartTime = ""
                            self.btnEndTime.setTitle("", for: .normal)
                            self.EndTime = ""
                            self.file = nil
                            self.fileName = ""
                            self.imgEvent.image = nil
                            self.img = nil
                            self.lat = ""
                            self.lang = ""
    let alert = UIAlertController(title: nil, message: NSLocalizedString("Event Updated Successfully", comment: ""), preferredStyle: UIAlertController.Style.alert)
                               
                               // add an action (button)
                               alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                               // show the alert
                               self.present(alert, animated: true, completion: nil)
                           }
                           
                       }
                    self.data_refresh?.refreshDataList(flagr: true)
                     view.removeFromSuperview()
                 self.myeventview?.isHidden = false
    if !(screenTitle.caseInsensitiveCompare("UPDATE EVENT DETAILS") == .orderedSame){
                     selectbutton = myeventbtn
                   neweventbutton!.setTitleColor(.gray, for: .normal)
                 myeventbtn!.setTitleColor(.black, for: .normal)
                    }
                   }else{
                       let alert = UIAlertController(title: nil, message: NSLocalizedString("File must be less then 2 MB.", comment: ""), preferredStyle: UIAlertController.Style.alert)
                       
                       // add an action (button)
                       alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                       
                       // show the alert
                       self.present(alert, animated: true, completion: nil)
                   }
       }
       
       //MARK:- VALIDATION IN ADD EVENT FORM
    
    func validate() -> Bool {
            if img != nil{
                let imageSize: Int = img!.count
                //print("actual size of image in KB: %f ", Double(imageSize)/1000.0 )
                let limit:Double = 2000.0
                if(Double(imageSize/1000) >= limit){
                        let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Image Should be less then 2 MB.", comment: ""), preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return false
                }
                
            }
            if(file != nil){
             let fileSize: Int = file!.count
            // //print("actual size of image in KB: %f ", Double(fileSize)/1000.0 )
                let FileLimit:Double = 2000.0
                if(Double(fileSize/1000) >= FileLimit){
                        let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("File Should be less then 2 MB.", comment: ""), preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return false
                }
            }
            if (self.sDate == "" )
                {
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Start Date not selected.", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
            if (self.eDate == "" )
                {
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("End Date not selected.", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
            if(self.txtfldEventName.text == ""){
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Event name not filled.", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
            }
            if(self.txtFldEventDescription.text == ""){
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Event Description not filled", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    return false;
                }
            if(self.eventTypeId == ""){
                    
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Event type not selected", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    return false;
                }
            if(self.timeZoneID == ""){
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Time zone not selected", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
            }
            if(self.txtFldAddress.text == ""){
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Address not filled", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
            if(self.txtFldCity.text == ""){
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("City not filled", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
            if(self.stateID == ""){
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("State not selected", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
            if(self.txtFldPostalcode.text == ""){
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Zip Code not filled", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
            if(self.countryID == ""){
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Country Not Selected", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
            if(self.txtFldEmail.text == ""){
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Email not filled", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
            if !(self.txtFldPostalcode.text?.count == 5 )
                        {
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Invalid Zip Code!", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                   alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                                   self.present(alert, animated: true, completion: nil)
                                   return false
                
            }
            if !(self.isValidPhoneNumber(text:self.txtFldPhone.text!)){
                    
                let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Invalid Phone Number", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false
                
            }
            if !(self.isValidUserName(text:self.txtFldEmail.text!)){
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Email Invalid!", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false
        }
            if(self.eDate == ""){
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("End Date not filled", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
            if(self.StartTime == ""){
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Start Time not filled", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                }
            if(self.EndTime == ""){
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("End Time not filled", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
                
            }
            if(self.txtFldPhone.text! == ""){
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Phone Number not filled", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false;
            }
            if self.check {
                    if (self.fileName == ""){
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("File Not Selected", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                   alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                                   self.present(alert, animated: true, completion: nil)
                                   return false
                    }
                }
            if eDate < sDate {
                    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString(" End Date should be greater than Start Date", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
            
                return true
    }
    func isValidUserName(text:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       // //print(emailRegEx)
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      //  //print(emailTest)
        return emailTest.evaluate(with: text)
    }
    
    func isValidPhoneNumber(text: String)-> Bool{
     
        if text.count == 13
        {
            return true
            
        }else{
           return false
        }
        return true
    }
    
    @IBAction func ResetbuttonPressed(_ sender: Any) {
        
       // Swift.//print("Reset button pressed")
        self.txtfldEventName.text = ""
        self.txtFldEmail.text = ""
        self.txtFldCity.text = ""
        self.txtFldPhone.text = ""
        self.txtFldEventDescription.text = ""
        self.txtFldAddress.text = ""
        self.txtFldPostalcode.text = ""
        self.img = nil
        self.imgName = ""
        self.file = nil
        self.fileName = ""
        self.imgEvent.image = nil
        self.lang = ""
        self.lat = ""
        
        
        
    }
}

extension CSOEventsViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let csoDasboardVC = viewController as? CSODashboardViewController {
            removeAllOtherViewsOfVC(viewcontroller: csoDasboardVC)
            return true
        }
        if let csoEventVC = viewController as? CSOEventsViewController {
            selectedButton = myEventsButton
            tableViewEventList.isHidden = false
            newEventButton.setTitleColor(.gray, for: .normal)
            myEventsButton.setTitleColor(.black, for: .normal)
            newEventLabl.isHidden = true
            myEventLabl.isHidden = false
            myEventsView.isHidden = false
           removeAllOtherViewsOfVC(viewcontroller: csoEventVC)
           

            return true
        }
        if let csoEventVC = viewController as? volunteerSeeFollowers {
            removeAllOtherViewsOfVC(viewcontroller: csoEventVC)
            return true
        }
        if let csoEventVC = viewController as? CSOMessagingViewController {
            removeAllOtherViewsOfVC(viewcontroller: csoEventVC)
            return true
        }
        if let csoEventVC = viewController as? LockerViewController {
            removeAllOtherViewsOfVC(viewcontroller: csoEventVC)
            return true
        }
        return true
    }
    
    
 
    

func removeAllOtherViewsOfVC(viewcontroller:UIViewController)  {
    
    for vc in viewcontroller.children {
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
}
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



