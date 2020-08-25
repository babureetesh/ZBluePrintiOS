//
//  VolRegistration.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 26/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolRegistration: UIViewController,UITextFieldDelegate {

      var ProfileSet:String?
    @IBOutlet weak var back_button: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var lblBasicInformation: UILabel!
    
    @IBOutlet weak var imageGender: UIImageView!
    
    @IBOutlet weak var imageCountry: UIImageView!
   
    @IBOutlet weak var imageState: UIImageView!
    
    @IBOutlet weak var viewSetProfile: UIView!
    @IBOutlet weak var lblZoeBlueprint: UILabel!
    @IBOutlet weak var volview: UIView!
    @IBOutlet weak var scroll_view: UIScrollView!
    
    @IBOutlet weak var volEmail: UITextField!
    
    @IBOutlet weak var volPassword: UITextField!
    
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var volFirstName: UITextField!
    
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblPrivate: UILabel!
    
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var btnPrivatePressed: UIButton!
    @IBOutlet weak var lblPublic: UILabel!
    @IBOutlet weak var lblSetProfile: UILabel!
    @IBOutlet weak var volLastName: UITextField!
    
    @IBOutlet weak var newCalender: UIImageView!
    
    @IBOutlet weak var btnPublicPressed: UIButton!
    @IBOutlet weak var volPhoneNumber: UITextField!
    
    @IBOutlet weak var volStreet: UITextField!
    
    @IBOutlet weak var volCity: UITextField!
    
    @IBOutlet weak var VolDOB: UIButton!
    var screen:String?
    @IBOutlet weak var volCountry: UIButton!
    @IBOutlet weak var volState: UIButton!
    var password_secure_eye:Bool?
    @IBOutlet weak var volZipCode: UITextField!
    
    @IBOutlet weak var VolGender: UIButton!
    var volDOB1:String?
    var user_gender:String?
    var user_countryID:String?
    var user_stateID:String?
    var user_status:String = ""
    var boolShowBackAlert = false
     
    
    @IBOutlet weak var volPasswordEyeButton: UIButton!
    @IBOutlet weak var volConfirmPassword: NSLayoutConstraint!
    
    @IBOutlet weak var volPasswordStack: NSLayoutConstraint!
    @IBOutlet weak var volconfirmPasswordEyeButton: UIButton!
    
    @IBOutlet weak var volconfirmpassword: UITextField!
    
    @IBOutlet weak var btnRegisterUpdate: UIButton!
    
    var Name : String!
    
    @IBOutlet weak var lblEditSetPro: UILabel!
    @IBOutlet weak var lblEditPrivate: UILabel!
    @IBOutlet weak var lblEditPublic: UILabel!
    
    @IBOutlet weak var btnEditPublicPressed: UIButton!
    
    @IBOutlet weak var btnEditPrivatePressed: UIButton!
    
    @IBOutlet weak var editbtnReset: UIButton!
    
    @IBOutlet weak var editbtnUpdate: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblEditSetPro.isHidden = true
        lblEditPublic.isHidden = true
        lblEditPrivate.isHidden = true
        btnEditPublicPressed.isHidden = true
        btnEditPrivatePressed.isHidden = true
        editbtnReset.isHidden = true
        editbtnUpdate.isHidden = true
        
    var bottomlLine = CALayer()
        bottomlLine.frame = CGRect(x:0.0,y:40.0,width:330.0,height:1.5)
       bottomlLine.backgroundColor = UIColor.black.cgColor
        volEmail.borderStyle = UITextField.BorderStyle.none
        volEmail.layer.addSublayer(bottomlLine)
        
        var bottomlLine2 = CALayer()
        bottomlLine2.frame = CGRect(x:0.0,y:40,width:155.0,height:1.5)
        bottomlLine2.backgroundColor = UIColor.black.cgColor
        volFirstName.borderStyle = UITextField.BorderStyle.none
        volFirstName.layer.addSublayer(bottomlLine2)
        
        var bottomlLine3 = CALayer()
        bottomlLine3.frame = CGRect(x:0.0,y:40,width:155.0,height:1.5)
        bottomlLine3.backgroundColor = UIColor.black.cgColor
        volLastName.borderStyle = UITextField.BorderStyle.none
        volLastName.layer.addSublayer(bottomlLine3)
        
        var bottomlLine4 = CALayer()
        bottomlLine4.frame = CGRect(x:0.0,y:40,width:155.0,height:1.5)
        bottomlLine4.backgroundColor = UIColor.black.cgColor
        volPhoneNumber.borderStyle = UITextField.BorderStyle.none
        volPhoneNumber.layer.addSublayer(bottomlLine4)
        
        var bottomlLine5 = CALayer()
        bottomlLine5.frame = CGRect(x:0.0,y:40,width:155.0,height:1.5)
        bottomlLine5.backgroundColor = UIColor.black.cgColor
        volStreet.borderStyle = UITextField.BorderStyle.none
        volStreet.layer.addSublayer(bottomlLine5)
        
        var bottomlLine6 = CALayer()
        bottomlLine6.frame = CGRect(x:0.0,y:40,width:330.0,height:1.5)
        bottomlLine6.backgroundColor = UIColor.black.cgColor
        volCity.borderStyle = UITextField.BorderStyle.none
        volCity.layer.addSublayer(bottomlLine6)
        
        var bottomlLine7 = CALayer()
        bottomlLine7.frame = CGRect(x:0.0,y:40,width:330.0,height:1.5)
        bottomlLine7.backgroundColor = UIColor.black.cgColor
        volZipCode.borderStyle = UITextField.BorderStyle.none
        volZipCode.layer.addSublayer(bottomlLine7)
        
        var bottomlLine8 = CALayer()
        bottomlLine8.frame = CGRect(x:0.0,y:40,width:330.0,height:1.5)
        bottomlLine8.backgroundColor = UIColor.black.cgColor
        volPassword.borderStyle = UITextField.BorderStyle.none
        volPassword.layer.addSublayer(bottomlLine8)
        
        
        var bottomlLine9 = CALayer()
        bottomlLine9.frame = CGRect(x:0.0,y:40,width:330.0,height:1.5)
        bottomlLine9.backgroundColor = UIColor.black.cgColor
        volconfirmpassword.borderStyle = UITextField.BorderStyle.none
        volconfirmpassword.layer.addSublayer(bottomlLine9)
        
        let lineView = UIView(frame: CGRect(x: 5.0, y: 58.0, width:325.0, height: 1.5))
        lineView.borderColor = UIColor.black
        lineView.backgroundColor = UIColor.black
        VolDOB.addSubview(lineView)
        
           volZipCode.delegate = self
        
       self.btnPrivatePressed.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        self.btnPublicPressed.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
//         self.ProfileSet = "10"

        
        
     scroll_view.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
        // Do any additional setup after loading the view.
        volPassword.isSecureTextEntry = true
        volconfirmpassword.isSecureTextEntry = true
        volEmail.delegate = self
        volFirstName.delegate = self
        volLastName.delegate = self
        volStreet.delegate = self
        volPhoneNumber.delegate = self
        volCity.delegate = self

        volPassword.delegate = self
        volconfirmpassword.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
       
//        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//
//        if defaults == "Dark Mode"{
//
//            DarkMode()
//        }else if defaults == "Light Mode"{
//
//            LightMode()
//
//
//        }
        
        
            if(self.screen == "EDIT VIEW"){
                boolShowBackAlert = true
                self.btnRegisterUpdate.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
                let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                let params = userIDData["user_id"] as! String
                let obj = ServiceHandlers()
                obj.editProfile(user_id: params){(responce,isSuccess) in
                    if isSuccess{
                         let data = responce as! Dictionary<String,Any>
                       // //print(data)
                        self.user_status = (data["vol_status"] as? String)!
                        self.volEmail.text = data["user_email"] as? String
                        self.volEmail.isEnabled = false
                        self.volEmail.textColor = .darkGray
                        self.volFirstName.text = data["user_f_name"] as? String
                        self.volLastName.text = data["user_l_name"] as? String
                        self.volStreet.text = data["user_address"] as? String
                        
              self.volPhoneNumber.text = self.formattedNumber(number:(data["user_phone"] as? String)!)
               self.volPhoneNumber.isEnabled = false
                        
                        self.volPhoneNumber.textColor = .darkGray
                        self.volCity.text = data["user_city"] as? String
                       
                        self.volZipCode.text = data["user_zipcode"] as? String
                        
                        self.volState.setTitle(data["user_state_name"] as? String, for: .normal)
                        self.user_stateID = data["user_state"] as? String
                        self.volCountry.setTitle((data["user_country_name"] as! String), for: .normal)
                        self.user_countryID = data["user_country"] as? String
                        self.VolDOB.setTitle(data["user_dob"] as? String, for: .normal)
                        self.volDOB1 = data["user_dob"] as? String
                        let strusergen = data["user_gender"] as? String
                        if strusergen == "M"{
                        self.VolGender.setTitle("Male", for: .normal)
                            self.user_gender = "M"
                        }
                        else if strusergen == "F" {
                          self.VolGender.setTitle("Female", for: .normal)
                            self.user_gender = "F"
                        }
                        else if strusergen == "O"{
                            self.VolGender.setTitle("Others", for: .normal)
                            self.user_gender = "O"
                            
                        }

                        
                        self.lblEditSetPro.isHidden = false
//                        self.lblEditPublic.isHidden = false
//                        self.lblEditPrivate.isHidden = false
//                        self.btnEditPublicPressed.isHidden = false
//                        self.btnEditPrivatePressed.isHidden = false
//                        self.editbtnReset.isHidden = false
//                        self.editbtnUpdate.isHidden = false
//
//                        self.resetButton.isHidden = true
//                        self.btnRegisterUpdate.isHidden = true
                        self.volPassword.isHidden = true
                        self.volPasswordEyeButton.isHidden = true
//
                        self.volconfirmpassword.isHidden = true
                        self.volconfirmPasswordEyeButton.isHidden = true

                        
                        
     self.ProfileSet = data["vol_status"] as? String
     print(self.ProfileSet)
                                                
       if (self.ProfileSet == "10"){

       self.btnPrivatePressed.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        self.btnPublicPressed.setImage(UIImage(named: "graycirclenew.png"), for: .normal)

         }else if (self.ProfileSet == "20"){

  self.btnPrivatePressed.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
  self.btnPublicPressed.setImage(UIImage(named: "checkedButton.png"), for: .normal)
                }

        }
                 }
           
      }else{
                self.user_countryID = "1"
                
      self.back_button.isHidden = false
            
        }
    }
    
    func DarkMode(){
        
        self.lblEditSetPro.textColor = .white
        self.lblZoeBlueprint.textColor = .white
        self.view.backgroundColor = .black
        self.volview.backgroundColor = .black
        self.volEmail.textColor = .white
volEmail.attributedPlaceholder = NSAttributedString(string: "Email",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
       
       self.volPassword.textColor = .white
        self.volconfirmpassword.textColor = .white
         volPassword.attributedPlaceholder = NSAttributedString(string: "Password",
         attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        volconfirmpassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
         
        lblState.textColor = UIColor.white
         self.volFirstName.textColor = .white
         volFirstName.attributedPlaceholder = NSAttributedString(string: "First Name",
         attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.volLastName.textColor = .white
volLastName.attributedPlaceholder = NSAttributedString(string: "Last Name",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        lblDOB.textColor = UIColor.white
        lblPrivate.textColor = UIColor.white
        lblGender.textColor = UIColor.white
    
        lblCountry.textColor = UIColor.white
     
        self.volPhoneNumber.textColor = .white
        volPhoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.volStreet.textColor = .white
        volStreet.attributedPlaceholder = NSAttributedString(string: "Street",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.volCity.textColor = .white
        volCity.attributedPlaceholder = NSAttributedString(string: "City",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.volZipCode.textColor = .white
        volZipCode.attributedPlaceholder = NSAttributedString(string: "Zip Code",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.VolDOB.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.VolGender.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.VolGender.borderColor = .white
        self.VolGender.backgroundColor = .black
        self.volCountry.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.volCountry.borderColor = .white
        self.volCountry.backgroundColor = .black
        self.volState.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.volState.borderColor = .white
//        self.volState.backgroundColor = .black
        
        self.viewSetProfile.backgroundColor = .black
        lblSetProfile.textColor = UIColor.white
        lblSetProfile.backgroundColor = .black
        lblPublic.textColor = UIColor.white
        lblPublic.backgroundColor = .black
        
        lblPrivate.backgroundColor = .black
        lblPrivate.textColor = UIColor.white
        
        self.imageState.image = UIImage(named: "whitedrop.png")
  
        newCalender.image = UIImage(named: "lightNewCalandar.png")
        
    self.imageCountry.image = UIImage(named: "whitedrop.png")
       
        if self.ProfileSet == "10" {
            self.btnPrivatePressed.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
        self.btnPublicPressed.setImage(UIImage(named: "lightGraycirclenew.png"), for: .normal)
       
        }else if self.ProfileSet == "20" {
            
            self.btnPrivatePressed.setImage(UIImage(named: "lightGraycirclenew.png"), for: .normal)
            self.btnPublicPressed.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
            
        }
    
//        self.imageState.image = UIImage(named:"whitedrop.png")
//        self.imageCountry.image = UIImage(named:"whitedrop.png")
//        self.imageGender.image = UIImage(named:"whitedrop.png")
//        
    
        
        
        var bottomlLine = CALayer()
        bottomlLine.frame = CGRect(x:0.0,y:40.0,width:330.0,height:1.5)
        bottomlLine.borderColor = UIColor.white.cgColor
        bottomlLine.backgroundColor = UIColor.white.cgColor
        volEmail.borderStyle = UITextField.BorderStyle.none
        volEmail.layer.addSublayer(bottomlLine)
        
        var bottomlLine2 = CALayer()
        bottomlLine2.frame = CGRect(x:0.0,y:40,width:155.0,height:1.5)
        bottomlLine2.borderColor = UIColor.white.cgColor
        bottomlLine2.backgroundColor = UIColor.white.cgColor
        volFirstName.borderStyle = UITextField.BorderStyle.none
        volFirstName.layer.addSublayer(bottomlLine2)
        
        var bottomlLine3 = CALayer()
        bottomlLine3.frame = CGRect(x:0.0,y:40,width:155.0,height:1.5)
        bottomlLine3.borderColor = UIColor.white.cgColor
        bottomlLine3.backgroundColor = UIColor.white.cgColor
        volLastName.borderStyle = UITextField.BorderStyle.none
        volLastName.layer.addSublayer(bottomlLine3)
        
        var bottomlLine4 = CALayer()
        bottomlLine4.frame = CGRect(x:0.0,y:40,width:155.0,height:1.5)
        bottomlLine4.borderColor = UIColor.white.cgColor
        bottomlLine4.backgroundColor = UIColor.white.cgColor
        volPhoneNumber.borderStyle = UITextField.BorderStyle.none
        volPhoneNumber.layer.addSublayer(bottomlLine4)
        
        var bottomlLine5 = CALayer()
        bottomlLine5.frame = CGRect(x:0.0,y:40,width:155.0,height:1.5)
        bottomlLine5.borderColor = UIColor.white.cgColor
        bottomlLine5.backgroundColor = UIColor.white.cgColor
        volStreet.borderStyle = UITextField.BorderStyle.none
        volStreet.layer.addSublayer(bottomlLine5)
        
        var bottomlLine6 = CALayer()
        bottomlLine6.frame = CGRect(x:0.0,y:40,width:330.0,height:1.5)
        bottomlLine6.borderColor = UIColor.white.cgColor
        bottomlLine6.backgroundColor = UIColor.white.cgColor
        volCity.borderStyle = UITextField.BorderStyle.none
        volCity.layer.addSublayer(bottomlLine6)
        
        var bottomlLine7 = CALayer()
        bottomlLine7.frame = CGRect(x:0.0,y:40,width:330.0,height:1.5)
        bottomlLine7.borderColor = UIColor.white.cgColor
        bottomlLine7.backgroundColor = UIColor.white.cgColor
        volZipCode.borderStyle = UITextField.BorderStyle.none
        volZipCode.layer.addSublayer(bottomlLine7)
        
        var bottomlLine8 = CALayer()
        bottomlLine8.frame = CGRect(x:0.0,y:40,width:330.0,height:1.5)
        bottomlLine8.borderColor = UIColor.white.cgColor
        bottomlLine8.backgroundColor = UIColor.white.cgColor
        volPassword.borderStyle = UITextField.BorderStyle.none
        volPassword.layer.addSublayer(bottomlLine8)
        
        
        var bottomlLine9 = CALayer()
        bottomlLine9.frame = CGRect(x:0.0,y:40,width:330.0,height:1.5)
        bottomlLine9.borderColor = UIColor.white.cgColor
        bottomlLine9.backgroundColor = UIColor.white.cgColor
        volconfirmpassword.borderStyle = UITextField.BorderStyle.none
        volconfirmpassword.layer.addSublayer(bottomlLine9)
        
        let lineView = UIView(frame: CGRect(x: 5.0, y: 58.0, width:325.0, height: 1.5))
        lineView.borderColor = UIColor.white
        lineView.backgroundColor = UIColor.white
        VolDOB.addSubview(lineView)
        
    }
    func LightMode(){
        
        
          self.lblZoeBlueprint.textColor = .black
        self.view.backgroundColor = .white
        self.volview.backgroundColor = .white
self.volEmail.textColor = .black
volEmail.attributedPlaceholder = NSAttributedString(string: "Email",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])

self.volPassword.textColor = .black
volPassword.attributedPlaceholder = NSAttributedString(string: "Password",
                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])

        lblState.textColor = UIColor.black

        self.volFirstName.textColor = .black
volFirstName.attributedPlaceholder = NSAttributedString(string: "First Name",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])

self.volLastName.textColor = .black
volLastName.attributedPlaceholder = NSAttributedString(string: "Last Name",
                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        lblDOB.textColor = UIColor.black
lblPrivate.textColor = UIColor.black
lblGender.textColor = UIColor.black

lblCountry.textColor = UIColor.black
self.btnPrivatePressed.setTitleColor(UIColor.black, for: UIControl.State.normal)
        lblPublic.textColor = UIColor.black
        lblSetProfile.textColor = UIColor.black

self.btnPublicPressed.setTitleColor(UIColor.black, for: UIControl.State.normal)
self.volPhoneNumber.textColor = .black
self.volStreet.textColor = .black
        self.volCity.textColor = .black
        self.volZipCode.textColor = .black
self.VolDOB.setTitleColor(UIColor.black, for: UIControl.State.normal)

self.volCountry.setTitleColor(UIColor.black, for: UIControl.State.normal)
self.volState.setTitleColor(UIColor.black, for: UIControl.State.normal)
 
//        self.imageState.image = UIImage(named:"drop.png")
//        self.imageCountry.image = UIImage(named:"drop.png")
//        self.imageGender.image = UIImage(named:"drop.png")
//
    }
    
    
    @IBAction func editPublic(_ sender: Any) {
      //  let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        //if defaults == "Light Mode"{
            self.btnPrivatePressed.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
            self.btnPublicPressed.setImage(UIImage(named: "checkedButton.png"), for: .normal)
            
        //}else if defaults == "Dark Mode" {
            
          //  self.btnPrivatePressed.setImage(UIImage(named: "lightGraycirclenew.png"), for: .normal)
           // self.btnPublicPressed.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
        //}
        
        self.ProfileSet = "20"
        print("Public clicked")
    }
    
    
    @IBAction func editPrivate(_ sender: Any) {
       // let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        //if defaults == "Light Mode"{
            self.btnPrivatePressed.setImage(UIImage(named: "checkedButton.png"), for: .normal)
            self.btnPublicPressed.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
            
        //}else if defaults == "Dark Mode"{
            
          //  self.btnPrivatePressed.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
           // self.btnPublicPressed.setImage(UIImage(named: "lightGraycirclenew.png"), for: .normal)
        //}
        self.ProfileSet = "10"
        print("Private clicked")
        
    }
    
    @IBAction func editReset(_ sender: Any) {
        
        if(self.screen == "EDIT VIEW"){
            
        }else{
            self.volEmail.text = ""
            self.volFirstName.text = ""
            self.volLastName.text = ""
            self.volPhoneNumber.text = ""
            self.volStreet.text = ""
            self.volCity.text = ""
            self.volState.setTitle("Select Sate", for: .normal)
            self.user_stateID = ""
            self.volZipCode.text = ""
            self.volCountry.setTitle("Select Country", for: .normal)
            self.user_countryID = "1"
            self.VolDOB.setTitle("Select Date Of Birth", for: .normal)
            self.volDOB1 = ""
            self.volPassword.text = ""
            self.volconfirmpassword.text = ""
            self.volPasswordEyeButton.setImage(UIImage(named: "eye-close2.png"), for: .normal)
            self.volconfirmPasswordEyeButton.setImage(UIImage(named: "eye-close2.png"), for: .normal)
        }
    }
    
    @IBAction func editUpdate(_ sender: Any) {
        
        if(self.screen == "EDIT VIEW"){
            if (validate2()){
                let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                let user_id = userIDData["user_id"] as! String
                
                
                var params2 = [
                    "user_id":user_id,
                    "user_type":"VOL",
                    "user_device":UIDevice.current.identifierForVendor!.uuidString,
                    "user_f_name":self.volFirstName.text as! String,
                    "user_l_name":self.volLastName.text as! String,
                    "user_country":self.user_countryID,
                    "user_state":self.user_stateID,
                    "user_city":self.volCity.text as! String,
                    "user_zipcode":self.volZipCode.text as! String,
                    "user_address": self.volStreet.text as! String,
                    "user_dob":self.volDOB1,
                    "user_gender":self.user_gender,
                    "phoneNumber":self.volPhoneNumber.text as! String,
                    "emailaddress":self.volEmail.text as! String,
                    "vol_status":self.user_status
                ]
                
                let servicehandler = ServiceHandlers()
                servicehandler.csoeditProfileStep1(data: params2){(responce,isSuccess) in
                    if isSuccess{
                        // goto dashboard
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }else{
                        
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("Error Occured! Please try Again!", comment: ""), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
                
            }
            
        }else{
            if (validate()){
                
                // //print(self.user_gender)
                let params = [
                    "user_type":"VOL",
                    "user_device":UIDevice.current.identifierForVendor!.uuidString,
                    "school_id":"",
                    "user_f_name":self.volFirstName.text as! String,
                    "user_l_name":self.volLastName.text as! String,
                    "user_email":self.volEmail.text as! String,
                    "user_phone":self.volPhoneNumber.text as! String,
                    "user_country":self.user_countryID,
                    "user_state":self.user_stateID,
                    "user_city":self.volCity.text as! String,
                    "user_zipcode":self.volZipCode.text as! String,
                    "user_address":self.volStreet.text as! String,
                    "user_dob":self.volDOB1,
                    "user_gender":self.user_gender,
                    "user_pass":self.volPassword.text as! String] as [String : Any]
                let serivehandlers = ServiceHandlers()
                serivehandlers.csoRegistrationStage1(data: params){(responce,isSuccess) in
                    if isSuccess {
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let phone_otp = sb.instantiateViewController(withIdentifier: "phoneotp") as! PhoneOtp
                        let data = responce as! Dictionary<String,Any>
                        phone_otp.phoneotp =  data["phone_otp"] as? String
                        phone_otp.user_id =  data["user_id"] as? String
                        phone_otp.user_type = "VOL"
                        self.present(phone_otp, animated: true)
                        
                    }else{
                        let msg = responce as? String
                        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                }
                
            }
        }
    }
    
    
    
    @IBAction func btnPrivate(_ sender: Any) {
       // let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        //if defaults == "Light Mode"{
        self.btnPrivatePressed.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        self.btnPublicPressed.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        
        //}else if defaults == "Dark Mode"{
            
          //  self.btnPrivatePressed.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
            //self.btnPublicPressed.setImage(UIImage(named: "lightGraycirclenew.png"), for: .normal)
        //}
         self.ProfileSet = "10"
       print("Private clicked")
        
    }
    
    @IBAction func btnPublic(_ sender: Any) {
      //  let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        //if defaults == "Light Mode"{
    self.btnPrivatePressed.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
    self.btnPublicPressed.setImage(UIImage(named: "checkedButton.png"), for: .normal)
      
        //}else if defaults == "Dark Mode" {
            
          //  self.btnPrivatePressed.setImage(UIImage(named: "lightGraycirclenew.png"), for: .normal)
            //self.btnPublicPressed.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
        //}
        
        self.ProfileSet = "20"
     print("Public clicked")
    }
    
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if (textField == self.volPhoneNumber){
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
    if(textField == volZipCode){
        
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
     func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(XXX) XXX-XXXX"
        
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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0
            {
                self.volview.frame.origin.y -= 82.0
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
    
    
    @IBAction func volPasswordEyeButtonFunction(_ sender: Any) {
        if(self.password_secure_eye == true){
             volPasswordEyeButton.setImage(UIImage(named: "eye-open.png"), for: .normal)
                 self.password_secure_eye = false
                 volPassword.isSecureTextEntry = false
             }else{
                 volPasswordEyeButton.setImage(UIImage(named: "eye-close2.png"), for: .normal)
                 self.password_secure_eye = true
                 volPassword.isSecureTextEntry = true
             }
    }
    
    @IBAction func volConfirmPasswordEyeButtonFunction(_ sender: Any) {
        if(self.password_secure_eye == true){
                    volconfirmPasswordEyeButton.setImage(UIImage(named: "eye-open.png"), for: .normal)
                        self.password_secure_eye = false
                        volconfirmpassword.isSecureTextEntry = false
                    }else{
                        volconfirmPasswordEyeButton.setImage(UIImage(named: "eye-close2.png"), for: .normal)
                        self.password_secure_eye = true
                        volconfirmpassword.isSecureTextEntry = true
                    }
    }
    
    @IBAction func volSelectGender(_ sender: Any) {
        let contents = ["Female","Male"]
                      showPopoverForView(view: sender, contents: contents)
    }
    
    
    @IBAction func volSelectCountry(_ sender: Any) {
        let utility = Utility()
        utility.fetchCountryList{ (eventTypeList, isValueFetched) in
            if let list = eventTypeList {
                self.showPopoverForView(view: sender, contents: list)
            }
        }
    }
    
    
    @IBAction func volSelectDateOfBirth(_ sender: Any) {
        view.endEditing(true)
        let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yyyy"
                   let date = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
                    let formatter = DateFormatter()
               formatter.dateFormat = "dd-MM-yyyy"
               let endDate = formatter.string(from: date)
               let edate = formatter.date(from: endDate)
               
               var dateComponent = DateComponents()
               let yearsToAdd = -200
               dateComponent.year = yearsToAdd
               let startDate = Calendar.current.date(byAdding: dateComponent, to: date)
                    
               
                    
               let dateSelectionPicker = DateSelectionViewController(startDate: startDate, endDate:  edate)
                    dateSelectionPicker.view.frame = self.view.frame
                    dateSelectionPicker.view.layoutIfNeeded()
                    dateSelectionPicker.captureSelectDateValue(sender, inMode: .date) { (selectedDate) in
                        let formatter = DateFormatter()
                        // formatter.dateFormat = "dd-MMM-yyyy"
                        formatter.dateFormat = "MM-dd-yyyy"
                        //08-22-2019
                        let dateString = formatter.string(from: selectedDate)
                        self.volDOB1 = dateString
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
    @IBAction func volSelectState(_ sender: Any) {
        let utility = Utility()
                          utility.fetchStateList{ (eventTypeList, isValueFetched) in
                              if let list = eventTypeList {
                                  self.showPopoverForView(view: sender, contents: list)
                              }
                          }
    }
    
    @IBAction func back_button_function(_ sender: Any) {
        
        if boolShowBackAlert{
        let alert = UIAlertController(title: NSLocalizedString("CONFIRM EXIT?", comment: ""), message: NSLocalizedString("Do you want to discard changes?", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("YES", comment: ""),
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
                                         self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func volReset(_ sender: Any) {
        if(self.screen == "EDIT VIEW"){
            
        }else{
        self.volEmail.text = ""
        self.volFirstName.text = ""
        self.volLastName.text = ""
        self.volPhoneNumber.text = ""
        self.volStreet.text = ""
        self.volCity.text = ""
        self.volState.setTitle("Select Sate", for: .normal)
        self.user_stateID = ""
        self.volZipCode.text = ""
        self.volCountry.setTitle("Select Country", for: .normal)
        self.user_countryID = "1"
        self.VolDOB.setTitle("Select Date Of Birth", for: .normal)
        self.volDOB1 = ""
        self.volPassword.text = ""
        self.volconfirmpassword.text = ""
        self.volPasswordEyeButton.setImage(UIImage(named: "eye-close2.png"), for: .normal)
        self.volconfirmPasswordEyeButton.setImage(UIImage(named: "eye-close2.png"), for: .normal)
        }
        
    }
    
    @IBAction func volSubmit(_ sender: Any) {
        if(self.screen == "EDIT VIEW"){
            if (validate2()){
                let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                let user_id = userIDData["user_id"] as! String
            
        
                var params2 = [
                    "user_id":user_id,
                    "user_type":"VOL",
                    "user_device":UIDevice.current.identifierForVendor!.uuidString,
                    "user_f_name":self.volFirstName.text as! String,
                    "user_l_name":self.volLastName.text as! String,
                    "user_country":self.user_countryID,
                    "user_state":self.user_stateID,
                    "user_city":self.volCity.text as! String,
                    "user_zipcode":self.volZipCode.text as! String,
                    "user_address": self.volStreet.text as! String,
                    "user_dob":self.volDOB1,
                    "user_gender":self.user_gender,
                    "phoneNumber":self.volPhoneNumber.text as! String,
                    "emailaddress":self.volEmail.text as! String,
                    "vol_status":self.user_status
                ]
                
                let servicehandler = ServiceHandlers()
                servicehandler.csoeditProfileStep1(data: params2){(responce,isSuccess) in
                    if isSuccess{
                       // goto dashboard
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }else{
                        
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("Error Occured! Please try Again!", comment: ""), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
                
            }
            
        }else{
        if (validate()){
            
           // //print(self.user_gender)
            let params = [
                    "user_type":"VOL",
                    "user_device":UIDevice.current.identifierForVendor!.uuidString,
                    "school_id":"",
                    "user_f_name":self.volFirstName.text as! String,
                    "user_l_name":self.volLastName.text as! String,
                    "user_email":self.volEmail.text as! String,
                    "user_phone":self.volPhoneNumber.text as! String,
                    "user_country":self.user_countryID,
                    "user_state":self.user_stateID,
                    "user_city":self.volCity.text as! String,
                    "user_zipcode":self.volZipCode.text as! String,
                    "user_address":self.volStreet.text as! String,
                    "user_dob":self.volDOB1,
                    "user_gender":self.user_gender,
                    "user_pass":self.volPassword.text as! String] as [String : Any]
                let serivehandlers = ServiceHandlers()
                serivehandlers.csoRegistrationStage1(data: params){(responce,isSuccess) in
                    if isSuccess {
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let phone_otp = sb.instantiateViewController(withIdentifier: "phoneotp") as! PhoneOtp
                       let data = responce as! Dictionary<String,Any>
                        phone_otp.phoneotp =  data["phone_otp"] as? String
                        phone_otp.user_id =  data["user_id"] as? String
                        phone_otp.user_type = "VOL"
                        self.present(phone_otp, animated: true)
                        
                    }else{
                        let msg = responce as? String
                        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                }
                
            }
        }
    }
    func isValidUserName(text:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluate(with: text))
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
    
    func validate() -> Bool {
        if(self.volEmail.text == ""){
            
            let alert = UIAlertController(title: nil, message:NSLocalizedString("Email Is Empty", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }else if !(self.isValidUserName(text: self.volEmail.text!) ){
        
        let alert = UIAlertController(title: nil, message:NSLocalizedString("Email Invalid!", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true)
            return false
            
        }else if(self.volFirstName.text == ""){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("First Name Is Empty", comment: ""), preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                      self.present(alert, animated: true)
                      return false
        }else if(self.volLastName.text == ""){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("Last Name Is Empty", comment: ""), preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                      self.present(alert, animated: true)
                      return false
        }else if(self.volPhoneNumber.text == ""){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("Phone Number Is Empty", comment: ""), preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                      self.present(alert, animated: true)
                      return false
        }else if !(self.isValidPhoneNumber(text:self.volPhoneNumber.text!)){
                               
                           let alert = UIAlertController(title: nil, message: NSLocalizedString("Invalid Phone Number", comment: ""), preferredStyle: UIAlertController.Style.alert)
                               alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                               self.present(alert, animated: true, completion: nil)
                               return false
                           
                       }
//        else if(self.volZipCode.text == ""){
//        let alert = UIAlertController(title: nil, message: "ZipCode is Empty", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
//        present(alert, animated: true)
//         return false
//         }
    else if(self.volDOB1 == ""){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("Date Of Birth Is Empty", comment: ""), preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                      self.present(alert, animated: true)
                      return false
        }else if (datefromString(strDate: self.volDOB1!).timeIntervalSinceNow.sign == .plus) {
            // date is in future
            let alert = UIAlertController(title: nil, message:"Date of birth is not valid", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        else if(self.volPassword.text == ""){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("Password Is Empty", comment: ""), preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                      self.present(alert, animated: true)
                      return false
        }else if(self.volconfirmpassword.text == ""){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("Confirm Password Is Empty", comment: ""), preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                      self.present(alert, animated: true)
                      return false
        }else if !(self.volconfirmpassword.text == self.volPassword.text){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("Confirm Password And Password Not Same", comment: ""), preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                      self.present(alert, animated: true)
                      return false
//        }else if(self.user_stateID == nil){
//            let alert = UIAlertController(title: nil, message: "State not selected", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
//            present(alert, animated: true)
//            return false
//        }
        } else if(self.user_countryID == nil){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Country Not Selected", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }else if(self.user_gender == "" || self.user_gender == nil){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Gender not selected", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }
        return true
    }
    func datefromString(strDate: String)->Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateToCheck = dateFormatter.date(from: strDate)!
        return dateToCheck
    }
    func validate2() -> Bool {
       if(self.volFirstName.text == ""){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("First Name Is Empty", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }else if(self.volLastName.text == ""){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("Last Name Is Empty", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }else if(self.volDOB1 == ""){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("Date Of Birth Is Empty", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert, animated: true)
            return false

       }
        else if(self.user_gender == "" || self.user_gender == nil){
        let alert = UIAlertController(title: nil, message: NSLocalizedString("Gender not selected", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        present(alert, animated: true)
        return false
       }
       else if(self.user_countryID == nil){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Country Not Selected", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }
        return true
    }
    
    fileprivate func showPopoverForView(view:Any, contents:Any) {
        let controller = DropDownItemsTable(contents)
        let senderButton = view as! UIButton
        controller.showPopoverInDestinationVC(destination: self, sourceView: view as! UIView) { (selectedValue) in
            if let selectVal = selectedValue as? String {
                self.user_gender = String(selectVal.prefix(1))
                senderButton.setTitle(selectVal, for: .normal)
                senderButton.setImage(nil, for: .normal)
            } else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetCountryServiceStrings.keyCountryName] as? String {
                self.user_countryID = selectVal[GetCountryServiceStrings.keyCountryId] as! String
                senderButton.setTitle(title, for: .normal)
                senderButton.setImage(nil, for: .normal)
            }  else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetStateServiceStrings.keyStateName] as? String {
                self.user_stateID = selectVal[GetStateServiceStrings.keyStateId] as! String
                senderButton.setTitle(title, for: .normal)
                senderButton.setImage(nil, for: .normal)
            }
                    
            
        }
    }
}
