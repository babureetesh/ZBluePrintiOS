//
//  VolunteerEventDescription.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 08/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolunteerEventDescription: UIViewController {
   
  
    var eventData:[String:Any]?
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var whiteStar: FloatRatingView!
    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var lightStar: FloatRatingView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblRate: UILabel!
//    @IBOutlet weak var lblHeadingName: UILabel!
    
    @IBOutlet weak var lblRateThisEvent: UILabel!
    @IBOutlet weak var btnstatusViewTapped: UIButton!
    var data2:Array<Any>?
    var data1: Dictionary<String,Any>?
    var screen:String?
    @IBOutlet weak var starbuttonpressed: UIButton!
    @IBOutlet var view1: UIView!
    @IBOutlet weak var View2: UIView!
   
    
    @IBOutlet weak var scroller: UIScrollView!
    var imgName:String = ""
    @IBOutlet weak var SignedInEvent: FloatRatingView!
    
    @IBOutlet weak var UpdatingRating: FloatRatingView!
    
    @IBOutlet weak var ratingPresent: UILabel!
    
    @IBOutlet weak var Address2: UILabel!
    @IBOutlet weak var yesTapped: UIButton!
    @IBOutlet weak var ImageFromServer: UIImageView!
    
    @IBOutlet weak var DiscoverImage:UIImageView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    var event_id:String?
    
    @IBOutlet weak var txtviewDescription: UITextViewFixed!
    @IBOutlet weak var description2: UILabel!
    @IBOutlet weak var imgViewCoverPic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
// Do any additional setup after loading the view.
//
        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
        view1.isHidden = true
        View2.isHidden = true
//        //print(screen!)
       // performSegueToReturnBack()
         // //print(ruserok)
        SignedInEvent.delegate = self
        lightStar.delegate = self
        if self.screen == "UPCOMING EVENT" {
        
            self.event_id = data1!["event_id"] as? String
            //print(self.event_id)
            
        
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.getSelectedEventDetails(eventId: event_id!){(responds,isSuccess) in
            if isSuccess{
                
                var data = responds as! Dictionary<String,Any>
               
                var date_start = data["event_register_start_date"] as! String
                var date_end = data["event_register_end_date"] as! String
//                self.DateLabel.text = date_start + "-" + date_end
                
                var time_start = data["event_start_time_format"] as! String
                var time_end = data["event_end_time_format"] as! String
//                self.TimeLabel.text = time_start + "-" + time_end
                self.DateLabel.text = "\(date_start) - \(date_end)\n\(time_start) - \(time_end)"
                
                self.AddressLabel.text = data["event_address"] as! String
                self.DescriptionLabel.text = data["event_heading"] as! String
                //self.description2.text = data["event_details"] as! String
                //self.description2.sizeToFit()
                self.txtviewDescription.text = data["event_details"] as! String
                  var zip = data["event_postcode"] as! String
               let city = data["event_city"] as! String
                    let country = data["event_postcode"] as! String
                    let state = data["event_state_code"] as! String
                    let add = data["event_address"] as! String
                self.AddressLabel.text = add + "\n" + city + ", "  + state + " " + country
               let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
               var rate = Double(data["total_rating"] as! String) ?? 0.0
//                if defaults == "Dark Mode"{
//                self.lightStar.rating = rate
//                if rate == 0{
//                    self.ratingPresent.text = "No Ratings"
//                }
//                    self.SignedInEvent.isHidden = true
//                }else if defaults == "Light Mode"{
                    self.SignedInEvent.rating = rate
                    if rate == 0{
                        self.ratingPresent.text = "No Ratings"
                    }
                    self.lightStar.isHidden = true
                //}
                  
                   let strUrl = data["event_image"] as! String
        let replacedStr = strUrl.replacingOccurrences(of: " ", with: "%20")
                                                     
                let url = NSURL(string:replacedStr)
        if let data = try? Data(contentsOf: url! as URL)
                                     {
                           self.ImageFromServer.image = UIImage(data: data)
                                     }
                //print("Upcoming Events")
            }
//
                
            }
        }else if (data2 != nil){
            var list_details = data2 as! Array<Any>
            var dict_data = list_details[0] as! Dictionary<String,Any>
            
            var date_start = dict_data["event_register_end_date"] as! String
            var date_end = dict_data["event_register_end_date"] as! String
            var Date = "\(date_start) - \(date_end)"
            //print(Date)
//            self.DateLabel.text = Date as! String
            
            var time_start = dict_data["event_start_time_format"] as! String
            var time_end = dict_data["event_end_time_format"] as! String
            var Time = "\(time_start) - \(time_end)"
            //print(Time)
//            self.TimeLabel.text = Time as! String
            self.DateLabel.text = "\(date_start) - \(date_end)\n\(time_start) - \(time_end)"
            self.AddressLabel.text = dict_data["event_address"] as! String
            self.DescriptionLabel.text = dict_data["event_heading"] as! String
           // self.description2.text = dict_data["event_details"] as! String
            
            //self.description2.sizeToFit()
            self.txtviewDescription.text = dict_data["event_details"] as! String
             var zip = dict_data["event_postcode"] as! String
            let city = dict_data["event_city"] as! String
                let country = dict_data["event_postcode"] as! String
                let state = dict_data["event_state_code"] as! String
                let add = dict_data["event_address"] as! String
            self.AddressLabel.text = add + "\n" + city + ", "  + state + " " + country
           
             var rate = Double(dict_data["total_rating"] as! String) ?? 0.0
//            if defaults == "Dark Mode"{
//              self.lightStar.rating = Double(dict_data["total_rating"] as! String) ?? 0.0
//                if rate == 0{
//                    self.ratingPresent.text = "No Ratings"
//                }
//
//            }else if defaults == "Light Mode"{
                self.SignedInEvent.rating = Double(dict_data["total_rating"] as! String) ?? 0.0
                if rate == 0{
                    self.ratingPresent.text = "No Ratings"
                }
           // }
            
            
             let strUrl = dict_data["event_image"] as! String
                                                 let replacedStr = strUrl.replacingOccurrences(of: " ", with: "%20")
                                                 
                                     let url = NSURL(string:replacedStr)
                      if let data = try? Data(contentsOf: url! as URL)
                                 {
                       self.ImageFromServer.image = UIImage(data: data)
                                 }
            
        }
      else {
           
           
                 if self.screen == "DISCOVER EVENTS"{
                
        self.btnstatusViewTapped.setTitle("Shift", for: UIControl.State.normal)
                                }

let serviceHanlder = ServiceHandlers()
serviceHanlder.getSelectedEventDetails(eventId: self.event_id!){(responds,isSuccess) in
if isSuccess{
var list_details = responds as! Dictionary<String,Any>
var dict_data = list_details as! Dictionary<String,Any>
// self.event_id = dict_data["event_id"] as! String

var date_start = dict_data["event_register_start_date"] as! String
var date_end = dict_data["event_register_end_date"] as! String
var Date = "\(date_start) - \(date_end)"
//print(Date)
//self.DateLabel.text = Date as! String
var time_start = dict_data["event_start_time_format"] as! String
var time_end = dict_data["event_end_time_format"] as! String
var Time = "\(time_start) - \(time_end)"
//print(Time)
//self.TimeLabel.text = Time as! String
self.DateLabel.text = "\(date_start) - \(date_end)\n\(time_start) - \(time_end)"
self.AddressLabel.text = dict_data["event_address"] as! String
self.DescriptionLabel.text = dict_data["event_heading"] as! String
//self.description2.text = dict_data["event_details"] as! String

//self.description2.sizeToFit()
self.txtviewDescription.text = dict_data["event_details"] as! String
var zip = dict_data["event_postcode"] as! String

    let city = dict_data["event_city"] as! String
    let country = dict_data["event_postcode"] as! String
    let state = dict_data["event_state_code"] as! String
    let add = dict_data["event_address"] as! String
self.AddressLabel.text = add + "\n" + city + ", "  + state + " " + country
let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
     var rate = Double(dict_data["total_rating"] as! String) ?? 0.0
//    if defaults == "Dark Mode"{
//self.lightStar.rating = Double(dict_data["total_rating"] as! String) ?? 0.0
//        self.SignedInEvent.isHidden = true
//
//        if rate == 0{
//            self.ratingPresent.text = "No Ratings"
//        }
//    }else if defaults == "Light Mode"{
        self.SignedInEvent.rating = Double(dict_data["total_rating"] as! String) ?? 0.0
        self.lightStar.isHidden = true
        if rate == 0{
            self.ratingPresent.text = "No Ratings"
        }
   // }

let strUrl = dict_data["event_image"] as! String
let replacedStr = strUrl.replacingOccurrences(of: " ", with: "%20")

let url = NSURL(string:replacedStr)
if let data = try? Data(contentsOf: url! as URL)
{
self.ImageFromServer.image = UIImage(data: data)
}

//    self.view.layoutIfNeeded()
}
}
}
view.addSubview(scroller)
}
    override func viewWillLayoutSubviews(){
       super.viewWillLayoutSubviews()
       //scroller.contentSize = CGSize(width: 375, height: 600)
       }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getCoverImageForRank()
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profilepic.jpg")
            if let image    = UIImage(contentsOfFile: imageURL.path){
                                    self.profilePic.image = image
                                      self.profilePic.layer.borderWidth = 1
                                      self.profilePic.layer.masksToBounds = false
                                      self.profilePic.layer.borderColor = UIColor.black.cgColor
                                      self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2
                                      self.profilePic.clipsToBounds = true
            }
           // Do whatever you want with the image
        }
    }
    func getCoverImageForRank(){
          
          var strImageNameCover = "cover_cloud.jpg"
          
    let decoded  = UserDefaults.standard.object(forKey: "VolData") as! Data
              let volData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
              //print(volData)
              if (volData["user_avg_rank"] != nil){
                  if let userAvgRank = volData["user_avg_rank"] as? String {
                      
                     let floatUserAverageRank = Float(userAvgRank)!
                      
                         
                      if ((floatUserAverageRank >= 0) && (floatUserAverageRank <= 20)){
                          strImageNameCover = "cover_riseandshine.jpg"
                      }else if ((floatUserAverageRank > 20) && (floatUserAverageRank <= 40)){
                          strImageNameCover = "cover_cake.jpg"
                      }else if ((floatUserAverageRank > 40) && (floatUserAverageRank <= 60)){
                          strImageNameCover = "cover_cool.jpg"
                      }else if ((floatUserAverageRank > 60) && (floatUserAverageRank <= 80)){
                          strImageNameCover = "cover_truck.jpg"
                      }else if (floatUserAverageRank > 80 ){
                          strImageNameCover = "cover_cloud.jpg"
                      }
                     
                  }
              }
          self.imgViewCoverPic.image = UIImage(named:strImageNameCover)
          
          
      }
    
    func DarkMode(){
       
        mainView.backgroundColor = .black
        self.DateLabel.textColor = .white
        self.DateLabel.backgroundColor = .black
        
        self.TimeLabel.textColor = .white
        self.TimeLabel.backgroundColor = .black
        
        self.AddressLabel.textColor = .white
        self.AddressLabel.backgroundColor = .black
        
        self.DescriptionLabel.textColor = .white
        self.DescriptionLabel.backgroundColor = .black
        
        self.description2.textColor = .white
        self.description2.backgroundColor = .black
        
        self.lblRateThisEvent.textColor = .white
        self.View2.backgroundColor = .black
        
        self.btnList.setImage(UIImage(named: "newlist.png"), for: UIControl.State.normal)
        
    }
    func LightMode(){
        
        mainView.backgroundColor = .white
        
        self.btnList.setImage(UIImage(named: "newList.png"), for: UIControl.State.normal)
    }
       @IBAction func CloseButton(_ sender: Any) {
    
        performSegueToReturnBack()

    }
    @IBAction func notificationBellTapped(_ sender: Any) {
        
       let sb = UIStoryboard(name: "Main", bundle: nil)
        let obj = sb.instantiateViewController(withIdentifier: "noti") as! ProjectNotificationViewController
          present(obj,animated: true)
    }
    
    
@IBAction func ViewStatusButton(_ sender: Any) {
    
    
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let obj = sb.instantiateViewController(withIdentifier: "volunteershifts") as! VolunteerShifts
    obj.eventID = self.event_id
    
    self.navigationController?.pushViewController(obj, animated: true)
    }
    
    
    @IBAction func YesButton(_ sender: Any) {
        
        ActivityLoaderView.startAnimating()
        view1.isHidden = true
        View2.isHidden = true
        ActivityLoaderView.stopAnimating()
        
        //print(self.UpdatingRating.rating)
        
        
        //print(self.event_id)
        let rating = self.UpdatingRating.rating
        
        let strRating:String = String(format:"%f", rating)
        let fullRatingArr = strRating.components(separatedBy: ".")
                   let strIntRating = fullRatingArr[0]
        
                let serviceHanlder = ServiceHandlers()
        serviceHanlder.EventRating(event_id: self.event_id!, rating:strIntRating) { (responce, isSuccess) in
            if isSuccess{
                
                let data = responce as! String
                //print(data)
                let alert = UIAlertController(title: nil, message: data as! String, preferredStyle: UIAlertController.Style.alert)
                                                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                                                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                self.callforEventDetails()
                
            }else{
                let data = responce as! String
                              //print(data)
                              let alert = UIAlertController(title: nil, message: data as! String, preferredStyle: UIAlertController.Style.alert)
                                                                  
                                  alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                                                                  // show the alert
                                  self.present(alert, animated: true, completion: nil)
                self.callforEventDetails()
            }
     
      }
        
    }
    
    func callforEventDetails(){
        
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.getSelectedEventDetails(eventId: self.event_id!){(responds,isSuccess) in
            if isSuccess{
                
                var data = responds as! Dictionary<String,Any>
               //print(data)
                var date_start = data["event_register_start_date"] as! String
                var date_end = data["event_register_end_date"] as! String
//                self.DateLabel.text = date_start + "-" + date_end
                
                var time_start = data["event_start_time_format"] as! String
                var time_end = data["event_end_time_format"] as! String
//                self.TimeLabel.text = time_start + "-" + time_end
                self.DateLabel.text = "\(date_start) - \(date_end)\n\(time_start) - \(time_end)"
                self.AddressLabel.text = data["event_address"] as! String
                self.DescriptionLabel.text = data["event_heading"] as! String
                //self.description2.text = data["event_details"] as! String
               self.txtviewDescription.text = data["event_details"] as! String
               let city = data["event_city"] as! String
                    let country = data["event_postcode"] as! String
                    let state = data["event_state_code"] as! String
                    let add = data["event_address"] as! String
                self.AddressLabel.text = add + "\n" + city + ", "  + state + " " + country
  //              let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//                if defaults == "Dark Mode"{
//                self.lightStar.rating = Double(data["total_rating"] as! String) ?? 0.0
//                    self.SignedInEvent.isHidden = true
//                }else if defaults == "Light Mode"{
                self.SignedInEvent.rating = Double(data["total_rating"] as! String) ?? 0.0
                    self.lightStar.isHidden = true
              //  }
                
                let url = NSURL(string:data["event_image"] as! String)
                if let data = try? Data(contentsOf: url as! URL)
                {
                    self.ImageFromServer.image = UIImage(data: data)
                }
                
            }
            
                
            }
        
    }
    
    @IBAction func NoButton(_ sender: Any) {
        
        view1.isHidden = true
        View2.isHidden = true
    }
    
    
    @IBAction func starButtonTapped(_ sender: Any) {
        
        view1.isHidden = false
        View2.isHidden = false
    }
        
}

extension UIViewController {
    
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension VolunteerEventDescription: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        
        
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        
        view1.isHidden = false
        View2.isHidden = false
        
        
    }
    
}
