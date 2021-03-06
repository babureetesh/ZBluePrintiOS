//
//  ChangePasswordCSO.swift
//  ZoeBlue//print
//
//  Created by Reetesh Bajpai on 06/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class ChangePasswordCSO: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var oldPassword: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var confirmPassword: UITextField!
    var strChange : String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        
        submitButton.layer.cornerRadius = 3.0
        submitButton.layer.masksToBounds = true
        
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        //print(userIDData)
        self.oldPassword.delegate = self
        self.newPassword.delegate = self
        self.confirmPassword.delegate = self
        
        var bottomlLine = CALayer()
        bottomlLine.frame = CGRect(x:0.0,y:oldPassword.frame.height-1,width:302.0,height:1.0)
      //  /*if defaults == "Light Mode" {
        bottomlLine.backgroundColor = UIColor.darkGray.cgColor
      //  } else   if defaults == "Dark Mode"{
        //     bottomlLine.backgroundColor = UIColor.lightGray.cgColor
        //}*/
        oldPassword.borderStyle = UITextField.BorderStyle.none
        oldPassword.layer.addSublayer(bottomlLine)
        
        var bottomlLine2 = CALayer()
               bottomlLine2.frame = CGRect(x:0.0,y:newPassword.frame.height-1,width:302.0,height:1.0)
       // /*if defaults == "Light Mode" {
            bottomlLine2.backgroundColor = UIColor.darkGray.cgColor
       // } else   if defaults == "Dark Mode"{
         //   bottomlLine2.backgroundColor = UIColor.lightGray.cgColor
        //}*/
               newPassword.borderStyle = UITextField.BorderStyle.none
               newPassword.layer.addSublayer(bottomlLine2)
        
        var bottomlLine3 = CALayer()
        bottomlLine3.frame = CGRect(x:0.0,y:confirmPassword.frame.height-1,width:302.0,height:1.0)
      // /* if defaults == "Light Mode" {
            bottomlLine3.backgroundColor = UIColor.darkGray.cgColor
        //} else   if defaults == "Dark Mode"{
          //  bottomlLine3.backgroundColor = UIColor.lightGray.cgColor
        //}*/
        confirmPassword.borderStyle = UITextField.BorderStyle.none
        confirmPassword.layer.addSublayer(bottomlLine3)
               
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
             
         }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
         btnBack.setImage(UIImage(named: "lefArrownew.png"), for: UIControl.State.normal)
        
//        if defaults == "Dark Mode"{
//
//
//            DarkMode()
//        }else if defaults == "Light Mode"{
//
//            LightMode()
//        }
    }
    
    func DarkMode() {
    
        view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.oldPassword.textColor = .white
        self.oldPassword.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        oldPassword.attributedPlaceholder = NSAttributedString(string: "Old Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.oldPassword.borderColor = .white
        
        self.newPassword.textColor = .white
        self.newPassword.backgroundColor = UIColor(red: 48.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        newPassword.attributedPlaceholder = NSAttributedString(string: "New Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        newPassword.borderColor = .white
        
        self.confirmPassword.textColor = .white
        self.confirmPassword.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        confirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        confirmPassword.borderColor = .white
        
    }
    func LightMode() {
     
        view.backgroundColor = .white
        self.oldPassword.textColor = .black
        self.oldPassword.backgroundColor = .white
        oldPassword.attributedPlaceholder = NSAttributedString(string: "Old Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.newPassword.textColor = .black
        self.newPassword.backgroundColor = .white
        newPassword.attributedPlaceholder = NSAttributedString(string: "New Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.confirmPassword.textColor = .black
        self.confirmPassword.backgroundColor = .white
        confirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        
        
        
        
    }
    
    
    
       @objc func keyboardWillShow(notification: NSNotification) {
             if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                 if self.view.frame.origin.y == 0 {
                     self.view.frame.origin.y -= 0.0
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
       
    func validatePassword(password: String) -> Bool
    {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"

        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)

        return passwordValidation.evaluate(with: password)
    }
    
    func validate() -> Bool {
    if (self.oldPassword.text == "" )
    {
    let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Old password is empty.", comment: ""), preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    return false
    }else  if (self.newPassword.text == "" )
    {
        let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("New password is empty", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return false
    }else  if !(self.validatePassword(password: self.newPassword.text!) )
    {
        let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Password must be at least 8 characters 1 uppercase 1 lowercase and 1 number", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return false
    }
    else  if (self.confirmPassword.text == "" )
    {
        let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Confirm password is empty.", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return false
    }
    else  if (self.newPassword.text != self.confirmPassword.text )
    {
        let alert = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("New password and confirm password are not same.", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return false
        }
    return true
    }
    
    @IBAction func btnChangePassword(_ sender: Any) {
        if (validate()){
            
                let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
                let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
                let userID = userIDData["user_id"] as! String
                var params = ["user_id":userID,
                              "user_pass_old":self.oldPassword.text!,
                              "user_pass_new":self.newPassword.text!,
                              "user_device": UIDevice.current.identifierForVendor!.uuidString,
                              "user_type": userIDData["user_type"] as! String
                ]
                //print(params)
                let serviceHanlder = ServiceHandlers()
                serviceHanlder.updatepassword(data:params) { (responce, isSuccess) in
                    if isSuccess {
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("Password change successfully", comment: ""), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: {(_action:UIAlertAction) -> Void in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true)
                    }else{
                        let json  = responce as? [String: Any]
                        let strMessage = json!["res_message"] as! String
                        let alert = UIAlertController(title: nil, message: strMessage, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: {(_action:UIAlertAction) -> Void in
                            //self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true)
                    }
                    
                }
                
            }
            
        }
    
    
    
    
    @IBAction func back_button(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
