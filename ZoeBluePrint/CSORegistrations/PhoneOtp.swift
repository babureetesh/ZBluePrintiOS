//
//  PhoneOtp.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 18/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class PhoneOtp: UIViewController,UITextFieldDelegate {
var countdownTimer: Timer!
  var totalTime = 240

    var phoneotp:String?
    var user_id:String?
    var user_type:String?
    var flag:Bool?
    @IBOutlet weak var otptxtfld: UITextField!
    
    
    
    @IBOutlet weak var lblStatement: UILabel!
    
    @IBOutlet weak var lblVerifyNumber: UILabel!
    
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    
    
    @IBOutlet weak var timeExpirelbn: UILabel!
    
    
    @IBOutlet weak var btnResendOTP: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.otptxtfld.delegate = self
        
    var bottomlLine = CALayer()
    bottomlLine.frame = CGRect(x:0.0,y:otptxtfld.frame.height-1,width:321.0,height:1.0)
    bottomlLine.backgroundColor = UIColor.black.cgColor
    otptxtfld.borderStyle = UITextField.BorderStyle.none
    otptxtfld.layer.addSublayer(bottomlLine)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                 NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
     self.btnResendOTP.isHidden = true
         startTimer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        
        self.otptxtfld.text = self.phoneotp
        
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
    func startTimer() {
        self.flag = true
           countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       }
    @objc func updateTime() {
        self.timeExpirelbn.text  = NSLocalizedString("OTP expires in \(timeFormatted(totalTime)) Minutes", comment: "")

        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    func endTimer() {
           countdownTimer.invalidate()
        self.flag = false
        self.timeExpirelbn.isHidden = true
        self.btnResendOTP.isHidden = false
       }
    func timeFormatted(_ totalSeconds: Int) -> String {
           let seconds: Int = totalSeconds % 60
           let minutes: Int = (totalSeconds / 60) % 60
           //     let hours: Int = totalSeconds / 3600
           return String(format: "%02d:%02d", minutes, seconds)
       }


    @IBAction func ResendOTP(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func submit(_ sender: Any) {
        if(validate()){
            let params = ["user_id":self.user_id,
                          "user_type":self.user_type,
            "user_device":UIDevice.current.identifierForVendor!.uuidString ,
            "phone_otp":self.otptxtfld.text] as [String : Any]
            let servicehandler = ServiceHandlers()
            servicehandler.OTPvalidation(data: params){(responce,isSuccess) in
                if isSuccess{
                    
                    let otp_data = responce! as! Dictionary<String,Any>
                    if(otp_data["res_status"] as! String == "200"){
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("Mobile validate Successfully", comment: ""), preferredStyle: .alert)
                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "login")
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true)
                   
                    }else{
                        let alert = UIAlertController(title: nil, message: NSLocalizedString("Invalid OTP", comment: ""), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: {(a) in
                            self.otptxtfld.text = ""
                        }))
             self.present(alert, animated: true)
                    }
                }
            }
        }
        
    }
    
    
    func dismissPopAllViewViewControllers() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
            (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func back_button(_ sender: Any) {
        
        // Create the alert controller
        let alertController = UIAlertController(title: NSLocalizedString("CONFIRM EXIT?", comment: "") , message: NSLocalizedString("Are you sure you want to exit?", comment: ""), preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) {
            UIAlertAction in
            UIApplication.shared.keyWindow?.rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "login")
        }
        let cancelAction = UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func validate() -> Bool {
        if (self.otptxtfld.text == ""){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Text field is empty.", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert,animated:  true)
            return false
        }else if !(flag!){
            let alert = UIAlertController(title: nil, message: NSLocalizedString("OTP is expired", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
            self.present(alert,animated:  true)
            return false
        }
        return true
    }
}
