//
//  RightMenuViewController.swift
//  ZoeBlue//print
//
//  Created by Reetesh Bajpai on 02/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//
//https://github.com/jonkykong/SideMenu

// CSO SIDE MENU
import UIKit
import SideMenu
class RightMenuViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnTimeZone: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var coverPicture: UIImageView!
    @IBOutlet weak var zonePressed: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var lblnames: UILabel!
    
    
    @IBOutlet weak var imageEdit: UIImageView!
    @IBOutlet weak var imageTimeZone: UIImageView!
    @IBOutlet weak var imageSetting: UIImageView!
    @IBOutlet weak var imageLogout: UIImageView!
    @IBOutlet weak var imagePassword: UIImageView!
    let image = UIImagePickerController()
    var dataProfilePhoto:Data?
    var ImagePro:String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
//        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
//        let params = userIDData["user_id"] as! String
//        print(params)
        
//        let timeZone =  UserDefaults.standard.object(forKey: UserDefaultKeys.key_userTimeZone) as! String
//        print(timeZone)
//        self.zonePressed.setTitle(timeZone, for: UIControl.State.normal)
//
        
        if let timeZone = UserDefaults.standard.object(forKey: UserDefaultKeys.key_userTimeZone){
            self.zonePressed.setTitle(timeZone as? String, for: UIControl.State.normal)
               }else{
                  // self.btlTimezone.text = ""
               }
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.handleImageTap(_:)))
        self.profilePicture.isUserInteractionEnabled = true
        self.profilePicture.addGestureRecognizer(imageTap)
        
        
    }
    @objc func handleImageTap(_ sender: UITapGestureRecognizer? = nil) {
        let alert = UIAlertController(title: NSLocalizedString("UPLOAD FILES FROM", comment: ""), message: "", preferredStyle: .alert)
               let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                   /** What we write here???????? **/
                   
                self.image.delegate = self
                self.image.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.image.allowsEditing = true
                self.present(self.image, animated: true)
                          {
                              
                          }
                   // call method whatever u need
               })
               let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
                          /** What we write here???????? **/
                         // let image = UIImagePickerController()
                self.image.delegate = self
                self.image.sourceType = UIImagePickerController.SourceType.camera
                self.image.allowsEditing = true
                self.present(self.image, animated: true)
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
                
               // return
        }else{
            self.ImagePro = "image2"
        }
        //                let url = NSURL(string:self.ImagePro)
            
          //self.dismiss(animated: true, completion: nil)
    self.image.dismiss(animated: true, completion: nil)
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
                     self.saveImageInDocsDir()
            ActivityLoaderView.stopAnimating()
                }else{
                  ActivityLoaderView.stopAnimating()
                    let alert = UIAlertController(title: "Error Occured!", message: "Please try again!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.profile_pic()
        

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
   
    func DarkMode() {
    
        view.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
       
        btnEditProfile.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imageEdit.image = UIImage(named: "lightedit_user.png")
        btnEditProfile.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)    //1
        
        btnTimeZone.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imageTimeZone.image = UIImage(named: "lightTime.png")
        btnTimeZone.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)    //2
        
        btnSetting.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imageSetting.image = UIImage(named: "lightnewSettings.png")
        btnSetting.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)    //3
        
        btnChangePassword.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imagePassword.image = UIImage(named: "lightPassword.png")
        btnChangePassword.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)    //4
        
        btnLogout.setTitleColor(UIColor.white, for: UIControl.State.normal)
        imageLogout.image = UIImage(named: "lightlogout.png")
        btnLogout.backgroundColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)    //5
        
    }
    
    func LightMode() {
    
          view.backgroundColor = .white
    }
    
        func profile_pic()  {
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            let params = userIDData["user_id"] as! String
            let serivehandler = ServiceHandlers()
            serivehandler.editProfile(user_id: params){(responce,isSuccess) in
                if isSuccess{
                    let data = responce as! Dictionary<String,Any>
                    let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
                        self.lblnames.textColor = .black
                
                    var firstname = data["user_f_name"] as! String
                     var lastname = data["user_l_name"] as! String
                      var names = "\(firstname) \(lastname)"
                      //print(names)
                    self.lblnames.text = names.uppercased()
                     
                    let string_url = data["user_profile_pic"] as! String

                     let profile_pic_string = data["user_cover_pic"] as! String
                    if let profile_url = URL(string: profile_pic_string){
                        do {
                        } catch {
                            //print("Unable to load data: \(error)")
                        }
                    }
                    
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
                


    @IBAction func EditProfile(_ sender: Any) {
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let change_timezone_view  = sampleStoryBoard.instantiateViewController(withIdentifier: "CSORegistrationViewController") as! CSORegistration
        change_timezone_view.screen = "EDIT VIEW"
       // self.present(change_timezone_view, animated: true, completion: nil)
        SideMenuManager.defaultManager.menuRightNavigationController?.pushViewController(change_timezone_view, animated: true)
        

    }
    
    @IBAction func TimeZone(_ sender: Any) {
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let change_timezone_view  = sampleStoryBoard.instantiateViewController(withIdentifier: "changetimezonecso") as! ChangeTimezoneCSO
        //self.present(change_timezone_view, animated: true, completion: nil)
        SideMenuManager.defaultManager.menuRightNavigationController?.pushViewController(change_timezone_view, animated: true)
    }
    
    @IBAction func TimeZoneEDT(_ sender: Any) {
        
        
    }

    @IBAction func Setting(_ sender: Any) {
        
        let lang : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let changeLanguage  = lang.instantiateViewController(withIdentifier: "language") as! Language
       self.navigationController?.pushViewController(changeLanguage, animated: true)
    }
    

    @IBAction func ChangePassword(_ sender: Any) {
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let change_password_view  = sampleStoryBoard.instantiateViewController(withIdentifier: "changepasswordcso") as! ChangePasswordCSO
      //  self.present(change_password_view, animated: true, completion: nil)
        SideMenuManager.defaultManager.menuRightNavigationController?.pushViewController(change_password_view, animated: true)
        
    }
    
    @IBAction func Logout(_ sender: Any) {
        if let _  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as? Data {
            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.key_LoggedInUserData)
        }
        
        self.removeImage(itemName: "profilepic", fileExtension: "jpg")
        NotificationCenter.default.post(name: Notification.Name("Removetabbar"), object: nil)
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
    
}
