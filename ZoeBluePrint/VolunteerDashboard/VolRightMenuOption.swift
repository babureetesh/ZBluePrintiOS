//
//  VolRightMenuOption.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 22/12/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import SideMenu
class VolRightMenuOption: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var coverPicture: UIImageView!
    @IBOutlet weak var lblnames: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var btlTimezone: UILabel!
    @IBOutlet weak var imageEditProfile: UIImageView!
    @IBOutlet weak var btnEditProfilePressed: UIButton!
    @IBOutlet weak var imageTimeZone: UIImageView!
    @IBOutlet weak var brtnTimeZone: UIButton!
    @IBOutlet weak var imageSetting: UIImageView!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var imageChangePassword: UIImageView!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var imageLogout: UIImageView!
    @IBOutlet weak var btnLogout: UIButton!
    var dataProfilePhoto:Data?
    var ImagePro:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.handleImageTap(_:)))
        self.profilePicture.isUserInteractionEnabled = true
               self.profilePicture.addGestureRecognizer(imageTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
       let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
               let params = userIDData["user_id"] as! String
        if let timeZone = userIDData["user_timezone"] {
            self.btlTimezone.text = timeZone as? String
        }else{
            self.btlTimezone.text = ""
        }
               let serivehandler = ServiceHandlers()
               serivehandler.editProfile(user_id: params){(responce,isSuccess) in
                   if isSuccess{
                       let data = responce as! Dictionary<String,Any>
                       
                    let firstname = data["user_f_name"] as! String
                    let lastname = data["user_l_name"] as! String
                    let names = "\(firstname) \(lastname)"
                       //print(names)
                    self.lblnames.text = names.uppercased()
                    print(names.uppercased())
                   }
               }
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
            if let image    = UIImage(contentsOfFile: imageURL.path){
                                    self.profilePicture.image = image
                                      self.profilePicture.layer.borderWidth = 1
                                      self.profilePicture.layer.masksToBounds = false
                                      self.profilePicture.layer.borderColor = UIColor.black.cgColor
                                      self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height/2
                                      self.profilePicture.clipsToBounds = true
            }
           // Do whatever you want with the image
        }
     
     }
    @objc func handleImageTap(_ sender: UITapGestureRecognizer? = nil) {
          let alert = UIAlertController(title: NSLocalizedString("UPLOAD FILES FROM", comment: ""), message: "", preferredStyle: .alert)
                 let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                     /** What we write here???????? **/
                      let image = UIImagePickerController()
                            image.delegate = self
                            image.sourceType = UIImagePickerController.SourceType.photoLibrary
                            image.allowsEditing = true
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
                            image.allowsEditing = true
                            self.present(image, animated: true)
                            {
                              //self.mainView.isHidden = false
                              
                              //self.backgroundView.isHidden = false
                            }
                            // call method whatever u need
                        })
        
                 let noButton = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
                 alert.addAction(gallery)
                 alert.addAction(camera)
                 alert.addAction(noButton)
                 present(alert, animated: true)
          
      }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profilePicture?.contentMode = .scaleAspectFill
            self.profilePicture?.backgroundColor = UIColor.clear
            self.profilePicture?.image = pickedImage
            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height/2
            self.profilePicture.clipsToBounds = true
            self.dataProfilePhoto = (pickedImage as? UIImage)!.jpegData(compressionQuality: 0.5)!
            
        }
        if let fileURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
             {
            self.ImagePro = fileURL.lastPathComponent
        }else{
            self.ImagePro = "image2"
        }
        //                let url = NSURL(string:self.ImagePro)
            performSegueToReturnBack()
//          self.dismiss(animated: true, completion: nil)
        ActivityLoaderView.startAnimating()
        self.uploadProfileImage()
      }

    
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController)    {
          dismiss(animated: true, completion: nil)
      }
      
     func uploadProfileImage() {
         
         let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
         let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
         
         let params = userIDData["user_id"] as! String
         let api_key = "1234"
         let action = "user_profile_pic_upload"
         
     let data2:[String:Any] = ["user_id":params,
                                   "api_key":api_key,
                                   "action":action,
                                   "img_name":ImagePro]
         print(data2)
         
         let serviceHanlder = ServiceHandlers()
     serviceHanlder.profilePicture(data2: data2, imgData: self.dataProfilePhoto!) { (responce, isSuccess) in
             if isSuccess {
                 let ImageResponse = responce as? [String: Any]
                 print(ImageResponse as Any)
               // let resdata = ImageResponse? ["res_data"] as! [String: Any]
               // let strProfilePicUrl = resdata["user_profile_pic"] as! String
                self.saveImageInDocsDir()
         
             }else{
               ActivityLoaderView.stopAnimating()
                 let alert = UIAlertController(title: "Error Occured!", message: "Please try again!", preferredStyle: UIAlertController.Style.alert)
                 alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                 self.present(alert, animated: true, completion: nil)
         }
         }
     }
    
  @IBAction func editProfile(_ sender: Any) {
      
    let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
             let change_timezone_view  = sampleStoryBoard.instantiateViewController(withIdentifier: "volreg") as! VolRegistration
             change_timezone_view.screen = "EDIT VIEW"
            // self.present(change_timezone_view, animated: true, completion: nil)
    SideMenuManager.defaultManager.menuRightNavigationController?.pushViewController(change_timezone_view, animated: true)
    
    }
    @IBAction func timeZoneChange(_ sender: Any) {
        
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let change_timezone_view  = sampleStoryBoard.instantiateViewController(withIdentifier: "changetimezonecso") as! ChangeTimezoneCSO
              // self.present(change_timezone_view, animated: true, completion: nil)
        
        SideMenuManager.defaultManager.menuRightNavigationController?.pushViewController(change_timezone_view, animated: true)
        
        
    }
    @IBAction func volSettings(_ sender: Any) {
        
        let lang : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let changeLanguage  = lang.instantiateViewController(withIdentifier: "language") as! Language
         self.navigationController?.pushViewController(changeLanguage, animated: true)
        
        
        
    }
    @IBAction func logout(_ sender: Any) {
        
        if let _  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as? Data {
            
            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.key_LoggedInUserData)
            
        }
        
        
//       let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//
//
     //   UserDefaults.standard.removeObject(forKey: UserDefaultKeys.key_LoggedInUserData)
       // UserDefaults.standard.synchronize()
//
//        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
//            //print("\(key) = \(value) \n")
//        }
//        let sb :UIStoryboard =  UIStoryboard(name: "Main", bundle:nil)
//        let homeView  = sb.instantiateViewController(withIdentifier: "login") as! ViewController
//        self.present(homeView, animated: true, completion: nil)
        
      //  self.dismiss(animated: false, completion: nil)
        self.removeImage(itemName: "profilepic", fileExtension: "jpg")
    UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "login")
        
    }
    
    func removeImage(itemName:String, fileExtension: String) {
      let fileManager = FileManager.default
      let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
      let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
      let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
      guard let dirPath = paths.first else {
          return
      }
      let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
      do {
        try fileManager.removeItem(atPath: filePath)
      } catch let error as NSError {
        print(error.debugDescription)
      }}
    
    @IBAction func volChangePassword(_ sender: Any) {
      
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let password  = storyboard.instantiateViewController(withIdentifier: "changepasswordcso") as! ChangePasswordCSO
       // self.present(password, animated: true, completion: nil)
        SideMenuManager.defaultManager.menuRightNavigationController?.pushViewController(password, animated: true)
        
}
    
    @IBAction func showOrganization(_ sender: Any) {
let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
       let org  = storyboard.instantiateViewController(withIdentifier: "organization") as! OrganizationViewController
        SideMenuManager.defaultManager.menuRightNavigationController?.pushViewController(org, animated: true)
//       self.present(org, animated: true, completion: nil)
        
      //  let vc = self.tabBarController?.viewControllers?[1] as! NewVolunteerDashboard
               //vc.strFromScreen = "DASHBOARD"
                //self.tabBarController?.selectedIndex = 0
        
        NotificationCenter.default.post(name: Notification.Name("showorg"), object: nil)
//       dismiss(animated: true, completion: nil)
        performSegueToReturnBack()
        
      
    }
    
    func DarkMode(){
        
        self.view.backgroundColor = .black
        self.btnLogout.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageLogout.image = UIImage(named: "lightlogout.png")
         self.btnSetting.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageSetting.image = UIImage(named: "lightnewSettings.png")
         self.btnChangePassword.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageChangePassword.image = UIImage(named: "lightPassword.png")
         self.btnEditProfilePressed.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageEditProfile.image = UIImage(named: "lightedit_user.png")
         self.brtnTimeZone.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.imageTimeZone.image = UIImage(named: "lightTime.png")
//        self.view.backgroundColor = .black
        self.mainView.backgroundColor = .black

        
        
    }
    func LightMode(){
        
        self.btnLogout.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnSetting.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnChangePassword.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.btnEditProfilePressed.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.brtnTimeZone.setTitleColor(UIColor.black, for: UIControl.State.normal)
         self.view.backgroundColor = .white
        self.mainView.backgroundColor = .white
//
    }

    func saveImageInDocsDir() {
        if !(self.dataProfilePhoto == nil) {
                        // get the documents directory url
                        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        // choose a name for your image
                        let fileName = "profilepic.jpg"
                        // create the destination file url to save your image
                        let fileURL = documentsDirectory.appendingPathComponent(fileName)
                        // get your UIImage jpeg data representation and check if the destination file url already exists
                            do {
                                // writes the image data to disk
                                try self.dataProfilePhoto!.write(to: fileURL, options: Data.WritingOptions.atomic)
                                print("file saved")
                                print(fileURL)
                            } catch {
                                print("error saving file:", error)
                            }
                      }
                ActivityLoaderView.stopAnimating()
            }
    
}
