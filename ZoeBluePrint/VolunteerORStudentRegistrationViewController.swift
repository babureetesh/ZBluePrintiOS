//
//  VolunteerORStudentRegistrationViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 04/08/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolunteerORStudentRegistrationViewController: UIViewController,UITextFieldDelegate,UIActionSheetDelegate {

    //All TextFields for Volunteer
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var LastNameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PhoneNumber: UITextField!
    @IBOutlet weak var CityField: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var Address: UITextField!
   
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var VolunteerPassword: UIButton!
    @IBOutlet weak var VolunteerConfirmPassword: UIButton!
    
    @IBOutlet weak var volDOB: UIButton!
    
    var volDateOfBirth:String?
    var volGender:String?
    var volState:String?
    var volCountry:String?
    
    //All TextFields for Students
    @IBOutlet weak var StudentNameField: UITextField!
    @IBOutlet weak var StudentLastNameField: UITextField!
    @IBOutlet weak var StudentEmail: UITextField!
    @IBOutlet weak var StudentPhoneNumber: UITextField!
    @IBOutlet weak var StudentCityField: UITextField!
    @IBOutlet weak var StudentPostalCode: UITextField!
    @IBOutlet weak var studentAddressField: UITextField!
    @IBOutlet weak var StudentDOB: UITextField!
    @IBOutlet weak var StudentPassword: UITextField!
    @IBOutlet weak var StudentConfirmPassword: UITextField!
    @IBOutlet weak var showPasswordStudent: UIButton!
    @IBOutlet weak var showConfirmPasswordStudent: UIButton!
    
    
    // All StackView
    @IBOutlet weak var studentItemsStackView: UIStackView!
    @IBOutlet weak var volunteerItemsStackView: UIStackView!
    @IBOutlet weak var userSegmentControl: UISegmentedControl!
    @IBOutlet weak var studentScrollView: UIScrollView!
    @IBOutlet weak var volunteerScrollView: UIScrollView!
    
    @IBOutlet weak var selectVolunteerCountryButton: UIButton!
    @IBOutlet weak var selectVolunteerStateButton: UIButton!
    @IBOutlet weak var selectVolunteerGenderButton: UIButton!
    @IBOutlet weak var clearVolunteerButton: UIButton!
    @IBOutlet weak var registerVolunteerButton: UIButton!
    
    @IBOutlet weak var selectStudentCountryButton: UIButton!
    @IBOutlet weak var selectStudentStateButton: UIButton!
    @IBOutlet weak var selectStudentGenderButton: UIButton!
    @IBOutlet weak var clearStudentButton: UIButton!
    @IBOutlet weak var registerStudentButton: UIButton!
    
    var screenTitle = String()
    var Register = [String : Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Student Text Fields
        self.StudentNameField.delegate = self
        self.StudentLastNameField.delegate = self
        self.StudentEmail.delegate = self
        self.studentAddressField.delegate = self
        self.StudentDOB.delegate = self
        self.StudentPassword.delegate = self
        self.StudentCityField.delegate = self
        self.StudentPostalCode.delegate = self
        self.StudentPhoneNumber.delegate = self
        self.StudentConfirmPassword.delegate = self
        
        // Volunteer Text Fields
        self.NameField.delegate = self
        self.LastNameField.delegate = self
        self.CityField.delegate = self
        self.EmailField.delegate = self
        self.ConfirmPassword.delegate = self
        self.Address.delegate = self
        self.PhoneNumber.delegate = self
        self.postalCode.delegate = self
        self.Password.delegate = self
       // self.DateOfBirth.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil )
}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)// it will be hidden by touching anywhere on the page.
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            
           
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= 130.0
            }
           
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        
        //original code
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
       }
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        if(screenTitle.caseInsensitiveCompare("Registration Page") == .orderedSame){
            
            selectVolunteerCountryButton.setTitle("Country Name", for: .normal)
            selectVolunteerStateButton.setTitle("State Name", for: .normal)
            selectVolunteerGenderButton.setTitle("Gender", for: .normal)
            selectStudentCountryButton.setTitle("Country Name", for: .normal)
            selectStudentStateButton.setTitle("State Name", for: .normal)
            selectStudentGenderButton.setTitle("Gender", for: .normal)
            clearStudentButton.setTitle("Clear", for: .normal)
            clearVolunteerButton.setTitle("Clear", for: .normal)
            registerStudentButton.setTitle("Registration", for: .normal)
            registerVolunteerButton.setTitle("Registration", for: .normal)
            
            NameField.text = Register["First Name"] as? String
            StudentNameField.text = Register["First Name"] as? String
            
            LastNameField.text = Register["Last Name"] as? String
            StudentLastNameField.text = Register["Last Name"] as? String
            
            EmailField.text = Register["Email"] as? String
            StudentEmail.text = Register["Email"] as? String
            
            Address.text = Register["Address"] as? String
            studentAddressField.text = Register["Address"] as? String
            
           // DateOfBirth.text = Register["Date of Birth"] as? String
            StudentDOB.text = Register["Date of Birth"] as? String
            
            CityField.text = Register["City"] as? String
            StudentCityField.text = Register["City"] as? String
            
            postalCode.text = Register["Postal Code"] as? String
            StudentPostalCode.text = Register["Postal Code"] as? String
            
            PhoneNumber.text = Register["Phone Number"] as? String
            StudentPhoneNumber.text = Register["Phone Number"] as? String
            
            Password.text = Register["Password"] as? String
            StudentPassword.text = Register["Password"] as? String

            ConfirmPassword.text = Register["Confirm Password"] as? String
            StudentConfirmPassword.text = Register["Confirm Password"] as? String
            
        
            self.view.setNeedsLayout()
            self.viewDidLayoutSubviews()
            self.view.setNeedsUpdateConstraints()
            self.view.layoutIfNeeded()
        }
    }
   
    @IBAction func userSegmentChanged(_ sender: Any) {
        switch userSegmentControl.selectedSegmentIndex {
        case 0:
            volunteerScrollView.isHidden = false
            studentScrollView.isHidden = true
            
        case 1:
            volunteerScrollView.isHidden = true
            studentScrollView.isHidden = false
        default:
            print("default")
        }
    }


    
    @IBAction func volDOB(_ sender: Any) {
        let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "MM-dd-yyyy"
             
            var date = Date()
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
                // self.volDOB = dateString
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
    
    
    @IBAction func backbutton(_ sender: Any) {
        
        performSegueToReturnBack()
//        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectVolunteerCountryTapped(_ sender: Any) {

        let utility = Utility()
        utility.fetchCountryList{ (eventTypeList, isValueFetched) in
            if let list = eventTypeList {
                self.showPopoverForView1(view: sender, contents: list)
            }
        }
        
    }
    
    @IBAction func selectVolunteerStateClicked(_ sender: Any) {

        
        let utility = Utility()
        utility.fetchStateList{ (eventTypeList, isValueFetched) in
            if let list = eventTypeList {
                self.showPopoverForView2(view: sender, contents: list)
            }
        }
    }
    
    @IBAction func selectVolunteerGenderClicked(_ sender: Any) {
        let contents = ["Female","Male","Select Gender"]
        showPopoverForView(view: sender, contents: contents)
    }
    
    @IBAction func selectStudentCountryTapped(_ sender: Any) {
       
        let utility = Utility()
        utility.fetchCountryList{ (eventTypeList, isValueFetched) in
            if let list = eventTypeList {
                self.showPopoverForView1(view: sender, contents: list)
            }
        }
    }
    
    @IBAction func selectStudenttateClicked(_ sender: Any) {
     
        let utility = Utility()
        utility.fetchStateList{ (eventTypeList, isValueFetched) in
            if let list = eventTypeList {
                self.showPopoverForView2(view: sender, contents: list)
            }
        }
    }
    
    @IBAction func selectStudentGenderClicked(_ sender: Any) {
       let contents = ["Female","Male"]
        
    }
    
    
 
    @IBAction func clearStudentClicked(_ sender: Any) {
        resetAllEditableFieldOfContainer(container: studentItemsStackView)
    }
    @IBAction func registerStudentClicked(_ sender: Any) {
        
    }
    
    @IBAction func clearVolunteerlicked(_ sender: Any) {
        resetAllEditableFieldOfContainer(container: volunteerItemsStackView)
    }
    
    @IBAction func registerVolunteerClicked(_ sender: Any) {
        let params = [
        "user_type":"VOL",
        "user_device":UIDevice.current.identifierForVendor!.uuidString,
        "school_id":"1",
        "user_f_name":self.NameField.text as! String,
        "user_l_name": self.LastNameField.text as! String,
        "user_email": self.EmailField.text as!String,
        "user_phone":self.PhoneNumber.text as! String,
        "user_country": self.volCountry,
        "user_state": self.volState,
        "user_city": self.CityField.text as! String,
        "user_zipcode": self.postalCode.text as! String,
        "user_address":self.Address.text as! String,
        "user_dob":"12-12-1992",
        "user_gender":self.volGender,
        "user_pass":self.Password.text as! String
        ] as Dictionary<String,Any>
    }

    
    fileprivate func showPopoverForView(view:Any, contents:[String]) {
        let controller = DropDownItemsTable(contents)
        let senderButton = view as! UIButton
        controller.showPopoverInDestinationVC(destination: self, sourceView: view as! UIView) { (selectedValue) in
            let selectVal = selectedValue as! String
            //print(selectVal)
            switch selectVal{
            case "Male":
                self.volGender = "M"
                break
            case "Female":
                self.volGender = "F"
                break
            default:
                self.volGender = "O"
            }
            senderButton.setTitle(selectVal, for: .normal)
            senderButton.setImage(nil, for: .normal)
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
                self.volCountry = (selectVal[GetCountryServiceStrings.keyCountryId] as! String)
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
                self.volState = (selectVal[GetStateServiceStrings.keyStateId] as! String)
                senderButton.setTitle(title, for: .normal)
                senderButton.setImage(nil, for: .normal)
            }
        }
    

            }
    func resetAllEditableFieldOfContainer(container:UIStackView) {
        for view in container.subviews {
            if let textField = view as? UITextField {
                textField.text = ""
            } else if let button = view as? UIButton {
                button.setTitle("", for: .normal)
            }
        }
}
    
        func VolunteerShowPasswordButton(_ sender: Any) {
        self.Password.isSecureTextEntry = !self.Password.isSecureTextEntry
        switch self.Password.isSecureTextEntry {
        case true:
            VolunteerPassword.setImage(UIImage(named: "eye-close2.png"), for: .normal)
            break
            
        case false:
            VolunteerPassword.setImage(UIImage(named: "eye-open.png"), for: .normal)
            break
        }
    }
    
        func VolunteerShowConfirmpasswordButton(_ sender: Any) {
        self.ConfirmPassword.isSecureTextEntry = !self.ConfirmPassword.isSecureTextEntry
        switch self.ConfirmPassword.isSecureTextEntry {
        case true:
            VolunteerConfirmPassword.setImage(UIImage(named: "eye-close2.png"), for: .normal)
            break
            
        case false:
            VolunteerConfirmPassword.setImage(UIImage(named: "eye-open.png"), for: .normal)
            break
        }
    }
    
        func StudentShowPasswordButton(_ sender: Any) {
        self.StudentPassword.isSecureTextEntry = !self.StudentPassword.isSecureTextEntry
        switch self.StudentPassword.isSecureTextEntry {
        case true:
            showPasswordStudent.setImage(UIImage(named: "eye-close2.png"), for: .normal)
            break
            
        case false:
            showPasswordStudent.setImage(UIImage(named: "eye-open.png"), for: .normal)
            break
        }
    }
    
        func StudentShowConfirmPassword(_ sender: Any) {
        self.StudentConfirmPassword.isSecureTextEntry = !self.StudentConfirmPassword.isSecureTextEntry
        switch self.ConfirmPassword.isSecureTextEntry {
        case true:
            showConfirmPasswordStudent.setImage(UIImage(named: "eye-close2.png"), for: .normal)
            break
            
        case false:
            showConfirmPasswordStudent.setImage(UIImage(named: "eye-open.png"), for: .normal)
            break
        }
      }
    }

