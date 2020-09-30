//
//  CSORegistration.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 14/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import Alamofire
import MobileCoreServices
class CSORegistration: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate,UITextFieldDelegate,XMLParserDelegate, UITableViewDataSource,UITableViewDelegate,csoregistrationdeletebutton{
   
    @IBOutlet weak var imageCal: UIImageView!
    @IBOutlet weak var lblStage3Q1: UILabel!
    @IBOutlet weak var lblYesQ1: UILabel!
    @IBOutlet weak var lblNoQ1: UILabel!
    
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var imagedrop3: UIImageView!
    @IBOutlet weak var imagedrop1: UIImageView!
    @IBOutlet weak var lblStage3Q2: UILabel!
    @IBOutlet weak var lblStage3Q3: UILabel!
    @IBOutlet weak var lblStage3Q4: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    
    
    @IBOutlet weak var imageStage3drop1: UIImageView!
    @IBOutlet weak var imageStage3drop2: UIImageView!
    @IBOutlet weak var imageStage3drop3: UIImageView!
    
    
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var imageStage2drop3: UIImageView!
    @IBOutlet weak var imageStage2drop2: UIImageView!
    @IBOutlet weak var lblZoe: UILabel!
    @IBOutlet weak var imagedrop2: UIImageView!
    @IBOutlet weak var lblStage3Q5: UILabel!
    @IBOutlet weak var lblYesQ5: UILabel!
    @IBOutlet weak var lblNoQ5: UILabel!
    @IBOutlet weak var imageStage2dropdown: UIImageView!
    
    @IBOutlet weak var lblStateStage2: UILabel!
    @IBOutlet weak var lblCountryStage2: UILabel!
    
    @IBOutlet weak var lblStage3Q6: UILabel!
    @IBOutlet weak var lblYesQ6: UILabel!
    
    @IBOutlet weak var lblNoQ6: UILabel!
    
    
    @IBOutlet weak var lblStage3Q7: UILabel!
    @IBOutlet weak var lblYesQ7: UILabel!
    
    @IBOutlet weak var lblNoQ7: UILabel!
    
    var boolShowBackAlert = false
    @IBOutlet weak var lblStagesInformation: UILabel!
    
    @IBOutlet weak var imgStep3: UIImageView!
    @IBOutlet weak var imgStep2: UIImageView!
    @IBOutlet weak var imageStep1: UIImageView!
    
    @IBOutlet weak var btnbakPressed: UIButton!
    
    @IBOutlet weak var Stage3Update: UIButton!
    
    @IBOutlet weak var Stage2SubmitButton: UIButton!
    
    @IBOutlet weak var Stage1SubmitNextButton: UIButton!
    
    @IBOutlet weak var stage2lbnUploadFile: UILabel!
    @IBOutlet weak var stage1view: UIView!
    
    @IBOutlet weak var stage2view: UIView!
    
    @IBOutlet weak var stage1GenderButton: UIButton!
    
    @IBOutlet weak var stage1userCountryButton: UIButton!
    @IBOutlet weak var stage1UserStateButton: UIButton!
    @IBOutlet weak var stage3view: UIView!
    
    
    @IBOutlet weak var stage1email: UITextField!
    
    @IBOutlet weak var stage1firstName: UITextField!
    
    @IBOutlet weak var stage1lastName: UITextField!
    
    @IBOutlet weak var stage1phoneNumber: UITextField!
    
    @IBOutlet weak var stage1street: UITextField!
    
    @IBOutlet weak var stage1city: UITextField!
    
  
    @IBOutlet weak var stage2SelectDocumentButton: UIButton!
    
    
    
    @IBOutlet weak var scrollerView: UIScrollView!
    
     @IBOutlet weak var stage2ScrollView: UIScrollView!
    
     @IBOutlet weak var stage3ScrollView: UIScrollView!
    
    @IBOutlet weak var stage1zipCode: UITextField!
    
    @IBOutlet weak var stage1DateOfBirth: UIButton!
    
   
    
    @IBOutlet weak var stage1password: UITextField!
    
    @IBOutlet weak var stage1Passwordeyebutton: UIButton!
    
    @IBOutlet weak var stage1confirmPassword: UITextField!
    
    @IBOutlet weak var stage1confirmpasswordeyeButton: UIButton!
    
    var user_gender:String?
    var user_countryID:String?
    var user_stateID:String?
    var user_id:String?
    var documentID:String?
    var step2doc:Data?
    var step2fileName:String?
    var numberOfDocument:Int = 0
    var stage3OrgProfit:String?
    var stage3BackgroundCheck:String?
    var stage3PublicTransport:String?
    var stage3Certificate:String?
    var quesData:Dictionary<String,Any>?
    var phone_otp:String?
    var documentName:String?
    var document_detail_list:Array<Any>?
    var screen:String?
    var password_secure_eye:Bool?
    var confirm_secure_eye:Bool?
    var stage1DOB:String?
    var data_edit_profile_details:Dictionary<String,Any>!
    var loadStage:String?
    var regStage1data:Dictionary<String,Any>?
    var regStage2data:Dictionary<String,Any>?
    var documentUploaded = Array<Any> ()

    
    @IBOutlet weak var stage2uploadfilebuttons: UIStackView!
    
      @IBOutlet weak var stage1MainStackView: UIStackView!
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var confirmPasswordStackView: UIStackView!
    
    @IBOutlet weak var stage2uploadbuttons: UIStackView!
    
    
    @IBOutlet weak var stage2OrgName: UITextField!
    
    
    @IBOutlet weak var stage2OrgPhone: UITextField!
    
    
    @IBOutlet weak var stage2OrgEmail: UITextField!
    
    @IBOutlet weak var stage2OrgWebsite: UITextField!
    
    @IBOutlet weak var stage2OrgMission: UITextField!
    
    @IBOutlet weak var stage2OrgCause: UITextField!
    
    @IBOutlet weak var stage2OrgProfile: UITextField!
    
    @IBOutlet weak var stage2OrgStreet: UITextField!
    
    @IBOutlet weak var stage2OrgCity: UITextField!
    
    
    @IBOutlet weak var stage2OrgZipCode: UITextField!
    
    @IBOutlet weak var stage2OrgTaxEIN: UITextField!
    
    
    @IBOutlet weak var stage2SelectStateButton: UIButton!
    
    
    @IBOutlet weak var stage2SelectCountryButton: UIButton!
    
    @IBOutlet weak var stage3OrgProfitYesButton: UIButton!
    
    
    @IBOutlet weak var stage3OrgProfitNoButton: UIButton!
    
    
    @IBOutlet weak var stage3ServiceOfferButton: UIButton!
    
    @IBOutlet weak var stage3TargetClientGroupButton: UIButton!
    
    
    @IBOutlet weak var stage3TotalVolButton: UIButton!
    
    
    @IBOutlet weak var stage3VolBackgroundCheckYesButton: UIButton!
    
    
    @IBOutlet weak var stage3VolBackgroundCheckNoButton: UIButton!
    
    @IBOutlet weak var stage3PublicTransportYesButton: UIButton!
    
    @IBOutlet weak var stage3PublicTransportNoButton: UIButton!
    
    @IBOutlet weak var stage3Certificate501C3YesButton: UIButton!
    
    @IBOutlet weak var stage3Certificate501C3NoButton: UIButton!
    
    @IBOutlet weak var stage2DocumentListView: UIView!
    
    @IBOutlet weak var stage1DOBView: UIView!
    
    @IBOutlet weak var stage2DocumentListBackgroundView: UIView!
   @IBOutlet weak var stage2documentListTableView: UITableView!
    
    var step2bottomLine1 = CALayer()
    var step2bottomLine2 = CALayer()
    var step2bottomLine3 = CALayer()
    var step2bottomLine4 = CALayer()
    var step2bottomLine5 = CALayer()
    var step2bottomLine6 = CALayer()
    var step2bottomLine8 = CALayer()
     var step2bottomLine9 = CALayer()
    var step2bottomLine10 = CALayer()
    var step2bottomLine11 = CALayer()
    var step2bottomLine12 = CALayer()
    
    struct Connectivity {
        static let sharedInstance = NetworkReachabilityManager()!
        static var isConnectedToInternet:Bool {
            return self.sharedInstance.isReachable
        }
    }
    
    override func viewDidLayoutSubviews() {
//        stage2OrgPhone.setUnderLine()
         addUnderLineToField(color: .black)
        stage1GenderButton.setDropDownImagWithInset()
        stage1UserStateButton.setDropDownImagWithInset()
        stage1userCountryButton.setDropDownImagWithInset()
        stage2SelectStateButton.setDropDownImagWithInset()
        stage2SelectCountryButton.setDropDownImagWithInset()
        stage2SelectDocumentButton.setDropDownImagWithInset()
        stage3ServiceOfferButton.setDropDownImagWithInset()
        stage3TargetClientGroupButton.setDropDownImagWithInset()
        stage3TotalVolButton.setDropDownImagWithInset()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        stage2ScrollView.isHidden = true
        stage3ScrollView.isHidden = true
        // Do any additional setup after loading the view.
        
//        addUnderLineToField(color: .black)
        
       btnbakPressed.isHidden = false
       
       self.stage2view.isHidden = true
       self.stage3view.isHidden = true
        //self.stage2DocumentListView.isHidden = true
        
//        stage3ScrollView.isHidden = false // to comment
//        self.stage3view.isHidden = false // to comment
        
        
        
        self.password_secure_eye = true
        self.confirm_secure_eye = true
        self.stage1password.isSecureTextEntry = true
        self.stage1confirmPassword.isSecureTextEntry = true
            self.stage3OrgProfit = "1"
            self.stage3BackgroundCheck = "1"
            self.stage3PublicTransport = "1"
            self.stage3Certificate = "1"
        stage1email.delegate = self
        stage1firstName.delegate = self
        stage1lastName.delegate = self
        stage1city.delegate = self
        stage1phoneNumber.delegate = self
        stage1street.delegate = self
        stage1zipCode.delegate = self
        stage1password.delegate = self
        stage2OrgName.delegate = self
        stage2OrgPhone.delegate = self
        stage2OrgEmail.delegate = self
        stage2OrgWebsite.delegate = self
        stage2OrgEmail.delegate = self
        stage2OrgMission.delegate = self
        stage2OrgCause.delegate = self
        stage2OrgMission.delegate = self
        stage2OrgProfile.delegate = self
        stage2OrgCity.delegate = self
        stage2OrgStreet.delegate = self
        stage2OrgZipCode.delegate = self
        stage2OrgTaxEIN.delegate = self
        stage1confirmPassword.delegate = self
       
        let tap_doc = UITapGestureRecognizer(target: self, action: #selector(backgroundview))
        tap_doc.numberOfTapsRequired = 1
        stage2DocumentListBackgroundView.addGestureRecognizer(tap_doc)
        stage2DocumentListBackgroundView.isUserInteractionEnabled = true
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        
       // stage1DateOfBirth.setUnderLineForView()
        
    }
  @objc func keyboardWillShow(notification: NSNotification) {
         if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
             if self.view.frame.origin.y == 0
             {
                  self.stage1view.frame.origin.y -= 80.0
                  self.stage2view.frame.origin.y -= 80.0
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
@objc func backgroundview(){
        
        self.view.sendSubviewToBack(stage2DocumentListBackgroundView)
        self.stage2DocumentListBackgroundView.isHidden = true
       
    }
    override func viewDidAppear(_ animated: Bool) {
           super .viewDidAppear(true)
        if self.user_id != nil {
           let servicehandler = ServiceHandlers()
                           servicehandler.lockerList(user_id:self.user_id!){(responce,isSuccess) in
                               if isSuccess{
                                self.document_detail_list = (responce as! Array<Any>)
                                   for docs in self.document_detail_list! {
                                       let dicData = docs as! [String:Any]
                                       let strDocName = dicData["document_name"] as! String
                                       print(strDocName)
                                       self.documentUploaded.append(strDocName)
                                       print("Array \( self.documentUploaded)")
                                   }
                                  
                            }
            }
            
        }
           
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stage1UserStateButton.setTitle("Select State", for: .normal)
        
       /* let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode"{
            
            lblZoe.textColor = .white
            lblZoe.backgroundColor = .black
            btnbakPressed.setImage(UIImage(named: "iphoneButton.png"), for: UIControl.State.normal)
            
            DarkMode()
            
        }else if defaults == "Light Mode"{
            
            lblZoe.textColor = .black
            lblZoe.backgroundColor = .white
            
             btnbakPressed.setImage(UIImage(named: "iphoneBackButton.png"), for: UIControl.State.normal)
            LightMode()
        }*/
        
        if(self.screen == "EDIT VIEW"){
            boolShowBackAlert = true
                let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                let params = userIDData["user_id"] as! String
                let obj = ServiceHandlers()
                obj.editProfile(user_id: params){(responce,isSuccess) in
                    if isSuccess{
                        
                        self.btnbakPressed.isHidden = false
            self.data_edit_profile_details = responce as! Dictionary<String,Any>
                        print(self.data_edit_profile_details)
            self.stage1email.text = self.data_edit_profile_details!["user_email"] as! String
                        self.stage1email.isEnabled = false
            self.stage1firstName.text =  self.data_edit_profile_details!["user_f_name"] as! String
            self.stage1lastName.text = self.data_edit_profile_details!["user_l_name"] as! String
                        
        self.stage1phoneNumber.text = self.formattedNumber(number:(self.data_edit_profile_details!["user_phone"] as? String)!)
     self.stage1phoneNumber.isEnabled = false
                        
        self.stage1street.text = self.data_edit_profile_details!["user_address"] as! String
        self.stage1city.text = self.data_edit_profile_details!["user_city"] as! String
        self.user_stateID = self.data_edit_profile_details!["user_state"] as! String
        
    self.stage1UserStateButton.setTitle(self.data_edit_profile_details!["user_state_name"] as! String, for: .normal)
   self.stage1userCountryButton.setTitle(self.data_edit_profile_details!["user_country_name"] as! String, for: .normal)
                        
       self.user_countryID = self.data_edit_profile_details!["user_country"] as! String
       self.user_gender = self.data_edit_profile_details!["user_gender"] as! String
       switch self.data_edit_profile_details!["user_gender"] as! String {
                        case "M":
                            self.stage1GenderButton.setTitle("Male", for: .normal)
                        case "F":
                            self.stage1GenderButton.setTitle("Female", for: .normal)
                        default:
                            self.stage1GenderButton.setTitle("Select Gender ", for: .normal)
                }
        self.stage1zipCode.text = self.data_edit_profile_details!["user_zipcode"] as! String
        self.stage1DateOfBirth.setTitle(self.data_edit_profile_details!["user_dob"] as! String, for: .normal)
        self.stage1DOB = self.data_edit_profile_details!["user_dob"] as! String
                        
         
         self.Stage1SubmitNextButton.setTitle(NSLocalizedString("Update", comment: ""), for: UIControl.State.normal)
         self.Stage2SubmitButton.setTitle(NSLocalizedString("Update", comment: ""), for: UIControl.State.normal)
         self.Stage3Update.setTitle(NSLocalizedString("Update", comment: ""), for: UIControl.State.normal)

 
                        self.stage1MainStackView.removeArrangedSubview(self.passwordStackView)
                        self.stage1MainStackView.removeArrangedSubview(self.confirmPasswordStackView)
                        
          self.stage1password.isHidden = true
           self.stage1confirmPassword.isHidden = true
            self.stage1confirmpasswordeyeButton.isHidden = true
            self.stage1Passwordeyebutton.isHidden = true
                        
                }
            }
            
            //var step2bottomLine1 = CALayer()
                   step2bottomLine1.frame = CGRect(x: 0.0, y:35.0, width: 355.0, height: 1.0)
//                   step2bottomLine1.backgroundColor = UIColor.black.cgColor
//                   stage2OrgName.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgName.layer.addSublayer(step2bottomLine1)
//                   
              //     var step2bottomLine2 = CALayer()
                   step2bottomLine2.frame = CGRect(x:0.0,y:35.0,width:355.0,height:1.5)
//                   step2bottomLine2.backgroundColor = UIColor.black.cgColor
//                   stage2OrgPhone.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgPhone.layer.addSublayer(step2bottomLine2)
                   
                //   var step2bottomLine3 = CALayer()
                   step2bottomLine3.frame = CGRect(x:0.0,y:35.0,width:355.0,height:1.5)
//                   step2bottomLine3.backgroundColor = UIColor.black.cgColor
//                   stage2OrgEmail.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgEmail.layer.addSublayer(step2bottomLine3)
                   
                  // var step2bottomLine4 = CALayer()
                   step2bottomLine4.frame = CGRect(x:0.0,y:35.0,width:355.0,height:1.5)
//                   step2bottomLine4.backgroundColor = UIColor.black.cgColor
//                   stage2OrgWebsite.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgWebsite.layer.addSublayer(step2bottomLine4)
                   
                 //  var step2bottomLine5 = CALayer()
                   step2bottomLine5.frame = CGRect(x:0.0,y:35.0,width:355.0,height:1.5)
//                   step2bottomLine5.backgroundColor = UIColor.black.cgColor
//                   stage2OrgMission.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgMission.layer.addSublayer(step2bottomLine5)
                   
                   //var step2bottomLine6 = CALayer()
                   step2bottomLine6.frame = CGRect(x:0.0,y:35.0,width:355.0,height:1.5)
//                   step2bottomLine6.backgroundColor = UIColor.black.cgColor
//                   stage2OrgCause.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgCause.layer.addSublayer(step2bottomLine6)
                   
                   //var step2bottomLine8 = CALayer()
                   step2bottomLine8.frame = CGRect(x:0.0,y:35.0,width:355.0,height:1.5)
//                   step2bottomLine8.backgroundColor = UIColor.black.cgColor
//                   stage2OrgProfile.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgProfile.layer.addSublayer(step2bottomLine8)
                   
                   //var step2bottomLine9 = CALayer()
                   step2bottomLine9.frame = CGRect(x:0.0,y:35.0,width:355.0,height:1.5)
//                   step2bottomLine9.backgroundColor = UIColor.black.cgColor
//                   stage2OrgStreet.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgStreet.layer.addSublayer(step2bottomLine9)
                   
                   //var step2bottomLine10 = CALayer()
                   step2bottomLine10.frame = CGRect(x:0.0,y:35.0,width:355.0,height:1.5)
//                   step2bottomLine10.backgroundColor = UIColor.black.cgColor
//                   stage2OrgCity.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgCity.layer.addSublayer(step2bottomLine10)
                   
                  // var step2bottomLine11 = CALayer()
                   step2bottomLine11.frame = CGRect(x:0.0,y:35.0,width:355.0,height:1.5)
//                   step2bottomLine11.backgroundColor = UIColor.black.cgColor
//                   stage2OrgZipCode.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgZipCode.layer.addSublayer(step2bottomLine11)
                   
                   //var step2bottomLine12 = CALayer()
                   step2bottomLine12.frame = CGRect(x:0.0,y:35.0,width:355.0,height:1.5)
//                   step2bottomLine12.backgroundColor = UIColor.black.cgColor
//                   stage2OrgTaxEIN.borderStyle = UITextField.BorderStyle.none
//                   stage2OrgTaxEIN.layer.addSublayer(step2bottomLine12)
            
         }else{
            
            self.user_countryID = "1"
            self.stage1UserStateButton.setTitle(NSLocalizedString("Select State", comment: ""), for: .normal)
        }
        if (self.loadStage == "1"){
            boolShowBackAlert = true
                   self.setupforSecondStage()
                   
            
               }else if (self.loadStage == "2"){
            
            boolShowBackAlert = true
                   self.setupforThirdStage()
                   
               }
        self.scrollerView.contentSize = CGSize(width: 375, height: 900)
    }
    func DarkMode() {

        self.view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.stage1email.textColor = .white
        self.stage1view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
stage1email.attributedPlaceholder = NSAttributedString(string: "Email",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1firstName.textColor = .white
stage1firstName.attributedPlaceholder = NSAttributedString(string: "First Name",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1lastName.textColor = .white
stage1lastName.attributedPlaceholder = NSAttributedString(string: "Last Name",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1phoneNumber.textColor = .white
stage1phoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1street.textColor = .white
stage1street.attributedPlaceholder = NSAttributedString(string: "Street",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1city.textColor = .white
stage1city.attributedPlaceholder = NSAttributedString(string: "City",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1zipCode.textColor = .white
stage1zipCode.attributedPlaceholder = NSAttributedString(string: "Zipcode",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
//        self.stage1password.textColor = .white
//stage1password.attributedPlaceholder = NSAttributedString(string: "Password",
//attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1confirmPassword.textColor = .white
stage1confirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.stage1DateOfBirth.setTitleColor(UIColor.white, for: UIControl.State.normal)
    
        
        self.stage1UserStateButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.stage1UserStateButton.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.stage1UserStateButton.borderColor = .white
        self.imagedrop1.image = UIImage(named: "whitedrop.png")
        self.lblState.textColor = .white
        self.lblState.backgroundColor = .black
        
        self.stage1userCountryButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.stage1userCountryButton.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.stage1userCountryButton.borderColor = .white
        self.imagedrop2.image = UIImage(named: "whitedrop.png")
        self.lblCountry.textColor = .white
        self.lblCountry.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        
        self.stage1GenderButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.stage1GenderButton.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.stage1GenderButton.borderColor = .white
        self.imagedrop3.image = UIImage(named: "whitedrop.png")
        self.lblGender.textColor = .white
        self.lblGender.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        
        self.stage1password.textColor = .white
        stage1password.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        lblDOB.backgroundColor = .white
        imageCal.image = UIImage(named: "lightNewCalandar.png")
        
        
        var bottomlLine = CALayer()
        bottomlLine.frame = CGRect(x:0.0,y:40.0,width:345.0,height:1.5)
        bottomlLine.backgroundColor = UIColor.white.cgColor
        stage1email.borderStyle = UITextField.BorderStyle.none
        stage1email.layer.addSublayer(bottomlLine)
        
        var bottomlLine2 = CALayer()
        bottomlLine2.frame = CGRect(x:0.0,y:40,width:150.0,height:1.5)
        bottomlLine2.backgroundColor = UIColor.white.cgColor
        stage1firstName.borderStyle = UITextField.BorderStyle.none
        stage1firstName.layer.addSublayer(bottomlLine2)
        
        var bottomlLine3 = CALayer()
        bottomlLine3.frame = CGRect(x:0.0,y:40,width:160.0,height:1.5)
        bottomlLine3.backgroundColor = UIColor.white.cgColor
        stage1lastName.borderStyle = UITextField.BorderStyle.none
        stage1lastName.layer.addSublayer(bottomlLine3)
        
        var bottomlLine4 = CALayer()
        bottomlLine4.frame = CGRect(x:0.0,y:40,width:150.0,height:1.5)
        bottomlLine4.backgroundColor = UIColor.white.cgColor
        stage1phoneNumber.borderStyle = UITextField.BorderStyle.none
        stage1phoneNumber.layer.addSublayer(bottomlLine4)
        
        var bottomlLine5 = CALayer()
        bottomlLine5.frame = CGRect(x:0.0,y:40,width:160.0,height:1.5)
        bottomlLine5.backgroundColor = UIColor.white.cgColor
        stage1street.borderStyle = UITextField.BorderStyle.none
        stage1street.layer.addSublayer(bottomlLine5)
        
        var bottomlLine6 = CALayer()
        bottomlLine6.frame = CGRect(x:0.0,y:40,width:343.0,height:1.5)
        bottomlLine6.backgroundColor = UIColor.white.cgColor
        stage1city.borderStyle = UITextField.BorderStyle.none
        stage1city.layer.addSublayer(bottomlLine6)
        
        var bottomlLine7 = CALayer()
        bottomlLine7.frame = CGRect(x:0.0,y:40,width:343.0,height:1.5)
        bottomlLine7.backgroundColor = UIColor.white.cgColor
        stage1zipCode.borderStyle = UITextField.BorderStyle.none
        stage1zipCode.layer.addSublayer(bottomlLine7)
        
        var bottomlLine8 = CALayer()
        bottomlLine8.frame = CGRect(x:0.0,y:40,width:343.0,height:1.5)
        bottomlLine8.backgroundColor = UIColor.white.cgColor
        stage1password.borderStyle = UITextField.BorderStyle.none
        stage1password.layer.addSublayer(bottomlLine8)
        stage1Passwordeyebutton.frame = CGRect(x: 348, y: 0, width: 20, height: 40)
        
        var bottomlLine9 = CALayer()
        bottomlLine9.frame = CGRect(x:0.0,y:40,width:343.0,height:1.5)
        bottomlLine9.backgroundColor = UIColor.white.cgColor
        stage1confirmPassword.borderStyle = UITextField.BorderStyle.none
        stage1confirmPassword.layer.addSublayer(bottomlLine9)
        stage1confirmpasswordeyeButton.frame = CGRect(x: 348, y: 0, width: 20, height: 40)
        
        
        
        //Step 2
        
        
        var step2bottomLine1 = CALayer()
        step2bottomLine1.frame = CGRect(x: 0.0, y:30.0, width: 355.0, height: 1.5)
        step2bottomLine1.backgroundColor = UIColor.white.cgColor
        stage2OrgName.borderStyle = UITextField.BorderStyle.none
        stage2OrgName.layer.addSublayer(step2bottomLine1)
        
        var step2bottomLine2 = CALayer()
        step2bottomLine2.frame = CGRect(x:0.0,y:30.0,width:355.0,height:1.5)
        step2bottomLine2.backgroundColor = UIColor.white.cgColor
        stage2OrgPhone.borderStyle = UITextField.BorderStyle.none
        stage2OrgPhone.layer.addSublayer(step2bottomLine2)
        
        var step2bottomLine3 = CALayer()
        step2bottomLine3.frame = CGRect(x:0.0,y:30.0,width:355.0,height:1.5)
        step2bottomLine3.backgroundColor = UIColor.white.cgColor
        stage2OrgEmail.borderStyle = UITextField.BorderStyle.none
        stage2OrgEmail.layer.addSublayer(step2bottomLine3)
        
        var step2bottomLine4 = CALayer()
        step2bottomLine4.frame = CGRect(x:0.0,y:30.0,width:355.0,height:1.5)
        step2bottomLine4.backgroundColor = UIColor.white.cgColor
        stage2OrgWebsite.borderStyle = UITextField.BorderStyle.none
        stage2OrgWebsite.layer.addSublayer(step2bottomLine4)
        
        var step2bottomLine5 = CALayer()
        step2bottomLine5.frame = CGRect(x:0.0,y:30.0,width:355.0,height:1.5)
        step2bottomLine5.backgroundColor = UIColor.white.cgColor
        stage2OrgMission.borderStyle = UITextField.BorderStyle.none
        stage2OrgMission.layer.addSublayer(step2bottomLine5)
        
        var step2bottomLine6 = CALayer()
        step2bottomLine6.frame = CGRect(x:0.0,y:30.0,width:355.0,height:1.5)
        step2bottomLine6.backgroundColor = UIColor.white.cgColor
        stage2OrgCause.borderStyle = UITextField.BorderStyle.none
        stage2OrgCause.layer.addSublayer(step2bottomLine6)
        
        var step2bottomLine8 = CALayer()
        step2bottomLine8.frame = CGRect(x:0.0,y:30.0,width:355.0,height:1.5)
        step2bottomLine8.backgroundColor = UIColor.white.cgColor
        stage2OrgProfile.borderStyle = UITextField.BorderStyle.none
        stage2OrgProfile.layer.addSublayer(step2bottomLine8)
        
        var step2bottomLine9 = CALayer()
        step2bottomLine9.frame = CGRect(x:0.0,y:30.0,width:355.0,height:1.5)
        step2bottomLine9.backgroundColor = UIColor.white.cgColor
        stage2OrgStreet.borderStyle = UITextField.BorderStyle.none
        stage2OrgStreet.layer.addSublayer(step2bottomLine9)
        
        var step2bottomLine10 = CALayer()
        step2bottomLine10.frame = CGRect(x:0.0,y:30.0,width:355.0,height:1.5)
        step2bottomLine10.backgroundColor = UIColor.white.cgColor
        stage2OrgCity.borderStyle = UITextField.BorderStyle.none
        stage2OrgCity.layer.addSublayer(step2bottomLine10)
        
        var step2bottomLine11 = CALayer()
        step2bottomLine11.frame = CGRect(x:0.0,y:30.0,width:355.0,height:1.5)
        step2bottomLine11.backgroundColor = UIColor.white.cgColor
        stage2OrgZipCode.borderStyle = UITextField.BorderStyle.none
        stage2OrgZipCode.layer.addSublayer(step2bottomLine11)
        
        var step2bottomLine12 = CALayer()
        step2bottomLine12.frame = CGRect(x:0.0,y:30.0,width:355.0,height:1.5)
        step2bottomLine12.backgroundColor = UIColor.white.cgColor
        stage2OrgTaxEIN.borderStyle = UITextField.BorderStyle.none
        stage2OrgTaxEIN.layer.addSublayer(step2bottomLine12)

        self.stage2view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
    self.view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.stage2OrgName.textColor = .white
stage2OrgName.attributedPlaceholder = NSAttributedString(string: "Organization Name",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgPhone.textColor = .white
stage2OrgPhone.attributedPlaceholder = NSAttributedString(string: "Organization Phone Number",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgEmail.textColor = .white
stage2OrgEmail.attributedPlaceholder = NSAttributedString(string: "Organization Email",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgWebsite.textColor = .white
stage2OrgWebsite.attributedPlaceholder = NSAttributedString(string: "Organization Website",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgMission.textColor = .white
stage2OrgMission.attributedPlaceholder = NSAttributedString(string: "Organization Mission",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgCause.textColor = .white
stage2OrgCause.attributedPlaceholder = NSAttributedString(string: "Organization Cause",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgProfile.textColor = .white
stage2OrgProfile.attributedPlaceholder = NSAttributedString(string: "Organization Profile",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgStreet.textColor = .white
stage2OrgStreet.attributedPlaceholder = NSAttributedString(string: "Street",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgCity.textColor = .white
stage2OrgCity.attributedPlaceholder = NSAttributedString(string: "City",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgZipCode.textColor = .white
stage2OrgZipCode.attributedPlaceholder = NSAttributedString(string: "ZipCode",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgTaxEIN.textColor = .white
stage2OrgTaxEIN.attributedPlaceholder = NSAttributedString(string: "Tax/EIN",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.lblStateStage2.textColor = .white
        self.lblStateStage2.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        
        stage2SelectStateButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        stage2SelectStateButton.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        stage2SelectStateButton.borderColor = .white
        
        self.imageStage2dropdown.image = UIImage(named: "whitedrop.png")
        self.imageStage2drop2.image = UIImage(named: "whitedrop.png")
        self.imageStage2drop3.image = UIImage(named: "whitedrop.png")
        
        
        self.lblCountryStage2.textColor = .white
        self.lblCountryStage2.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        
        stage2SelectCountryButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        stage2SelectCountryButton.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        stage2SelectCountryButton.borderColor = .white
        
        
        self.stage3view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        lblStage3Q1.textColor = UIColor.white
        lblStage3Q2.textColor = UIColor.white
        lblStage3Q3.textColor = UIColor.white
        lblStage3Q4.textColor = UIColor.white
        lblStage3Q5.textColor = UIColor.white
        lblStage3Q6.textColor = UIColor.white
        lblStage3Q7.textColor = UIColor.white
        self.view.backgroundColor = .black
        lblYesQ1.textColor = UIColor.white
        lblNoQ1.textColor = UIColor.white
        
        lblYesQ5.textColor = UIColor.white
        lblNoQ5.textColor = UIColor.white
        lblYesQ6.textColor = UIColor.white
        lblNoQ6.textColor = UIColor.white
        lblYesQ7.textColor = UIColor.white
        lblNoQ7.textColor = UIColor.white
        
        stage3TotalVolButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        stage3TotalVolButton.borderColor = .white
        
        
       stage3ServiceOfferButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        stage3ServiceOfferButton.borderColor = .white
        
        stage3TargetClientGroupButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        stage3TargetClientGroupButton.borderColor = .white
        
        imageStage3drop1.image = UIImage(named: "whitedrop.png")
        imageStage3drop2.image = UIImage(named: "whitedrop.png")
        imageStage3drop3.image = UIImage(named: "whitedrop.png")
        
        
//        stage3OrgProfitNoButton.setImage(UIImage(named: "lightGraycirclenew.png"), for: UIControl.State.normal)
//        stage3OrgProfitYesButton.setImage(UIImage(named: "lightcheckedButton.png"), for: UIControl.State.normal)
//
//        stage3VolBackgroundCheckYesButton.setImage(UIImage(named: "lightcheckedButton.png"), for: UIControl.State.normal)
//        stage3VolBackgroundCheckNoButton.setImage(UIImage(named: "lightGraycirclenew.png"), for: UIControl.State.normal)
//
//        stage3PublicTransportYesButton.setImage(UIImage(named: "lightcheckedButton.png"), for: UIControl.State.normal)
//        stage3PublicTransportNoButton.setImage(UIImage(named: "lightGraycirclenew.png"), for: UIControl.State.normal)
//
//        stage3Certificate501C3YesButton.setImage(UIImage(named: "lightcheckedButton.png"), for: UIControl.State.normal)
//        stage3Certificate501C3NoButton.setImage(UIImage(named: "lightGraycirclenew.png"), for: UIControl.State.normal)
//
        
      
 }
    
    func addUnderLineToField(color:UIColor)  {
        
             
        stage1email.setUnderLineOfColor(color: color)
        stage1firstName.setUnderLineOfColor(color: color)
              
              
            
              stage1lastName.setUnderLineOfColor(color: color)
              
             
              stage1phoneNumber.setUnderLineOfColor(color: color)
              
             
              stage1street.setUnderLineOfColor(color: color)
              
           
              stage1city.setUnderLineOfColor(color: color)
              
              
              stage1zipCode.setUnderLineOfColor(color: color)
              
              var bottomlLine8 = CALayer()
              bottomlLine8.frame = CGRect(x:0.0,y:40,width:343.0,height:1.5)
              bottomlLine8.backgroundColor = UIColor.black.cgColor
              stage1password.borderStyle = UITextField.BorderStyle.none
              stage1password.layer.addSublayer(bottomlLine8)
              stage1Passwordeyebutton.frame = CGRect(x: 348, y: 0, width: 20, height: 40)
              
              var bottomlLine9 = CALayer()
              bottomlLine9.frame = CGRect(x:0.0,y:40,width:343.0,height:1.5)
              bottomlLine9.backgroundColor = UIColor.black.cgColor
              stage1confirmPassword.borderStyle = UITextField.BorderStyle.none
              stage1confirmPassword.layer.addSublayer(bottomlLine9)
              stage1confirmpasswordeyeButton.frame = CGRect(x: 348, y: 0, width: 20, height: 40)
              
              
              
              
              
              //Step 2
              
              
              
            
              stage2OrgName.setUnderLineOfColor(color: color)
              
              
              
              stage2OrgPhone.setUnderLineOfColor(color: color)
              
              
              
              
              
              stage2OrgEmail.setUnderLineOfColor(color: color)
              
              
            
              stage2OrgWebsite.setUnderLineOfColor(color: color)
              
              
             
              stage2OrgMission.setUnderLineOfColor(color: color)
              
              
              
              stage2OrgCause.setUnderLineOfColor(color: color)
              
              
              
              stage2OrgProfile.setUnderLineOfColor(color: color)
              
             
             
              stage2OrgStreet.setUnderLineOfColor(color: color)
              
              
             
              stage2OrgCity.setUnderLineOfColor(color: color)
              
              
              
              stage2OrgZipCode.setUnderLineOfColor(color: color)
              
              
              
              stage2OrgTaxEIN.setUnderLineOfColor(color: color)

//        self.viewDidLayoutSubviews()
    }
    
    func LightMode() {
        
         self.stage1email.textColor = .black
stage1email.attributedPlaceholder = NSAttributedString(string: "Email",
           attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
         self.stage1firstName.textColor = .black
stage1firstName.attributedPlaceholder = NSAttributedString(string: "First Name",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1lastName.textColor = .black
stage1lastName.attributedPlaceholder = NSAttributedString(string: "Last Name",
              attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1phoneNumber.textColor = .black
stage1phoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number",
                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1street.textColor = .black
stage1street.attributedPlaceholder = NSAttributedString(string: "Street",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage1city.textColor = .black
stage1city.attributedPlaceholder = NSAttributedString(string: "City",
          attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
       self.stage1zipCode.textColor = .black
stage1zipCode.attributedPlaceholder = NSAttributedString(string: "Zipcode",
             attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
      self.stage1password.textColor = .black
stage1password.attributedPlaceholder = NSAttributedString(string: "Password",
              attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
       self.stage1confirmPassword.textColor = .black
stage1confirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
       
      self.stage2OrgName.textColor = .black
stage2OrgName.attributedPlaceholder = NSAttributedString(string: "Organization Name",
             attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
      self.stage2OrgPhone.textColor = .black
stage2OrgPhone.attributedPlaceholder = NSAttributedString(string: "Organization Phone Number",
              attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
     self.stage2OrgEmail.textColor = .black
stage2OrgEmail.attributedPlaceholder = NSAttributedString(string: "Organization Email",
              attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    self.stage2OrgWebsite.textColor = .black
stage2OrgWebsite.attributedPlaceholder = NSAttributedString(string: "Organization Website",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
      self.stage2OrgMission.textColor = .black
stage2OrgMission.attributedPlaceholder = NSAttributedString(string: "Organization Mission",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
         self.stage2OrgCause.textColor = .black
stage2OrgCause.attributedPlaceholder = NSAttributedString(string: "Organization Cause",
              attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgProfile.textColor = .black
stage2OrgProfile.attributedPlaceholder = NSAttributedString(string: "Organization Profile",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgStreet.textColor = .black
stage2OrgStreet.attributedPlaceholder = NSAttributedString(string: "Street",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
         self.stage2OrgCity.textColor = .black
stage2OrgCity.attributedPlaceholder = NSAttributedString(string: "City",
             attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgZipCode.textColor = .black
stage2OrgZipCode.attributedPlaceholder = NSAttributedString(string: "ZipCode",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.stage2OrgTaxEIN.textColor = .black
stage2OrgTaxEIN.attributedPlaceholder = NSAttributedString(string: "Tax/EIN",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])

        
    }
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == self.stage1phoneNumber){
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
        if(textField == stage1zipCode) || (textField == stage2OrgZipCode){
            
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
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
             guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL
                            else { return }
        
            let selFileName = fileUrl.lastPathComponent
            let selFileData =  (image as? UIImage)!.jpegData(compressionQuality: 0.5)!
            
            if (getFileSizeMBfromData(selFileData) > 5.0 ){
                   let alert = UIAlertController(title: nil, message: "File size must be less than 5 MB.", preferredStyle: .alert)
                                         alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                         self.present(alert, animated: true)
            self.step2doc = nil
               }else{
                   self.step2fileName = selFileName
                   self.step2doc = selFileData
               
               }
            
           
        }else{
           // //print("error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func stage1Gender(_ sender: Any) {
        let contents = ["Female","Male"]
               showPopoverForView(view: sender, contents: contents)
        
    }
    
    @IBAction func stage1selectState(_ sender: Any) {
        let utility = Utility()
                   utility.fetchStateList{ (eventTypeList, isValueFetched) in
                       if let list = eventTypeList {
                           self.showPopoverForView(view: sender, contents: list)
                       }
                   }
    }
    @IBAction func stage1selectCountry(_ sender: Any) {
        let utility = Utility()
                  utility.fetchCountryList{ (eventTypeList, isValueFetched) in
                      if let list = eventTypeList {
                          self.showPopoverForView(view: sender, contents: list)
                      }
                  }
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
             }else if let selectVal = selectedValue as? [String:Any], let title = selectVal[GetDocumentType.documentTypeName] as? String {
                self.documentName = selectVal[GetDocumentType.documentTypeName] as! String
                
                self.documentID = selectVal[GetDocumentType.documentTypeID] as! String
                            senderButton.setTitle(title, for: .normal)
                            senderButton.setImage(nil, for: .normal)
             }else if let selectVal = selectedValue as? [String:Any],
                let title = selectVal[GetQuestionType.answer_detail] as? String {
                                    senderButton.setTitle(title, for: .normal)
                                    senderButton.setImage(nil, for: .normal)
             }
                     
             
         }
     }
    
    
    func addViewController(viewController:UIViewController)  {
           viewController.willMove(toParent: self)
           self.view.addSubview(viewController.view)
           self.addChild(viewController)
           viewController.didMove(toParent: self)
       }
    
    @IBAction func stage1DateOfBirthMethod(_ sender: Any) {
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
                 self.stage1DOB = dateString
                 (sender as AnyObject).setTitle(dateString, for:.normal)
                 (sender as AnyObject).setImage(nil, for: .normal)
             }
             addViewController(viewController: dateSelectionPicker)
    }
    @IBAction func stage1ResteButton(_ sender: Any) {
        self.stage1email.text = ""
        self.stage1firstName.text = ""
        self.stage1lastName.text = ""
        self.stage1phoneNumber.text = ""
        self.stage1street.text = ""
        self.stage1city.text = ""
        self.user_stateID = ""
        self.stage1zipCode.text = ""
        self.user_countryID = ""
        self.stage1confirmPassword.text = ""
        self.stage1password.text = ""
    }
    
    
    @IBAction func stage1SubmitNextButton(_ sender: Any) {
       self.scrollerView.setContentOffset(.zero, animated: false)
        
        if (self.screen == "EDIT VIEW"){
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            let user_id = userIDData["user_id"] as! String

            var params2 = [
                "user_id":user_id,
                "user_type":"CSO",
                "user_device":UIDevice.current.identifierForVendor!.uuidString,
                "user_f_name":self.stage1firstName.text as? String,
                "user_l_name":self.stage1lastName.text as? String,
                "user_country":self.user_countryID as? String,
                "user_state":self.user_stateID as? String,
                "user_city":self.stage1city.text as? String,
                "user_zipcode":self.stage1zipCode.text as? String,
                "user_address": self.stage1street.text as? String,
                "user_dob":self.stage1DOB as? String,
                "user_gender":self.user_gender,
                "school_id":"",
                "user_ethnicity":"",

                "user_grade":"",

                "vol_status":""
                            ]

                let servicehandler = ServiceHandlers()
                servicehandler.csoeditProfileStep1(data: params2){(responce,isSuccess) in
                    if isSuccess{
                        self.user_stateID = ""
                           self.user_countryID = ""
                        self.stage1view.isHidden = true
                        self.stage2view.isHidden = false
                        self.scrollerView.isHidden = true
                        self.stage2ScrollView.isHidden = false
                        self.stage3ScrollView.isHidden = true
                        self.boolShowBackAlert = true
                        self.lblStagesInformation.text = NSLocalizedString("Organization Information", comment: "")
                        self.imgStep2.image = UIImage(named: "teal2.png")
                        self.imageStep1.image = UIImage(named: "gray1.png")
                        self.imgStep3.image = UIImage(named: "gray3.png")

                        self.stage2OrgName.text = self.data_edit_profile_details!["org_name"] as! String
                        self.stage2OrgPhone.text = self.data_edit_profile_details!["org_phone"] as! String
                        self.stage2OrgEmail.text = self.data_edit_profile_details!["org_email"] as! String
                        self.stage2OrgWebsite.text = self.data_edit_profile_details!["org_website"] as! String
                        self.stage2OrgMission.text = self.data_edit_profile_details!["org_mission"] as! String
                        self.stage2OrgCause.text = self.data_edit_profile_details!["org_cause"] as! String
                        self.stage2OrgProfile.text = self.data_edit_profile_details!["org_profile"] as! String
                        self.stage2OrgStreet.text = self.data_edit_profile_details!["org_address"] as! String
                        self.stage2OrgCity.text = self.data_edit_profile_details!["org_city"] as! String
                        self.stage2SelectStateButton.setTitle(self.data_edit_profile_details!["org_state_name"] as! String, for: .normal)
                        self.user_stateID = self.data_edit_profile_details!["org_state"] as! String

                      //  self.DarkMode()   //prachi
                        let utility = Utility()
                    utility.fetchStateList { (stateList, isValueFetched) in
                if let statelistL = stateList {

                for statename in statelistL{

                       // //print(statename)
                        if statename["state_id"] as! String == self.user_stateID!
                                                                           {
                    self.stage2SelectStateButton.setTitle(statename["state_name"] as! String, for: .normal)
                        }

                                    }
                        }
                                }

                        self.stage2OrgZipCode.text = self.data_edit_profile_details!["org_zipcode"] as! String

            self.user_countryID = self.data_edit_profile_details!["org_country"] as! String
        self.stage2SelectCountryButton.setTitle(self.data_edit_profile_details!["org_country_name"] as! String, for: .normal)

        utility.fetchCountryList { (countryList, isValueFetched) in
            if let countrylistL = countryList {

                for countryName in countrylistL{

                        //print(countryName)
              if countryName["country_id"] as! String == self.user_countryID!

{
                self.stage2SelectCountryButton.setTitle(( countryName["country_name"]as! String), for: .normal)
            }
                }
                    }
                       }
        self.stage2OrgTaxEIN.text = self.data_edit_profile_details!["org_taxid"] as! String
                        self.stage2uploadbuttons.isHidden = true
                        self.stage2uploadfilebuttons.isHidden = true
                        self.stage2lbnUploadFile.isHidden = true


                    }
                }

        }else if(validate()){
        var params =            ["user_type":"CSO",
                                 "user_device": UIDevice.current.identifierForVendor!.uuidString,
                                 "school_id": "",
                                 "user_f_name": self.stage1firstName.text as? String,
                                 "user_l_name": self.stage1lastName.text as? String,
                                 "user_email": self.stage1email.text as? String,
                                 "user_phone": self.stage1phoneNumber.text as? String,
                                 "user_country": self.user_countryID as? String,
                                 "user_state": self.user_stateID as? String,
                                 "user_city" : self.stage1city.text as? String,
                                 "user_zipcode": self.stage1zipCode.text as? String,
                                 "user_address": self.stage1street.text as? String,
                                 "user_dob": self.stage1DOB as? String,
                                 "user_gender": self.user_gender,
                                 "user_pass": self.stage1password.text as? String
                   ]
            
            stage2OrgStreet.text = self.stage1street.text
            stage2OrgCity.text = self.stage1city.text
            stage2OrgZipCode.text = self.stage1zipCode.text
            stage2SelectStateButton.setTitle(stage1UserStateButton.currentTitle, for: .normal)
            //user_stateID elf.user_stateID self.user_stateID
           stage2SelectCountryButton.setTitle(stage1userCountryButton.currentTitle, for: .normal)
            //self.user_countryID  self.user_countryID as? String,
//            self.stage1view.isHidden = true
//            self.stage2view.isHidden = false
//            self.scrollerView.isHidden = true
//            self.stage2ScrollView.isHidden = false
//            self.stage3ScrollView.isHidden = true
                                  
                                  
                   print(params)
                   let servicehandler = ServiceHandlers()
                   servicehandler.csoRegistrationStage1(data: params){(responce,isSuccess) in
                       if isSuccess{
                           let data = responce as! Dictionary<String,Any>
                           self.user_id = (data["user_id"] as! String)
                           self.user_stateID = ""
                           self.user_countryID = ""
                        self.stage1view.isHidden = true
                        self.stage2view.isHidden = false
                        self.scrollerView.isHidden = true


                        self.stage2ScrollView.isHidden = false
                        self.stage3ScrollView.isHidden = true
                        self.boolShowBackAlert = true
                        self.lblStagesInformation.text = NSLocalizedString("Organization Information", comment: "")
                        self.imgStep2.image = UIImage(named: "teal2.png")
                                              self.imageStep1.image = UIImage(named:"gray1.png")
                                              self.imgStep3.image = UIImage(named: "gray3.png")


                       }else{
                         let msg = responce as! String
                        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                   }

        }
        
    }
    
    
    @IBAction func stage2OrgSelectDoucumentType(_ sender: Any) {
       let utility = Utility()
        utility.fetchDocumentType(){ (eventTypeList, isValueFetched) in
            if let list = eventTypeList {
                self.showPopoverForView(view: sender, contents: list)
            }
        }
            }
            
            
        
    
    
    
    @IBAction func stage2OrgDocumentTypeButton(_ sender: Any) {
        if !(self.documentID == nil){
        let alert = UIAlertController(title: NSLocalizedString("UPLOAD FILES FROM", comment: ""), message: "", preferredStyle: .alert)
                             let gallery = UIAlertAction(title: NSLocalizedString("Image from Gallery", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
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
//let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
///** What we write here???????? **/
//
//let image = UIImagePickerController()
//image.delegate = self
//image.sourceType = UIImagePickerController.SourceType.camera
//image.allowsEditing = false
//self.present(image, animated: true)
//{
//
//}
// call method whatever u need
//})
                      let drive = UIAlertAction(title: NSLocalizedString("Files", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                                              /** What we write here???????? **/
                                             let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text","com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String], in: .import)
                                                  
                                             documentPicker.delegate = self
                                          
                          documentPicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                         
                                      self.present(documentPicker, animated: true, completion: nil)
                                              // call method whatever u need
                                          })
                             let noButton = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
                             alert.addAction(gallery)
//                             alert.addAction(camera)
                             alert.addAction(drive)
                             alert.addAction(noButton)
                             present(alert, animated: true)
        }else{
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Select Doument Type", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func stage2OrgSelectCountry(_ sender: Any) {
        let utility = Utility()
                         utility.fetchCountryList{ (eventTypeList, isValueFetched) in
                             if let list = eventTypeList {
                                 self.showPopoverForView(view: sender, contents: list)
                             }
                         }
    }
    
    @IBAction func stage2OrgSelectState(_ sender: Any) {
        let utility = Utility()
                          utility.fetchStateList{ (eventTypeList, isValueFetched) in
                              if let list = eventTypeList {
                                  self.showPopoverForView(view: sender, contents: list)
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
    
    func validate()->Bool{
        if(self.stage1email.text == ""){
            let alert = UIAlertController(title: nil, message:NSLocalizedString("Email Is empty", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }else if !(self.isValidUserName(text: self.stage1email.text!)){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Not a valid email", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
            return false
        } else if(self.stage1firstName.text == ""){
                   let alert = UIAlertController(title: nil, message: NSLocalizedString("First Name cannot be blank", comment: ""), preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                   present(alert, animated: true)
                   return false
               }else if(self.stage1lastName.text == ""){
                   let alert = UIAlertController(title: nil, message: NSLocalizedString("Last Name cannot be blank", comment: ""), preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                   present(alert, animated: true)
                   return false
               }else if(self.stage1phoneNumber.text == ""){
                   let alert = UIAlertController(title: nil, message: NSLocalizedString("Phone Number cannot be blank", comment: ""), preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                   present(alert, animated: true)
                   return false
               }
        else if !(self.isValidPhoneNumber(text:self.stage1phoneNumber.text!)){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Not a valid phone number.", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }
       
        else if(self.user_stateID == nil){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("State not selected", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }else if(self.user_countryID == nil){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Country Not Selected", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }else if((self.stage1DOB == "") || (self.stage1DOB == nil)){
            let alert = UIAlertController(title: nil, message:"Date of Birth is empty.", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                      self.present(alert, animated: true)
                      return false
        }else if (datefromString(strDate: self.stage1DOB!).timeIntervalSinceNow.sign == .plus) {
            // date is in future
            let alert = UIAlertController(title: nil, message:"Date of Birth is not valid", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }else if(self.user_gender == "" || self.user_gender == nil){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Gender not selected", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }else if(self.stage1password.text == ""){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Password Is Empty", comment: ""), preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
                       return false
        }else  if !(self.validatePassword(password: self.stage1password.text!) )
        {
            let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Password must be at least 8 characters 1 uppercase 1 lowercase and 1 number", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }else if(self.stage1confirmPassword.text == ""){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Confirm Password Is Empty", comment: ""), preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
                       return false
        }else if !(self.stage1password.text == self.stage1confirmPassword.text){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Password and Confirm Password not Same", comment: ""), preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
                       return false
        }
        return true
    }
    
    
    func validatePassword(password: String) -> Bool
    {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"

        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)

        return passwordValidation.evaluate(with: password)
    }
    

    func datefromString(strDate: String)->Date{
           
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MM-dd-yyyy"
           let dateToCheck = dateFormatter.date(from: strDate)!
           return dateToCheck
       }

    
    @IBAction func stage2UploadButtonAddMoreDocument(_ sender: Any) {
        self.documentID = ""
        self.step2doc = nil
        self.stage2SelectDocumentButton.setTitle("Select Document", for: .normal)
        
        
    }
    
    
    @IBAction func passwordBtnEye(_ sender: Any) {
        if(self.password_secure_eye == true){
        stage1Passwordeyebutton.setImage(UIImage(named: "eye-open.png"), for: .normal)
             stage1Passwordeyebutton.frame = CGRect(x: 348, y: 0, width: 20, height: 40)
            self.password_secure_eye = false
            stage1password.isSecureTextEntry = false
        }else{
            stage1Passwordeyebutton.setImage(UIImage(named: "eye-close2.png"), for: .normal)
             stage1confirmpasswordeyeButton.frame = CGRect(x: 348, y: 0, width: 20, height: 40)
            self.password_secure_eye = true
            stage1password.isSecureTextEntry = true
        }
        
    }
    
    
    
    @IBAction func confirmPasswordEyeBtn(_ sender: Any) {
        if(self.confirm_secure_eye == true){
            stage1confirmpasswordeyeButton.setImage(UIImage(named: "eye-open.png"), for: .normal)
                self.confirm_secure_eye = false
                stage1confirmPassword.isSecureTextEntry = false
            }else{
                stage1confirmpasswordeyeButton.setImage(UIImage(named: "eye-close2.png"), for: .normal)
                self.confirm_secure_eye = true
                stage1confirmPassword.isSecureTextEntry = true
            }
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {

     let cico = url as URL
     print(cico)
     print(url)

     print(url.lastPathComponent)

     print(url.pathExtension)
        var selFileName:String?
        var selFileData:Data?
    do {
         // inUrl is the document's URL
            selFileName = url.lastPathComponent
            selFileData = try Data(contentsOf: url) // Getting file data here
        } catch {
            print("Error Occured")
        }


        if (getFileSizeMBfromData(selFileData!) > 5.0 ){
                   let alert = UIAlertController(title: nil, message: "File size must be less than 5 MB.", preferredStyle: .alert)
                                         alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                         self.present(alert, animated: true)
            self.step2doc = nil
               }else{
                   self.step2fileName = selFileName
                   self.step2doc = selFileData
               
               }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {

        print(" cancelled by user")

        dismiss(animated: true, completion: nil)

    }
    
    func getFileSizeMBfromData(_ filedata : Data)-> Float{
        var string = ""
     print("There were \(filedata.count) bytes")
      let bcf = ByteCountFormatter()
      bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
      bcf.countStyle = .file
    string = bcf.string(fromByteCount: Int64(filedata.count))
      print("formatted result: \(string)")
        return (string as NSString).floatValue
    }
    
    
    @IBAction func stage2DocumentUploadButton(_ sender: Any) {
        
        
        let strNewDocName = self.documentName!.replacingOccurrences(of: "'", with: "%27")
        if((self.step2doc != nil) && (self.documentID != "")){
            let params = ["action": "doc_locker_file_upload",
                          "api_key": "1234",
                          "user_id": self.user_id,
                          "user_device": UIDevice.current.identifierForVendor!.uuidString,
                          "document_name": strNewDocName,
                          "document_type": self.documentID
                         
                        ]
            let servicehandler =  ServiceHandlers()
            servicehandler.csoregistrationStep2fileUPload(data_details: params, file: self.step2doc!,file_name: self.step2fileName!){ (responce,isSuccess) in
                if isSuccess {
                  // //print("UPload document")
                    let strMessage = responce as! String
                    
                    let alert = UIAlertController(title: nil, message:NSLocalizedString(strMessage, comment: "") , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { (action) in
                        self.documentUploaded.append(self.documentName! )
                        self.documentID = ""
                        self.step2doc = nil
                        self.stage2SelectDocumentButton.setTitle("Select Document", for: .normal)
                        self.numberOfDocument = self.numberOfDocument + 1
                        
                    }))
                    self.present(alert , animated: true)
                }else{
                    let alert = UIAlertController(title: "Error Occured!", message: "Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                
            }
        }else{
            let alert = UIAlertController(title: nil, message: "Select File", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.document_detail_list == nil){
            return 0
        }else{
            return self.document_detail_list!.count
            
        }
    }
    func deleteButton(delTag: Int) {
          // //print(delTag)
           let del_data = self.document_detail_list![delTag] as! Dictionary<String,Any>
//        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
//        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
//        let user_id = userIDData["user_id"] as! String

        let params = ["user_id": self.user_id,
                      "user_device": UIDevice.current.identifierForVendor!.uuidString,
                      "user_type": "CSO",
                      "document_id": del_data["document_id"]
                        ]
        let serivehandler = ServiceHandlers()
        serivehandler.deletelocker(data_details: params){(responce,isSuccess) in
            if isSuccess{
                let alert = UIAlertController(title: nil, message: "Delete Document Successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler:{(_ action: UIAlertAction) -> Void in
                    self.view.sendSubviewToBack(self.stage2DocumentListBackgroundView)
                          self.stage2DocumentListBackgroundView.isHidden = true
                    
                }))
                self.present(alert, animated: true)
            }
        }
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stage2documentListTableView.dequeueReusableCell(withIdentifier: "doc_cell") as! documentTypeCellTableViewCell
        var list_data = self.document_detail_list![indexPath.row] as? Dictionary<String,Any>
//        cell.lbnDocumentTitle.text = list_data!["document_file_name"] as! String
       
        let fileURL = NSURL(fileURLWithPath:list_data!["document_file_name"] as! String)
        let pathDir:String = (fileURL.deletingLastPathComponent?.absoluteString)!
        print(pathDir)
        let fullname:String = fileURL.lastPathComponent!
        print(fullname)
        cell.lbnDocumentTitle.text = fullname as! String
        print(cell.lbnDocumentTitle.text)
        
        
        cell.lbnDocumentSubTitle.text = list_data!["document_name"] as! String
        
        
        cell.deletebuttonInDocumentView.tag = indexPath.row
        cell.delegate = self
        
        return cell
        
    }
     @IBAction func backbutton(_ sender: Any) {
        
       if boolShowBackAlert{
             let alert = UIAlertController(title: NSLocalizedString("CONFIRM EXIT?", comment: ""), message: NSLocalizedString("Do you want to discard changes?", comment: ""), preferredStyle: UIAlertController.Style.alert)
                 alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: { _ in
                 //Cancel Action
             }))
             alert.addAction(UIAlertAction(title: "YES",
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
    
    @IBAction func stage2DocumentViewButton(_ sender: Any) {
        let servicehandler = ServiceHandlers()
        servicehandler.lockerList(user_id:self.user_id!){(responce,isSuccess) in
            if isSuccess{
                self.document_detail_list = responce as! Array<Any>
                
                
                self.documentListView()
              
                self.stage2documentListTableView.reloadData()
            }else{
                let alert = UIAlertController(title: nil, message: "No Document Uploaded", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { (alert_action) in
                    self.view.sendSubviewToBack(self.stage2DocumentListBackgroundView)
                    self.stage2DocumentListBackgroundView.isHidden = true
                }))
                self.present(alert, animated: true)
            }
        }
        
    }
    func documentListView() {
        
        self.stage2DocumentListBackgroundView.isHidden = false
        self.view.bringSubviewToFront(self.stage2DocumentListBackgroundView)
       
        
    }
    @IBAction func stage2ResetButton(_ sender: Any) {
        self.stage2OrgName.text = ""
        self.stage2OrgPhone.text = ""
        self.stage2OrgEmail.text = ""
        self.stage2OrgWebsite.text = ""
        self.stage2OrgMission.text = ""
        self.stage2OrgCause.text = ""
        self.stage2OrgProfile.text = ""
        self.stage2OrgStreet.text = ""
        self.stage2OrgCity.text = ""
        self.user_stateID = ""
        self.stage2SelectStateButton.setTitle(NSLocalizedString("Select State", comment: ""), for: UIControl.State.normal)
        self.stage2OrgZipCode.text = ""
        self.user_countryID = ""
        self.stage2SelectCountryButton.setTitle("Select Country", for: UIControl.State.normal)
        self.stage2OrgTaxEIN.text = ""
        self.documentID = ""
        self.step2doc = nil
        self.stage2SelectDocumentButton.setTitle("Select document type", for: .normal)
        
        
    }
    
    @IBAction func stage2SubmitButton(_ sender: Any) {
        self.scrollerView.setContentOffset(.zero, animated: false)
        if(validate2()){
            if self.screen == "EDIT VIEW"{
                let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                self.user_id = userIDData["user_id"] as! String
            }
            let params = ["user_id":self.user_id,
           "user_type":"CSO",
           "user_device":UIDevice.current.identifierForVendor!.uuidString ,
           "org_name": self.stage2OrgName.text as? String,
           "org_email": self.stage2OrgEmail.text as? String,
           "org_phone": self.stage2OrgPhone.text as? String,
           "org_website": self.stage2OrgWebsite.text as? String,
           "org_mission": self.stage2OrgMission.text as? String,
           "org_cause": self.stage2OrgCause.text as? String,
           "org_profile": self.stage2OrgProfile.text,
           "org_country": self.user_countryID as? String,
           "org_state": self.user_stateID as? String,
           "org_city": self.stage2OrgCity.text as? String,
           "org_zipcode": self.stage2OrgZipCode.text as? String,
           "org_address": self.stage2OrgStreet.text as? String,
           "org_taxid": self.stage2OrgTaxEIN.text as? String,
           "user_id_file":"",
           "user_file_title":"",
           "org_longitude":"0",
           "org_latitude":"0"] as [String : Any]


            let servicehandler = ServiceHandlers()
            servicehandler.csoRegistrationStage2(data: params){(responce,isSuccess) in
                if isSuccess{
                    self.scrollerView.isHidden = true
                    self.stage2ScrollView.isHidden = true
                    self.stage3ScrollView.isHidden = false
                    self.stage1view.isHidden = true
                    self.stage2view.isHidden = true
                    self.stage3view.isHidden = false
                    self.boolShowBackAlert = true
                    self.lblStagesInformation.text = NSLocalizedString("More Information", comment: "")
                    self.imgStep2.image = UIImage(named: "gray2.png")
                                          self.imageStep1.image = UIImage(named: "gray1.png")
                                          self.imgStep3.image = UIImage(named: "teal3.png")

                    if self.screen == "EDIT VIEW"
                    {
                        self.stage3editprofile()
                    }
                   let servicehandler = ServiceHandlers()
            servicehandler.getQuestionListForCSO(){(responce,isSuccess) in
                        if isSuccess {
                                    self.quesData = responce as! Dictionary<String,Any>
                                    }

                                }
                           }
                       }
                    }
                }
    func stage3editprofile() {
        self.stage3OrgProfit = self.data_edit_profile_details!["org_non_profit"] as! String
        if self.stage3OrgProfit == "1" {
        self.stage3OrgProfitYesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
            self.stage3OrgProfitNoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        }else{
            self.stage3OrgProfitYesButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
            self.stage3OrgProfitNoButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        }
        self.stage3ServiceOfferButton.setTitle(self.data_edit_profile_details!["org_service"] as! String, for: .normal)
        self.stage3TargetClientGroupButton.setTitle(self.data_edit_profile_details!["org_target"] as! String, for: .normal)
        self.stage3TotalVolButton.setTitle(self.data_edit_profile_details!["org_volunteer_req"] as! String, for: .normal)
        self.stage3BackgroundCheck = self.data_edit_profile_details!["org_voluteer_police"] as! String
        if self.stage3BackgroundCheck == "1"
        {
            self.stage3VolBackgroundCheckYesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
            self.stage3VolBackgroundCheckNoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        }else{
            self.stage3VolBackgroundCheckYesButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
            self.stage3VolBackgroundCheckNoButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        }
        self.stage3PublicTransport = self.data_edit_profile_details!["org_easy_access"] as! String
        if self.stage3PublicTransport == "1"{
            self.stage3PublicTransportYesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
            self.stage3PublicTransportNoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        }else{
            self.stage3PublicTransportYesButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
            self.stage3PublicTransportNoButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        }
        self.stage3Certificate = self.data_edit_profile_details!["org_501C3"] as! String
        if self.stage3Certificate == "1"
        {
            self.stage3Certificate501C3YesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
            self.stage3Certificate501C3NoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        }else{
            self.stage3Certificate501C3YesButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
            self.stage3Certificate501C3NoButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        }
    }
    func validate2() -> Bool {
        if (self.stage2OrgName.text == "")
        {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Organization Name is empty", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
            
        }
//        else if(self.screen != "EDIT VIEW"){
//            if(self.numberOfDocument <= 0){
//            let alert = UIAlertController(title: nil, message: NSLocalizedString("Upload atleast one document", comment: ""), preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
//            self.present(alert, animated: true)
//            return false
//        }
//
//            }
            
            let searchValue = "501C3 Certificate"
            var currentIndex = 0
            for name in self.documentUploaded
            {
                if (name as? String) == searchValue {
                    currentIndex += 1
                }
            }
            if currentIndex < 0{
                let alert = UIAlertController(title: nil, message: "Should upload a document of type 501C3 Certificate", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                self.present(alert, animated: true)
                return false
            
        }
        return true
        
    }
    
    
    @IBAction func stage3ServiceOffer(_ sender: Any) {
        let ques = self.quesData!["question1_data"] as! Array<Any>
        self.showPopoverForView(view: sender, contents: ques)
        
        
    }
    
    
    @IBAction func stage3targetClientGroup(_ sender: Any) {
         let ques = self.quesData!["question2_data"] as! Array<Any>
        self.showPopoverForView(view: sender, contents: ques)
              
    }
    
    
    @IBAction func stage3TotalVolNeed(_ sender: Any) {
         let ques = self.quesData!["question3_data"] as! Array<Any>
        self.showPopoverForView(view: sender, contents: ques)
               
    }
    
    
    @IBAction func stage3OrgProfitYes(_ sender: Any) {
        /*let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode"{
        
            self.stage3OrgProfitYesButton.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
            self.stage3OrgProfitNoButton.setImage(UIImage(named: "grayTrans.png"), for: .normal)
       
        }else if defaults == "Light Mode"{
         */
            self.stage3OrgProfitYesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
            self.stage3OrgProfitNoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        //}
        self.stage3OrgProfit = "1"
    }
    
    
    @IBAction func stage3OrgProfitNo(_ sender: Any) {
        /*let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode"{
        self.stage3OrgProfitYesButton.setImage(UIImage(named: "grayTrans.png"), for: .normal)
               self.stage3OrgProfitNoButton.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
        }else if defaults == "Light Mode"{
          */  self.stage3OrgProfitYesButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
            self.stage3OrgProfitNoButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
            
        //}
        self.stage3OrgProfit = "0"
    }
    
    
    @IBAction func stage3VolBackgroundCheckYes(_ sender: Any) {
      /*  let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        if defaults == "Dark Mode"{
        self.stage3VolBackgroundCheckYesButton.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
        self.stage3VolBackgroundCheckNoButton.setImage(UIImage(named: "grayTrans.png"), for: .normal)
        }else  if defaults == "Light Mode"{
           */ self.stage3VolBackgroundCheckYesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
            self.stage3VolBackgroundCheckNoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
       // }
        self.stage3BackgroundCheck = "1"
    }
    
    
    @IBAction func stage3VolBackgroundCheckNo(_ sender: Any) {
     //   let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
       // if defaults == "Light Mode" {
        self.stage3VolBackgroundCheckYesButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        self.stage3VolBackgroundCheckNoButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
       // }else if defaults == "Dark Mode"{
         //   self.stage3VolBackgroundCheckYesButton.setImage(UIImage(named: "grayTrans.png"), for: .normal)
           // self.stage3VolBackgroundCheckNoButton.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
        //}*/
            self.stage3BackgroundCheck = "0"
    }
    
    
    @IBAction func stage3OrgPublicTransportYes(_ sender: Any) {
       // let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
      //  if defaults == "Light Mode"{
      
        self.stage3PublicTransportYesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        self.stage3PublicTransportNoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
       
        //}else if defaults == "Dark Mode"{
            
          //  self.stage3PublicTransportYesButton.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
            //self.stage3PublicTransportNoButton.setImage(UIImage(named: "grayTrans.png"), for: .normal)
       
      //  }*/
            self.stage3PublicTransport = "1"
    }
    
    
    @IBAction func stage3OrgPublicTransportNo(_ sender: Any) {
        //let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        //if defaults == "Light Mode"{
            
            self.stage3PublicTransportYesButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
            self.stage3PublicTransportNoButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        
        //}else if defaults == "Dark Mode"{
            
          //  self.stage3PublicTransportYesButton.setImage(UIImage(named: "grayTrans.png"), for: .normal)
            //self.stage3PublicTransportNoButton.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
        //}
        
                             self.stage3PublicTransport = "0"
    }
    
    
    @IBAction func stage3Certificate501C3Yes(_ sender: Any) {
       // let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        //if defaults == "Light Mode" {
        
        self.stage3Certificate501C3YesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        self.stage3Certificate501C3NoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        
        //}else if defaults == "Dark Mode" {
            
          //  self.stage3Certificate501C3YesButton.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
            //self.stage3Certificate501C3NoButton.setImage(UIImage(named: "grayTrans.png"), for: .normal)
        //}
        self.stage3Certificate = "1"
    }
    
    @IBAction func stage3Certificate501C3No(_ sender: Any) {
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
       // if defaults == "Light Mode"{
        self.stage3Certificate501C3YesButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
    self.stage3Certificate501C3NoButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
           
        //}else if defaults == "Dark Mode"{
            
          //  self.stage3Certificate501C3YesButton.setImage(UIImage(named: "grayTrans.png"), for: .normal)
            //self.stage3Certificate501C3NoButton.setImage(UIImage(named: "lightcheckedButton.png"), for: .normal)
            
        //}*/
            self.stage3Certificate = "0"
    }
    
    
    @IBAction func stage3ResetButton(_ sender: Any) {
       self.stage3OrgProfitYesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
             self.stage3OrgProfitNoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        self.stage3OrgProfit = "1"
         self.stage3VolBackgroundCheckYesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
         self.stage3VolBackgroundCheckNoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        self.stage3BackgroundCheck = "1"
        self.stage3PublicTransportYesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        self.stage3PublicTransportNoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        self.stage3PublicTransport = "1"
        self.stage3Certificate501C3YesButton.setImage(UIImage(named: "checkedButton.png"), for: .normal)
        self.stage3Certificate501C3NoButton.setImage(UIImage(named: "graycirclenew.png"), for: .normal)
        self.stage3Certificate = "1"
    }
    
    
    @IBAction func stage3Submit(_ sender: Any) {
        
        let params = [
            "user_id" : self.user_id,
        "user_type":"CSO",
        "user_device": UIDevice.current.identifierForVendor!.uuidString ,
            "org_nonprofit": self.stage3OrgProfit,
            "org_service": self.stage3ServiceOfferButton.titleLabel?.text,
            "org_target": self.stage3TargetClientGroupButton.titleLabel?.text,
            "org_volunteer_req": self.stage3TotalVolButton.titleLabel?.text,
        "org_min_time":"",
        "org_volunteer_num": "",
        "org_volunteer_police": self.stage3BackgroundCheck,
        "org_easy_access": self.stage3PublicTransport,
        "org_501C3" : self.stage3Certificate
        ]
        let servicehandler = ServiceHandlers()
        servicehandler.csoRegistrationStage3(data: params){(responce,isSuccess) in
            if isSuccess{
                var data = responce as! Dictionary<String,Any>
                self.phone_otp = data["phone_otp"] as! String
               print(self.phone_otp)
                
                if self.screen == "EDIT VIEW"
                {
                    let alert = UIAlertController(title: nil, message: "Update Successful", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { (alert_action) in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                }else{
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let obj1 = sb.instantiateViewController(withIdentifier: "phoneotp") as! PhoneOtp
                obj1.phoneotp = self.phone_otp
                obj1.user_id = self.user_id
                    obj1.user_type = "CSO"
                self.present(obj1, animated: true)
                }
            }
        }
    }
    
    func setupforSecondStage(){
           print(regStage1data)
          
           self.user_id = (self.regStage1data!["user_id"] as! String)
                                     self.user_stateID = ""
                                     self.user_countryID = "1"
        self.stage1view.isHidden = true
        self.stage2view.isHidden = false
        self.scrollerView.isHidden = true
        self.stage2ScrollView.isHidden = false
        self.stage3ScrollView.isHidden = true
        
        self.boolShowBackAlert = true
                                  self.lblStagesInformation.text = NSLocalizedString("Organization Information", comment: "")
                                  self.imgStep2.image = UIImage(named: "teal2.png")
                                                        self.imageStep1.image = UIImage(named:"gray1.png")
                                                        self.imgStep3.image = UIImage(named: "gray3.png")
           
        
       
        
           
       }
    
       func setupforThirdStage(){
        
        
           print(regStage2data)
        if Connectivity.isConnectedToInternet {
        let servicehandler = ServiceHandlers()
                  servicehandler.getQuestionListForCSO(){(responce,isSuccess) in
                              if isSuccess {
                                self.quesData = responce as? Dictionary<String,Any>
                                self.user_id = self.regStage2data!["user_id"] as? String
                                          self.stage1view.isHidden = true
                                          self.stage2view.isHidden = true
                                          self.stage3view.isHidden = false
                                       
                                       self.scrollerView.isHidden = true
                                       self.stage2ScrollView.isHidden = true
                                       self.stage3ScrollView.isHidden = false
                                       
                                       self.boolShowBackAlert = true
                                          self.lblStagesInformation.text = "More Information"
                                          self.imgStep2.image = UIImage(named: "gray2.png")
                                                                self.imageStep1.image = UIImage(named: "gray1.png")
                                                                self.imgStep3.image = UIImage(named: "teal3.png")
                              }else{
                                let alert = UIAlertController(title: "Error Occured", message: "Try Again Later", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                self.present(alert, animated: true)
                                
                    }

                                      }
          }else {
           
           let alert = UIAlertController(title: nil, message: NSLocalizedString("No Internet Connection", comment: ""), preferredStyle: UIAlertController.Style.alert)
           
           // add an action (button)
           alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
           // show the alert
           self.present(alert, animated: true, completion: nil)
           
       }
    
    }
    
}
