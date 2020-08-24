//
//  CSORegistrationViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 25/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class CSORegistrationViewController: UIViewController,UITextFieldDelegate {
    
    enum StepProgress:Int {
        case step1 = 1
        case step2 = 2
        case step3 = 3
    }
    
    @IBOutlet weak var step1NameField: UITextField!
    @IBOutlet weak var step2LastName: UITextField!
    @IBOutlet weak var step1EmailField: UITextField!
    @IBOutlet weak var Step1Phone: UITextField!
    
    
    
    @IBOutlet weak var Step1CityField: UITextField!
    @IBOutlet weak var Step1PostalCode: UITextField!
    @IBOutlet weak var Step1AddressField: UITextField!
    @IBOutlet weak var Step1DateOfBirth: UITextField!
    @IBOutlet weak var Step1Password: UITextField!
    @IBOutlet weak var Step1ConfirmPassword: UITextField!
    @IBOutlet weak var PasswordEyeTap: UIButton!
    @IBOutlet weak var ConfirmPasswordEyeTap: UIButton!
   
    
    @IBOutlet weak var step2SelectStateButton: UIButton!
    @IBOutlet weak var step2SelectCountryButton: UIButton!
    @IBOutlet weak var selectGenderButton: UIButton!
    @IBOutlet weak var selectCountryButton: UIButton!
    @IBOutlet weak var selectStateButton: UIButton!
    @IBOutlet weak var finalStepScrollView: UIScrollView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var initialStepClearButton: UIButton!
    @IBOutlet weak var secondStepIndicatorButton: UIButton!
    @IBOutlet weak var firstStepIndicatorButton: UIButton!
    @IBOutlet weak var thirdStepIndicatorButton: UIButton!
    
    @IBOutlet weak var firstStepMainStackView: UIStackView!
    @IBOutlet weak var secondStepMainStackView: UIStackView!
    @IBOutlet weak var finalStepStackView: UIStackView!
    var screen:String?
    var user_countryID:String?
    var user_stateID:String?
    var user_gender:String?
    var org_countryID:String?
    var org_stateID:String?
    var user_id:String?
  
    
    @IBOutlet weak var step2OrganizationEmail: UITextField!
    
    @IBOutlet weak var step2OranigationWebsite: UITextField!
    @IBOutlet weak var step2OrganizationPhone: UITextField!
    @IBOutlet weak var step2OrganizationName: UITextField!
    
    @IBOutlet weak var step2OrganizationMission: UITextField!
    
    @IBOutlet weak var step2OrganizationUploadButton: UIButton!
    @IBOutlet weak var step2txtFldOrganizationDocument: UITextField!
    @IBOutlet weak var step2OrganizationTaxID: UITextField!
    @IBOutlet weak var step2OrganizationAddress: UITextField!
    @IBOutlet weak var step2OrganizationZipCode: UITextField!
    @IBOutlet weak var step2OraganizationCity: UITextField!
    
    @IBOutlet weak var step2OrganizationCause: UITextField!
    
    @IBOutlet weak var step2OrganizationProfile: UITextField!
    
    // Third Step
    
    
    @IBOutlet weak var step3ProfitNonProfitYesButton: UIButton!
    @IBOutlet weak var step3ProfitNonProfitNoButton: UIButton!
    
    @IBOutlet weak var step3backgroundCheckYesButton: UIButton!
    
    @IBOutlet weak var step3backgroundCheckNoButton: UIButton!
    
    
    
    
    
    
    
    var registrationProgress:StepProgress = .step1
    //    var countryList = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        rearrangeViewWithProgress(stage: CSORegistrationViewController.StepProgress.step1)
        
        self.step1NameField.delegate = self
        self.step2LastName.delegate = self
        self.step1EmailField.delegate = self
        self.Step1Phone.delegate = self
        self.Step1CityField.delegate = self
        self.Step1PostalCode.delegate = self
        self.Step1AddressField.delegate = self
        self.Step1DateOfBirth.delegate = self
        self.Step1Password.delegate =  self
        self.Step1ConfirmPassword.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil )
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)              // it will be hidden by touching anywhere on the page.
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= 150.0
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(self.screen == "EDIT VIEW"){
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            let params = userIDData["user_id"] as! String
            let obj = ServiceHandlers()
            obj.editProfile(user_id: params){(responce,isSuccess) in
                if isSuccess{
                    let data = responce as! Dictionary<String,Any>
                    self.step1NameField.text = data["user_f_name"] as? String
                    self.step2LastName.text = data["user_l_name"] as? String
                    self.step1EmailField.text = data["user_email"] as? String
                   
                    
                    self.Step1Phone.text = data["user_phone"] as? String
                    self.Step1Phone.isEnabled = false
                   
                    
                    self.step1EmailField.isEnabled = false
                    self.selectCountryButton.setTitle(data["user_country_name"] as? String, for: .normal)
                    self.user_countryID = data["user_country"] as? String
                    self.selectStateButton.setTitle(data["user_state_name"] as? String, for: .normal)
                    self.user_stateID = data["user_state"] as? String
                    self.Step1CityField.text = data["user_city"] as? String
                    self.Step1PostalCode.text = data["user_zipcode"] as? String
                    self.Step1AddressField.text = data["user_address"] as? String
                    self.Step1DateOfBirth.text = data["user_dob"] as? String
                    if (data["user_gender"] as? String == "M" ){
                    self.selectGenderButton.setTitle("Male", for: .normal)
                        self.user_gender = data["user_gender"] as? String
                    }else if (data["user_gender"] as? String == "F" ){
                        self.selectGenderButton.setTitle("Female", for: .normal)
                        self.user_gender = data["user_gender"] as? String
                }else if (data["user_gender"] as? String == "O" ){
                        self.selectGenderButton.setTitle("Select Gender", for: .normal)
                        self.user_gender = data["user_gender"] as? String
                }
                    self.Step1Password.isHidden = true
                    self.ConfirmPasswordEyeTap.isHidden = true
                    self.PasswordEyeTap.isHidden = true
                    self.Step1ConfirmPassword.isHidden = true
                    self.step2OrganizationName.text = data["org_name"] as? String
                     self.step2OrganizationEmail.text = data["org_email"] as? String
                    self.step2OrganizationPhone.text = data["org_phone"] as? String
                    self.step2OranigationWebsite.text = data["org_website"] as? String
                    self.step2OrganizationMission.text = data["org_mission"] as? String
                    self.step2OrganizationCause.text = data["org_cause"] as? String
                    self.step2OrganizationProfile.text = data["org_profile"] as? String
                    self.step2OrganizationAddress.text = data["org_address"] as? String
                    self.step2OraganizationCity.text = data["org_city"] as? String
                    self.step2OrganizationZipCode.text = data["org_zipcode"] as? String
                    self.step2OrganizationTaxID.text = data["org_taxid"] as? String
                    self.step2SelectCountryButton.setTitle(data["org_country_name"] as? String, for: .normal)
                    self.org_countryID = data["org_country"] as? String
                    self.step2SelectStateButton.setTitle(data["org_state_name"] as? String, for: .normal)
                    self.org_stateID = data["org_state"] as? String
                    self.step2txtFldOrganizationDocument.isHidden = true
                    self.step2OrganizationUploadButton.isHidden = true
                    
                    
            }
        }
    }
    }
   
    
    @IBAction func btnNextClicked(_ sender: Any) {
        self.mainScrollView.setContentOffset(.zero, animated: false)
        
        if((sender as! UIButton).tag == 1){
            var params = ["user_type":"CSO",
                          "user_device": UIDevice.current.identifierForVendor!.uuidString,
                          "school_id": "",
                          "user_f_name": self.step1NameField.text as? String,
                          "user_l_name": self.step2LastName.text as? String,
                          "user_email": self.step1EmailField.text as? String,
                          "user_phone": self.Step1Phone.text as? String,
                          "user_country": self.user_countryID as? String,
                          "user_state": self.user_stateID as? String,
                          "user_city" : self.Step1CityField.text as? String,
                          "user_zipcode": self.Step1PostalCode.text as? String,
                          "user_address": self.Step1AddressField.text as? String,
                          "user_dob": self.Step1DateOfBirth.text as? String,
                          "user_gender": self.user_gender,
                          "user_pass": self.Step1Password.text as? String
            ]
         //   //print(params)
            let servicehandler = ServiceHandlers()
            servicehandler.csoRegistrationStage1(data: params){(responce,isSuccess) in
                if isSuccess{
                    let data = responce as! Dictionary<String,Any>
                    self.user_id = (data["user_id"] as! String)
                    self.user_stateID = ""
                    self.user_countryID = ""
                    
                }
            }
        }else if((sender as! UIButton).tag == 2){
            let params = ["user_id": self.user_id,
                          "user_type": "CSO",
                          "user_device": UIDevice.current.identifierForVendor!.uuidString,
                          "org_name": self.step2OrganizationName.text as? String,
                          "org_email": self.step2OrganizationEmail.text as? String,
                          "org_phone": self.step2OrganizationPhone.text as? String,
                          "org_website": self.step2OranigationWebsite.text as? String,
                          "org_mission": self.step2OrganizationMission.text as? String,
                          "org_cause": self.step2OrganizationCause.text as? String,
                          "org_profile": self.step2OrganizationProfile.text as? String,
                          "org_country": self.org_countryID,
                          "org_state": self.user_stateID,
                          "org_city": self.step2OraganizationCity.text as? String,
                          "org_zipcode": self.step2OrganizationZipCode.text as? String,
                          "org_address": self.step2OrganizationAddress.text as? String,
                          "org_taxid": self.step2OrganizationTaxID.text as? String
                          
            ]
            let servicehandler = ServiceHandlers()
                       servicehandler.csoRegistrationStage2(data: params){(responce,isSuccess) in
                           if isSuccess{
                               let data = responce as! Dictionary<String,Any>
                               self.user_id = (data["user_id"] as! String)
                           }
                       }
        }else if((sender as! UIButton).tag == 3){
            
        }
        
        if  sender is UIButton {
            let button = sender as! UIButton
            button.tag = button.tag + 1
            
            handleActionForNextButtonTapped(button: button)
        }
        view.layoutSubviews()
        
        
    }
    
    @IBAction func step2UploadOrganizationDocument(_ sender: Any) {
    }
    @IBAction func btnClearClicked(_ sender: Any) {
        switch registrationProgress {
        case .step1:
            _ = resetAllEditableFieldOfContainer(container: firstStepMainStackView)
        case .step2:
            _ =  resetAllEditableFieldOfContainer(container: secondStepMainStackView)
        case .step3:
            _ =  resetAllEditableFieldOfContainer(container: secondStepMainStackView)
        default:
          print("case not handled")
        }
    }
    
    func resetAllEditableFieldOfContainer(container:UIStackView) -> Bool {
        for view in container.subviews {
            if let textField = view as? UITextField {
                textField.text = ""
            } else if let button = view as? UIButton, container != finalStepStackView {
                button.setTitle("", for: .normal)
            }
        }
        return true
    }
    
    func rearrangeViewWithProgress(stage:StepProgress)  {
        registrationProgress = stage
        initialStepClearButton.tag = stage.rawValue
        switch stage {
        case .step1:
            finalStepScrollView.isHidden = true
            firstStepMainStackView.isHidden = false
            secondStepMainStackView.isHidden = true
            
            firstStepIndicatorButton.isEnabled = true
            secondStepIndicatorButton.isEnabled = false
            thirdStepIndicatorButton.isEnabled = false
            
        case .step2:
            finalStepScrollView.isHidden = true
            firstStepMainStackView.isHidden = true
            secondStepMainStackView.isHidden = false
            
            firstStepIndicatorButton.isEnabled = true
            secondStepIndicatorButton.isEnabled = true
            thirdStepIndicatorButton.isEnabled = false
            
        case .step3:
            mainScrollView.isHidden = true
            finalStepScrollView.isHidden = false
            
            firstStepIndicatorButton.isEnabled = true
            secondStepIndicatorButton.isEnabled = true
            thirdStepIndicatorButton.isEnabled = true
            
        default:
            print("case not handled")
        }
    }
    func handleActionForNextButtonTapped(button:UIButton)  {
        switch button.tag {
        case StepProgress.step1.rawValue:
            rearrangeViewWithProgress(stage: .step1)
        case StepProgress.step2.rawValue:
            rearrangeViewWithProgress(stage: .step2)
        case StepProgress.step3.rawValue:
            rearrangeViewWithProgress(stage: .step3)
        default:
            print("no action")
        }
    }
    
    @IBAction func moveToFirstStepClicked(_ sender: Any) {
        rearrangeViewWithProgress(stage: .step1)
    }
    
    @IBAction func moveToSecondStepClicked(_ sender: Any) {
        rearrangeViewWithProgress(stage: .step2)
    }
    
    @IBAction func moveToFinalStepClicked(_ sender: Any) {
        rearrangeViewWithProgress(stage: .step3)
    }
    
    @IBAction func selectCountryTapped(_ sender: Any) {
        let utility = Utility()
        utility.fetchCountryList { (countryList, isValueFetched) in
            if let list = countryList {
                self.showPopoverForView(view: sender, contents: list)
            }
        }
    }
    
    @IBAction func selectStateClicked(_ sender: Any) {
        let utility = Utility()
        utility.fetchStateList { (stateList, isValueFetched) in
            if let list = stateList {
                self.showPopoverForView(view: sender, contents: list)
            }
        }
    }
    
    @IBAction func selectGenderClicked(_ sender: Any) {
        let contents = ["Female","Male","Select Gender"]
        showPopoverForView(view: sender, contents: contents)
    }
    
    @IBAction func step2SelectCountyClicked(_ sender: Any) {
        let utility = Utility()
        utility.fetchCountryList { (countryList, isValueFetched) in
            if let list = countryList {
                self.showPopoverForView(view: sender, contents: list)
            }
        }
    }
    
    @IBAction func step2SelectStateClicked(_ sender: Any) {
        let utility = Utility()
        utility.fetchStateList { (stateList, isValueFetched) in
            if let list = stateList {
                self.showPopoverForView(view: sender, contents: list)
            }
        }
    }
    
@IBAction func PasswordEyeButtonPressed(_ sender: Any) {
    self.Step1Password.isSecureTextEntry = !self.Step1Password.isSecureTextEntry
    switch self.Step1Password.isSecureTextEntry {
    case true:
        PasswordEyeTap.setImage(UIImage(named: "eye-close2.png"), for: .normal)
        break
        
    case false:
        PasswordEyeTap.setImage(UIImage(named: "eye-open.png"), for: .normal)
        break
    }
    }
    
    @IBAction func ConfirmPasswordEyeButtonpressed(_ sender: Any) {
        self.Step1ConfirmPassword.isSecureTextEntry = !self.Step1ConfirmPassword.isSecureTextEntry
        switch self.Step1ConfirmPassword.isSecureTextEntry {
        case true:
            ConfirmPasswordEyeTap.setImage(UIImage(named: "eye-close2.png"), for: .normal)
            break
            
        case false:
            ConfirmPasswordEyeTap.setImage(UIImage(named: "eye-open.png"), for: .normal)
            break
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
            }
        }
    }
    
}
