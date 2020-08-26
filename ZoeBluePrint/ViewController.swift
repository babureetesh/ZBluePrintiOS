//
//  ViewController.swift
//  ZoeBlueprint
//
//  Created by Reetesh Bajpai on 03/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: BaseViewController {
   
    @IBOutlet weak var lblLogIn: UILabel!    //1
    @IBOutlet weak var lblNewToZoe: UILabel!    //8
    @IBOutlet weak var btnClickHere: UIButton!
    @IBOutlet weak var btnRegisterHere: UIButton!   //9
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var lblUserName: UILabel!   //2
    @IBOutlet weak var lblPassword: UILabel!     //3
    @IBOutlet weak var txtUserName: UITextField!   //4
    @IBOutlet weak var txtPassword: UITextField!     //5
    @IBOutlet weak var btnLogin: UIButton!    //7
    @IBOutlet weak var btnShowPassword: UIButton!   //6
    
    
    override func viewDidLayoutSubviews() {
        addUnderLineToField(color: .black)
    }
    struct Connectivity {
      static let sharedInstance = NetworkReachabilityManager()!
      static var isConnectedToInternet:Bool {
          return self.sharedInstance.isReachable
        }
    }
    func addUnderLineToField(color:UIColor)  {
        txtUserName.setUnderLineOfColor(color: color)
        txtPassword.setUnderLineOfColor(color: color)        
    }
    func showIntroScreen(){
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objIntro  = storyboard.instantiateViewController(withIdentifier: "introscreen") as! IntroScreenViewController
        self.present(objIntro, animated: false, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if !(UserDefaults.standard.bool(forKey: "introshown")){
            
            self.showIntroScreen()
            UserDefaults.standard.set(true, forKey: "introshown")
        }
        
        // Do any additional setup after loading the view.
        addTextFieldEventHandling()
        customizeUIElements()
        self.txtUserName.delegate = self
        self.txtPassword.delegate = self
        
//        var bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y: txtUserName.frame.height-1, width: 290.0, height: 1.0)
//        bottomLine.backgroundColor = UIColor.black.cgColor
//        txtUserName.borderStyle = UITextField.BorderStyle.none
//        txtUserName.layer.addSublayer(bottomLine)
//               
//        var bottomLine2 = CALayer()
//        bottomLine2.frame = CGRect(x: 0.0, y: txtPassword.frame.height-1, width: 290.0, height: 1.0)
//        bottomLine2.backgroundColor = UIColor.black.cgColor
//        txtPassword.borderStyle = UITextField.BorderStyle.none
//         txtPassword.layer.addSublayer(bottomLine2)
               
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil )
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= 10.0
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.setNavigationBarHidden(toHide: true)
       
        
        
        
        
    }
 
    func customizeUIElements()  {
        btnLogin.layer.cornerRadius = 4
    }
    
    func addTextFieldEventHandling()  {
        txtUserName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func showPasswordButtonTapped(_ sender: Any) {
        self.txtPassword.isSecureTextEntry = !self.txtPassword.isSecureTextEntry
        switch self.txtPassword.isSecureTextEntry {
        case true:
            btnShowPassword.setImage(UIImage(named: "eye-close2.png"), for: .normal)
            break
            
        case false:
            btnShowPassword.setImage(UIImage(named: "eye-open.png"), for: .normal)
            break
        }
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let userName = txtUserName.text, isValidUserName(text: userName) else {
            highlightTextFieldForError(textField: txtUserName, label: lblUserName, placeHolder: NSLocalizedString("Invalid User Name", comment: ""))
            return
        }
       
        if Connectivity.isConnectedToInternet {
           
            callForLogin()
        
        } else {
             
            let alert = UIAlertController(title: nil, message: NSLocalizedString("No Internet Connection", comment: ""), preferredStyle: UIAlertController.Style.alert)
            
                        // add an action (button)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            // show the alert
                        self.present(alert, animated: true, completion: nil)
            
        }
   }
  
    @IBAction func registerButtonTapped(_ sender: Any) {
    }
    @IBAction func forgetPasswordButtonTapped(_ sender: Any) {
       let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "forgetPass") as! ForgetPassword
        self.present(obj, animated: true)
        
    }
    func addViewController(viewController:UIViewController)  {
        viewController.willMove(toParent: self)
        self.view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    func highlightTextFieldForError(textField:UITextField,label:UILabel, placeHolder:String) {
        textField.textColor = .red
        label.textColor = .red
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
    }
}

extension ViewController:UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let textFieldText = textField.text {
            if textField == txtUserName {
                textField.textColor = .red
                if isValidUserName(text: textFieldText) {
                    textField.textColor = .black
                }
            }
            if textField == txtPassword {
                if isValidPassword(text: textFieldText) {
                    textField.textColor = .black
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func isValidUserName(text:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
    func isValidPassword(text:String) -> Bool {
        return false
    
    }
    
    func callForLogin(){
    ActivityLoaderView.startAnimating()
            var userInfo =  [String:String]()
            userInfo[LoginServiceStrings.keyUserName] = txtUserName.text
            userInfo[LoginServiceStrings.keyPassword] = txtPassword.text
            
            let serviceHanlder = ServiceHandlers()
            serviceHanlder.autheticateUserForLoginService(userData: userInfo) { (response, isSuccess) in
                if isSuccess {
                    if let JSON = response as? [String: Any] {
                        let message = JSON["res_status"] as! String
                        //print(message)
                        if(message == "200"){
                            //********
                        
                            //print("LOGIN SuCCEssfull");
                            let loginTypeDict = JSON["res_data"] as? NSDictionary
                            //print(loginTypeDict!)
                            let loginTypeStr = loginTypeDict?["user_type"] as? String
                             let strUserStatus = loginTypeDict?["user_status"] as? String
                            if (strUserStatus == "10"){
                            if(loginTypeStr == "CSO"){
                                print("Login to CSO")
                                print(strUserStatus!)
                                if  let tabBarController = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "tabbar") as? UITabBarController {
                                    tabBarController.delegate = self as UITabBarControllerDelegate
                                    let loginData:Dictionary<String, Any> = (loginTypeDict as? Dictionary<String, Any>)!
                                    
                                    let encodedData = NSKeyedArchiver.archivedData(withRootObject: loginData)
                                    UserDefaults.standard.set(encodedData, forKey: UserDefaultKeys.key_LoggedInUserData)
                                    UserDefaults.standard.set(loginData["user_timezone"]as! String, forKey: UserDefaultKeys.key_userTimeZone)
                                   
                                    for viewController in tabBarController.viewControllers! {
                                        if let dashboardVC = viewController as? CSODashboardViewController {
                                            tabBarController.selectedViewController = dashboardVC
                                        }
                                    }
                                    self.present(tabBarController, animated: true, completion: nil)
                                }
                                
                            }else if(loginTypeStr == "VOL"){
                                 print("Login to VOL")
                                
                                print(strUserStatus!)
              
                if  let tabBarController = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "tab") as? UITabBarController {
                tabBarController.delegate = self as UITabBarControllerDelegate
                let loginData:Dictionary<String, Any> = (loginTypeDict as? Dictionary<String, Any>)!
                
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: loginData)
                UserDefaults.standard.set(encodedData, forKey: UserDefaultKeys.key_LoggedInUserData)
                if let usertimeZone = loginData["user_timezone"] as? String {
                    UserDefaults.standard.set(usertimeZone, forKey: UserDefaultKeys.key_userTimeZone)
                }
                    
                      
                for viewController in tabBarController.viewControllers! {
                    if let dashboardVol = viewController as? NewVolunteerDashboard {
                        tabBarController.selectedViewController = dashboardVol
                    }
                }
                    tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true, completion: nil)
        }
            }
        }else if (strUserStatus == "1"){
                                if (loginTypeStr == "CSO"){
                                    print("GO TO CSO second Stage")
                                    
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     let csoReg  = sampleStoryBoard.instantiateViewController(withIdentifier: "CSORegistrationViewController") as! CSORegistration
        csoReg.loadStage = "1"
       csoReg.regStage1data = loginTypeDict as? Dictionary<String, Any>
                                           self.present(csoReg, animated: true, completion: nil)
                                    
                                    
                                }else if (loginTypeStr == "VOL"){
                                    print("GO TO VOL OTP PAGE")
                                   
                                    let sb = UIStoryboard(name: "Main", bundle: nil)
                                    let phone_otp = sb.instantiateViewController(withIdentifier: "phoneotp") as! PhoneOtp
                                    
                                    phone_otp.phoneotp =  loginTypeDict?["phone_valid"] as? String
                                    phone_otp.user_id = loginTypeDict?["user_id"] as? String
                                    phone_otp.user_type = "VOL"
                                    phone_otp.modalPresentationStyle = .fullScreen
                                    self.present(phone_otp, animated: true)
                                }
                                }else if (strUserStatus == "2"){
                                print("GO TO CSO Third Stage")
                                
                                 let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let csoReg  = sampleStoryBoard.instantiateViewController(withIdentifier: "CSORegistrationViewController") as! CSORegistration
                                    csoReg.loadStage = "2"
                                csoReg.regStage2data = loginTypeDict as? Dictionary<String, Any>
                                csoReg.modalPresentationStyle = .fullScreen
                                self.present(csoReg, animated: true, completion: nil)
                            
                            }else if (strUserStatus == "3"){
                                print("GO TO CSO OTP PAGE")
                                
                            let sb = UIStoryboard(name: "Main", bundle: nil)
                            let phone_otp = sb.instantiateViewController(withIdentifier: "phoneotp") as! PhoneOtp
                                                           
                                                           phone_otp.phoneotp =  loginTypeDict?["phone_valid"] as? String
                                                           phone_otp.user_id = loginTypeDict?["user_id"] as? String
                                                           phone_otp.user_type = "CSO"
                                 phone_otp.modalPresentationStyle = .fullScreen
                                                           self.present(phone_otp, animated: true)
                            }else if (strUserStatus == "30"){
                                
                                let alertMessage = JSON["res_message"] as! String
                                AlertManager.shared.showAlertWith(title: NSLocalizedString("Your account is in verification process.", comment: ""), message: "")
                            }
                            //*******************
                            
              }else{
                            let alertMessage = JSON["res_message"] as! String
                            AlertManager.shared.showAlertWith(title: NSLocalizedString("Login Failed!", comment: ""), message: alertMessage)
                        }
                        ActivityLoaderView.stopAnimating()
                    } else {
                        ActivityLoaderView.stopAnimating()
                        AlertManager.shared.showAlertWith(title: NSLocalizedString("Error Occured!", comment: ""), message: NSLocalizedString("Please try again.", comment: ""))
                    }
                }
            }
        }
}

extension ViewController:UITabBarControllerDelegate {
  
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let csoDasboardVC = viewController as? CSODashboardViewController {
            removeAllOtherViewsOfVC(viewcontroller: csoDasboardVC)
            return true
        }
        if let csoEventVC = viewController as? CSOEventsViewController {
            removeAllOtherViewsOfVC(viewcontroller: csoEventVC)
            return true
        }
        if let CSOStudents = viewController as? volunteerSeeFollowers {
            removeAllOtherViewsOfVC(viewcontroller: CSOStudents)
            return true
        }
        if let csoMessageVC = viewController as? CSOMessagingViewController {
            removeAllOtherViewsOfVC(viewcontroller: csoMessageVC)
            return true
        }
        if let MessageVCs = viewController as? LockerViewController {
            removeAllOtherViewsOfVC(viewcontroller: MessageVCs)
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
