//
//  ForgetPassword.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 03/12/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class ForgetPassword: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var imgViewCsoCover: UIImageView!
    @IBOutlet weak var lblZoe: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblEnterYourRegistration: UILabel!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.delegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
              if self.view.frame.origin.y == 0
              {
                  self.view.frame.origin.y -= 50.0
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
    
    @IBAction func backButton(_ sender: Any) {
        performSegueToReturnBack()
//        self.dismiss(animated: true, completion: nil)
    }
    
    func isValidEmail(text:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: text)
       }
    
    @IBAction func SubmitBUtton(_ sender: Any) {
        
        if (txtEmail.text!.isEmpty) {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Enter Email", comment: ""), preferredStyle: .alert)
                                  alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                                  self.present(alert, animated: true)
            return
        }
        
        //forgotPassword
        if(self.isValidEmail(text: self.txtEmail.text!)){
          let serviceHanlder = ServiceHandlers()
        serviceHanlder.forgotPassword(user_email : self.txtEmail.text!) { (responce, isSuccess) in
                     if isSuccess {
                        
                        print(responce)
                        
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("Password reset link has been sent to your email id!", comment: ""), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                        self.present(alert, animated: true)
                        self.txtEmail.text = ""
                     }else{
                        
                       print(responce)
                        if(responce as! String! == "401"){
                            let alert = UIAlertController(title: nil, message: NSLocalizedString("Email id is not registered!", comment: ""), preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
                            self.present(alert, animated: true)
                            self.txtEmail.text = ""
                        }
                       
            }
                  }
        }else{
            
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Not a valid email", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    
    func DarkMode(){
    
        view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.lblEnterYourRegistration.textColor = .white
        self.txtEmail.textColor = .white
        
txtEmail.attributedPlaceholder = NSAttributedString(string: "Email*",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
       
        
        btnBack.setImage(UIImage(named: "iphoneButton"), for: UIControl.State.normal)
        
        lblZoe.textColor = .white
        
    }
    
    func LightMode(){
        
        
        self.view.backgroundColor = .white
        self.lblEnterYourRegistration.textColor = .black
        self.txtEmail.textColor = .black
        
txtEmail.attributedPlaceholder = NSAttributedString(string: "Email",
attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
       
        
        btnBack.setImage(UIImage(named: "iphoneButton"), for: UIControl.State.normal)
        lblZoe.textColor = .black
        
    }
    
    

}
