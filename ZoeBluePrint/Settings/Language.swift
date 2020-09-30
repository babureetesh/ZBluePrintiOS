//
//  Language.swift
//  ZoeBluePrint
//
//  Created by HashTag Labs on 20/03/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class Language: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var btnBackPressed: UIButton!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var locationServicePressed: UISwitch!
    @IBOutlet weak var pushNotificationPressed: UISwitch!
    @IBOutlet weak var coverPhoto: UIButton!
    @IBOutlet weak var profilePic: UIButton!
    @IBOutlet weak var lblLocationService: UILabel!
    @IBOutlet weak var lblPushNotification: UILabel!
    @IBOutlet weak var lblTheme: UILabel!
    @IBOutlet weak var themePressed: UISwitch!
    @IBOutlet weak var languagePressed: UISwitch!
    @IBOutlet weak var lblLanguage: UILabel!
    var img:Data?
    var profilePhoto:Data?
    var imgName:String = ""
    var ImagePro:String = ""
    var profile:Bool?
    var proImage: String!
    var covImage: String!
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
if (self.proImage == "ProfileImageSelected") {
if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
{

self.profileImage.image = image
self.profilePhoto = (image as? UIImage)!.jpegData(compressionQuality: 0.5)!
guard let fileURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
    else {
        self.ImagePro = "image2"
        Images()
        return
}
//                let url = NSURL(string:self.ImagePro)
    self.ImagePro = fileURL.lastPathComponent
// //print(fileName)
self.ChooseProfileImage()
}else{
    //print("error")
    }
}else if (self.proImage != "ProfileImageSelected"){
if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
{
self.coverImage.image = image
self.img = (image as? UIImage)!.jpegData(compressionQuality: 0.5)!
guard let fileURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
    else {
        self.imgName = "Cover_image_name"
        return
}

self.imgName = fileURL.lastPathComponent
ChooseCoverImage()

}else{
//print("error")
}
    }
picker.dismiss(animated: true, completion: nil)

    }
    @IBAction func btnChooseCoverPic(_ sender: Any) {
    
        let alert = UIAlertController(title: NSLocalizedString("Upload cover image", comment: ""), message: "", preferredStyle: .alert)
        let gallery = UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
            /** What we write here???????? **/
            self.covImage = "CoverImageSelected"
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = false
            image.modalPresentationStyle = .overCurrentContext
            self.present(image, animated: true)
            {
                
            }
            self.Images()
            // call method whatever u need
        })
        let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: {(_ action: UIAlertAction) -> Void in
            /** What we write here???????? **/
            self.covImage = "CoverImageSelected"
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            imagePicker.modalPresentationStyle = .overCurrentContext
            imagePicker.showsCameraControls = true
            imagePicker.modalPresentationStyle = .overCurrentContext
            self.present(imagePicker, animated: true, completion: nil)
            self.Images()
            // call method whatever u need
        })
        let noButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(gallery)
        alert.addAction(camera)
        alert.addAction(noButton)
        present(alert, animated: true)
    
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnChooseProfilePic(_ sender: Any) {
     
        let alert = UIAlertController(title: "Upload profile image", message: "", preferredStyle: .alert)
        let gallery = UIAlertAction(title: "Gallery", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            /** What we write here???????? **/
            self.proImage = "ProfileImageSelected"
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            //  image.allowsEditing = false
            image.modalPresentationStyle = .overCurrentContext
            self.present(image, animated: true)
            {
                
            }
            // call method whatever u need
            self.Images()
        })
        let camera = UIAlertAction(title: "Camera", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            /** What we write here???????? **/
            self.proImage = "ProfileImageSelected"
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            imagePicker.modalPresentationStyle = .overCurrentContext
            imagePicker.showsCameraControls = true
            imagePicker.modalPresentationStyle = .overCurrentContext
            self.present(imagePicker, animated: true, completion: nil)
            // call method whatever u need
            self.Images()
        })
        let noButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(gallery)
        alert.addAction(camera)
        alert.addAction(noButton)
        present(alert, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        self.coverPhoto.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.profilePic.setTitleColor(UIColor.black, for: UIControl.State.normal)
        
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        
        if defaults == "Dark Mode" {
            
            DarkMode()
              self.themePressed.setOn(true, animated: false)
            
        }else
            if defaults == "Light Mode"{
                
            LightMode()
                 self.themePressed.setOn(false, animated: false)
                
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
      Images()
    }
    
    func Images() {
    
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let userID = userIDData["user_id"] as! String
        ////print(userID)
        let string_url = userIDData["user_profile_pic"] as! String
        
        
        if let url = URL(string: string_url){
            do {
                let imageData = try Data(contentsOf: url as URL)
                self.profileImage.image = UIImage(data: imageData)
                self.profileImage.layer.borderWidth = 1
                self.profileImage.layer.masksToBounds = false
                self.profileImage.layer.borderColor = UIColor.black.cgColor
                self.profileImage.layer.cornerRadius = self.profilePic.frame.height/2
                self.profileImage.clipsToBounds = true
            } catch {
                //print("Unable to load data: \(error)")
            }
        }
        let profile_pic_string = userIDData["user_cover_pic"] as! String
        if let profile_url = URL(string: profile_pic_string){
            do {
                let profile_data = try Data(contentsOf: profile_url as URL)
                self.coverImage.image = UIImage(data: profile_data)
                
            } catch {
                //print("Unable to load data: \(error)")
            }
        }
    }
    
   func ChooseProfileImage() {
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        
        let params = userIDData["user_id"] as! String
        let api_key = "1234"
        let action = "user_profile_pic_upload"
        
        var data2:[String:Any] = ["user_id":params,
                                  "api_key":api_key,
                                  "action":action,
                                  "img_name":ImagePro]
        print(data2)
        
        let serviceHanlder = ServiceHandlers()
    serviceHanlder.profilePicture(data2: data2, imgData: self.profilePhoto!) { (responce, isSuccess) in
            if isSuccess {
//
                let ImageResponse = responce as? [String: Any]
                print(ImageResponse)
            self.Images()
            }
            
        }
    }
    
    
    func ChooseCoverImage() {
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        
        let params = userIDData["user_id"] as! String
        let api_key = "1234"
        let action = "user_cover_pic_upload"
        
        var data2:[String:Any] = ["user_id":params,
                                  "api_key":api_key,
                                  "action":action,
                                  "img_name":imgName]
        print(data2)
        
        let imageSize: Int = img!.count
        let limit:Double = 2000.0
        if(Double(imageSize/1000) <= limit){
        
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.ProfileImage(data2: data2, imgData: self.img!){ (responce, isSuccess) in
            if isSuccess {
                
                let coverdata = responce as? [String: Any]
                print(coverdata)
                self.Images()
           }
            
        }
        }else{
            let alert = UIAlertController(title: nil, message: NSLocalizedString("Image must be less then 2 MB.", comment: ""), preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    
    }
    
    
    @IBAction func btnLanguage(_ sender: UISwitch) {
        
        if (sender.isOn){
            
            sender.onTintColor = .black
            sender.thumbTintColor = UIColor.white
            
        }else{
            
            sender.thumbTintColor = UIColor.black
            
            sender.layer.borderWidth = 2
            sender.layer.borderColor = UIColor.black.cgColor
            sender.layer.cornerRadius = 16
            
        }
        
        
    }
    
   @IBAction func btnTheme(_ sender: UISwitch) {
    
    
    if (sender.isOn){
        
        UserDefaults.standard.set("Dark Mode", forKey: "ChangeTheme")
        self.DarkMode()
        
    }else{
        
        UserDefaults.standard.set("Light Mode", forKey: "ChangeTheme")
        self.LightMode()
        
    }
    
    
    
    }
    
    func DarkMode() {
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1.0)
       
                   UITabBar.appearance().barTintColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1.0)
                   UITabBar.appearance().tintColor = .white
              
        
        self.lblLocationService.textColor = .white
        self.lblPushNotification.textColor = .white
        self.lblTheme.textColor = .white
        self.btnBackPressed.setImage(UIImage(named: "blackThemeImage.png"), for: UIControl.State.normal)
        self.coverPhoto.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.profilePic.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.view.backgroundColor = .black
        
        
    }
    
    func LightMode() {
        
              
               UITabBar.appearance().barTintColor = .white
               UITabBar.appearance().tintColor = .black

        
        self.lblLocationService.textColor = .black
        self.lblPushNotification.textColor = .black
        self.lblTheme.textColor = .black
        
        self.view.backgroundColor = .white
        
        
    }
    
    
    @IBAction func btnPushNotification(_ sender: UISwitch) {
        
        
        if (sender.isOn){
            
            sender.onTintColor = .black
            sender.thumbTintColor = UIColor.white
            
        }else{
            
            sender.thumbTintColor = UIColor.black
            
            sender.layer.borderWidth = 2
            sender.layer.borderColor = UIColor.black.cgColor
            sender.layer.cornerRadius = 16
            
        }
        
    }
    
    
    @IBAction func btnLocationService(_ sender: UISwitch) {
        
        
        if (sender.isOn){
            
            sender.onTintColor = .black
            sender.thumbTintColor = UIColor.white
            
        }else{
            
            sender.thumbTintColor = UIColor.black
            
            sender.layer.borderWidth = 2
            sender.layer.borderColor = UIColor.black.cgColor
            sender.layer.cornerRadius = 16
            
        }
        
        
        
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        if controller.documentPickerMode == UIDocumentPickerMode.import {
            
        }
        
        let cico = url as URL
        //print(cico)
        //print(url)
        
        // //print(url.lastPathComponent)
        do{
            self.img = try Data(contentsOf: url)
            
        } catch {
            //print(error)
        }
        
       
        
    }
    
    
    
}
