//
//  ServiceHandlers.swift
//  ZoeBlueprint
//
//  Created by Rishi Chaurasia on 08/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import Alamofire

class ServiceHandlers {
   
   let baseURL = "https://zbp.progocrm.com/api/" // Staging
  // let baseURL = "https://www.zoeblueprint.com/api/" //Production
    
    enum serviceMthodType :String {
        
        case get = "GET"
        case POST = "POST"
    }
    
    init() {
        print("service handler init called")
    }
    
    var session:URLSession?
typealias CompletionHandler = (_ result:Any?,_ isSuccess:Bool)->Void;
    
//    func sendHTTPGetRequest(_ url: URLConvertible,
//                            method: HTTPMethod = .get,
//                            parameters: Parameters? = nil,
//                            encoding: ParameterEncoding = URLEncoding.default,
//                            headers: HTTPHeaders? = nil,
//                            onCompletion:@escaping CompletionHandler) {
//
//    }


    func getImageFromURL(url:URL, onCompletion:@escaping CompletionHandler) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        if session != nil {
            session?.invalidateAndCancel()
        }
        session = URLSession(configuration: sessionConfig)
        session?.dataTask(with: url) {
            (data, response, error) in
            onCompletion(data,true)
            }.resume()
    }
    func autheticateUserForLoginService(userData:[String:Any], onCompletion:@escaping CompletionHandler) {
        
        guard let userName = userData[LoginServiceStrings.keyUserName], let password = userData[LoginServiceStrings.keyPassword]  else {
            onCompletion(nil,false)
            return
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = formatter.string(from: date)
        let params = ["user_email": userName,
                      "user_pass": password,
                      "user_device": UIDevice.current.identifierForVendor!.uuidString,
                      "user_current_login":result]
        let urlString = baseURL+"user-access.php?api_key=1234&action=login"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    onCompletion(JSON,true)
                } else {
                    ActivityLoaderView.stopAnimating()
                    onCompletion(nil,false)
                }
                
               
                break
            case .failure(let error):
                //print(error)
                onCompletion(nil,false)
                ActivityLoaderView.stopAnimating()
                AlertManager.shared.showAlertWith(title: "Error Occured!", message: error.localizedDescription)
            }
        }
    }
    // Marking as: Volunteer Calender Events
    
    func VolunteerCalenderEvents(user_id:String, onCompletion:@escaping CompletionHandler)  {
        ActivityLoaderView.startAnimating()
        let param = ["user_id":user_id]
      //  //print(param)
       
        let urlString = baseURL+"vol-action.php?api_key=1234&action=vol_all_request"
        Alamofire.request(urlString, method: .post, parameters:param,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                   // //print(JSON)
                    let message = JSON["res_status"] as! String
                   // //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! Array<Any>
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                    }
                } else {
                     onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
              //  //print(error)
                onCompletion(nil,false)
            }
        }
    }
    func VolunteerNotification(user_id:String, onCompletion:@escaping CompletionHandler){
        
        ActivityLoaderView.startAnimating()
               let param = ["user_id":user_id]
        //print(param)
               
        let urlString = baseURL+"vol-action.php?api_key=1234&action=get_all_noti"
               Alamofire.request(urlString, method: .post, parameters:param,encoding: JSONEncoding.default, headers: nil).responseJSON {
                   response in
                   switch response.result {
                   case .success:
                       if let JSON = response.result.value as? [String: Any] {
                           //print(JSON)
                           let message = JSON["res_status"] as! String
                           //print(message)
                           if(message == "200"){
                               let eventData = JSON["res_data"] as! Array<Any>
                               onCompletion(eventData,true)
                               
                            ActivityLoaderView.stopAnimating()
                           }
                       } else {
                            onCompletion(nil,false)
                       }
                       break
                   case .failure(let error):
                       ActivityLoaderView.startAnimating()
                       //print(error)
                       onCompletion(nil,false)
                   }
               }
        
    
    }
    
    
    
    
    
    
    func getNotification(userData:String, onCompletion:@escaping CompletionHandler)  {
        ActivityLoaderView.startAnimating()
        let param = ["user_id":userData]
        let urlString = baseURL+"vol-action.php?api_key=1234&action=get_all_noti"
        Alamofire.request(urlString, method: .post, parameters:param,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! Array<Any>
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                    }else{
                        ActivityLoaderView.stopAnimating()
                        onCompletion(nil,false)
                    }
                } else {
                    ActivityLoaderView.stopAnimating()
                     onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    
func getDashboardUpComingEventData(userData:String, onCompletion:@escaping CompletionHandler)  {
    ActivityLoaderView.startAnimating()
     var strUserTimezone = "EST"
    let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
     if let timeZone = userIDData["user_timezone"] {
        strUserTimezone = timeZone as? String ?? "EST"
     }else{
        strUserTimezone = "EST"
     }
    
        let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.timeZone = NSTimeZone(abbreviation: strUserTimezone) as TimeZone?
    let result = formatter.string(from: date)
    
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM"
    let nameOfMonth = dateFormatter.string(from: now)
    
    let now1 = Date()
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "yyyy"
    let nameOfyear = dateFormatter1.string(from: now1)
    let params = ["user_id": userData,
                  "event_month": nameOfMonth,
                  "event_year": nameOfyear,
                  "countdown_date":result]
    print(params)
    
    let urlString = baseURL+"cso-action.php?api_key=1234&action=cso_dashboard_combine_mob"
    Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in
        switch response.result {
        case .success:
            if let JSON = response.result.value as? [String: Any] {
                //print(JSON)
                let message = JSON["res_status"] as! String
                //print(message)
                if(message == "200"){
                    let eventData = JSON["res_data"] as! [String: Any]
                    onCompletion(eventData,true)
                    ActivityLoaderView.stopAnimating()
                }else{
                    ActivityLoaderView.stopAnimating()
                    onCompletion(nil,false)
                }
            } else {
                ActivityLoaderView.stopAnimating()
                 onCompletion(nil,false)
            }
            break
        case .failure(let error):
            ActivityLoaderView.stopAnimating()
            //print(error)
            onCompletion(nil,false)
        }
    }
}

    func csoeditProfileStep1(data:Dictionary<String,Any>, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        //print(data)
       
        let urlString = baseURL+"user-access.php?api_key=1234&action=update_account"
        Alamofire.request(urlString, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        
                        onCompletion(JSON,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    ActivityLoaderView.stopAnimating()
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
    }
    func volCalenderEventList(data:Dictionary<String,Any>, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        //print(data)
       
        let urlString = baseURL+"vol-action.php?api_key=1234&action=vol_dashboard_combine"
        Alamofire.request(urlString, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        
                        onCompletion(JSON,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    ActivityLoaderView.stopAnimating()
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
    }
    func searchEvent(data:String, onCompletion:@escaping CompletionHandler)  {
           
           ActivityLoaderView.startAnimating()
           //print(data)
        let data1 = ["user_id":data] as Dictionary<String,Any>
           let urlString = baseURL+"cso-action.php?api_key=1234&action=my_volunteers"
           Alamofire.request(urlString, method: .post, parameters: data1,encoding: JSONEncoding.default, headers: nil).responseJSON {
               response in
               switch response.result {
               case .success:
                   if let JSON = response.result.value as? [String: Any] {
                       //print(JSON)
                       let message = JSON["res_status"] as! String
                       //print(message)
                       if(message == "200"){
                           let eventList = JSON["res_data"] as! Array<Any>
                           onCompletion(eventList,true)
                           ActivityLoaderView.stopAnimating()
                           
                       }else if(message == "401") {
                          
                           onCompletion(nil,true)
                         ActivityLoaderView.stopAnimating()
                       }
                   }
                   break
               case .failure(let error):
                   ActivityLoaderView.stopAnimating()
                   //print(error)
                   onCompletion(nil,false)
               }
           }
           
       }
    func csoRegistrationStage1(data:Dictionary<String,Any>, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        
       
        let urlString = baseURL+"user-access.php?api_key=1234&action=step1"
        Alamofire.request(urlString, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! [String: Any]
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }else {
                        ActivityLoaderView.stopAnimating()
                        onCompletion(JSON["res_message"],false)
                    }
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
    }
    func csoRegistrationStage2(data:Dictionary<String,Any>, onCompletion:@escaping CompletionHandler)  {
           
           ActivityLoaderView.startAnimating()
           
          
           let urlString = baseURL+"user-access.php?api_key=1234&action=csostep2"
           Alamofire.request(urlString, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseJSON {
               response in
               switch response.result {
               case .success:
                   if let JSON = response.result.value as? [String: Any] {
                       //print(JSON)
                       let message = JSON["res_status"] as! String
                       //print(message)
                       if(message == "200"){
                          ActivityLoaderView.stopAnimating()
                           onCompletion(JSON,true)
                           
                           
                       }
                   } else {
                    ActivityLoaderView.stopAnimating()
                       onCompletion(nil,false)
                   }
                   break
               case .failure(let error):
                   ActivityLoaderView.stopAnimating()
                   //print(error)
                   onCompletion(nil,false)
               }
           }
           
       }
    func csoRegistrationStage3(data:Dictionary<String,Any>, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        
       
        let urlString = baseURL+"user-access.php?api_key=1234&action=csostep3"
        Alamofire.request(urlString, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                       var data = JSON["res_data"] as! Dictionary<String,Any>
                        onCompletion(data,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
    }
       func OTPvalidation(data:Dictionary<String,Any>, onCompletion:@escaping CompletionHandler)  {
            
            ActivityLoaderView.startAnimating()
            
           
            let urlString = baseURL+"user-access.php?api_key=1234&action=validate_otp"
            Alamofire.request(urlString, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseJSON {
                response in
                switch response.result {
                case .success:
                    if let JSON = response.result.value as? [String: Any] {
                        //print(JSON)
                        let message = JSON["res_status"] as! String
                        //print(message)
                        if(message == "200"){
                          
                            ActivityLoaderView.stopAnimating()
                            onCompletion(JSON,true)
                           
                            
                        }
                     else if(message == "401"){
                        
                         ActivityLoaderView.stopAnimating()
                        onCompletion(JSON,true)
                       
                    }
                    }
                    break
                case .failure(let error):
                    ActivityLoaderView.stopAnimating()
                    //print(error)
                    onCompletion(nil,false)
                }
            }
            
        }
    func sendOTPtoMail(data:Dictionary<String,Any>, onCompletion:@escaping CompletionHandler)  {
           
           ActivityLoaderView.startAnimating()
           
          
           let urlString = baseURL+"user-access.php?api_key=1234&action=send_mail_otp"
           Alamofire.request(urlString, method: .post, parameters: data,encoding: JSONEncoding.default, headers: nil).responseJSON {
               response in
               switch response.result {
               case .success:
                   if let JSON = response.result.value as? [String: Any] {
                       //print(JSON)
                       let message = JSON["res_status"] as! String
                       //print(message)
                       if(message == "200"){
                         
                           ActivityLoaderView.stopAnimating()
                           onCompletion(JSON,true)
                          
                           
                       }
                    else if(message == "401"){
                       
                        ActivityLoaderView.stopAnimating()
                       onCompletion(JSON,true)
                      
                   }
                   }
                   break
               case .failure(let error):
                   ActivityLoaderView.stopAnimating()
                   //print(error)
                   onCompletion(nil,false)
               }
           }
           
       }
    
   func getQuestionListForCSO( onCompletion:@escaping CompletionHandler)  {
             
             ActivityLoaderView.startAnimating()
             
            
             let urlString = baseURL+"user-access.php?api_key=1234&action=cso_question_data"
             Alamofire.request(urlString, method: .post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
                 response in
                 switch response.result {
                 case .success:
                     if let JSON = response.result.value as? [String: Any] {
                         //print(JSON)
                         let message = JSON["res_status"] as! String
                         //print(message)
                         if(message == "200"){
                            var data = JSON["res_data"] as! Dictionary<String,Any>
                             onCompletion(data,true)
                             ActivityLoaderView.stopAnimating()
                             
                         }
                     } else {
                         onCompletion(nil,false)
                     }
                     break
                 case .failure(let error):
                     ActivityLoaderView.stopAnimating()
                     //print(error)
                     onCompletion(nil,false)
                 }
             }
             
         }
         
    
func getSelectedEventDetails(eventId:String, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        
        let params = ["event_id": eventId]
    //print(params)
        let urlString = baseURL+"cso-action.php?api_key=1234&action=get_event_detail"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! [String: Any]
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }else {
                        ActivityLoaderView.stopAnimating()
                        onCompletion(nil,false)
                    }
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
    }
    
    func getShiftDetails(shiftId:String, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        
        let params = ["shift_id": shiftId]
        let urlString = baseURL+"cso-action.php?api_key=1234&action=get_shift_detail"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! [String: Any]
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
    }
    func getAllShift(eventId:String, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        
        let params = ["event_id": eventId]
        let urlString = baseURL+"cso-action.php?api_key=1234&action=get_all_shift"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! [[String: Any]]
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }else if (message == "401"){
                        onCompletion(JSON,false)
                        ActivityLoaderView.stopAnimating()
                        }
                    
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
    }
    func deleteShiftForEventCSO(shift_id:String, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        
        let params = ["shift_id": shift_id]
        let urlString = baseURL+"cso-action.php?api_key=1234&action=d_shift"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON as! Dictionary<String,Any>
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }else if (message == "401"){
                        onCompletion(JSON,false)
                        ActivityLoaderView.stopAnimating()
                        }
                    
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
    }
    func getEventList(user_id:String, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        
        let params = ["user_id": user_id]
        let urlString = baseURL+"cso-action.php?api_key=1234&action=get_all_event"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! NSArray
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    
    func updatepassword(data:Dictionary<String,Any>, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()

        
        let urlString = baseURL+"user-access.php?api_key=1234&action=change_pass_mob"
        Alamofire.request(urlString, method: .post, parameters:data,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON as NSDictionary
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }else{
                        let eventData = JSON as NSDictionary
                        onCompletion(eventData,false)
                        ActivityLoaderView.stopAnimating()
                    }
                } else {
                    ActivityLoaderView.stopAnimating()
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    func publishUnpublishEvent(user_id:String, user_type:String, event_id:String, action_type:String, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        let params = ["user_id": user_id,
                      "user_type": user_type,
                      "user_device": UIDevice.current.identifierForVendor!.uuidString,
                      "event_id":event_id,
                      "action_type":action_type]
        //print(params)
        let urlString = baseURL+"cso-action.php?api_key=1234&action=p_event"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                   // let arrjson = JSON .object(at: 2) as? NSDictionary
                    let message = JSON["res_status"] as! String
                    
                    ////print(message)
                    if(message == "200"){
                        let eventData = JSON 
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    func updateShift(data_details:[String:Any], onCompletion:@escaping CompletionHandler){
           
           ActivityLoaderView.startAnimating()
        //print(data_details)
           
        
           let urlString = baseURL+"cso-action.php?api_key=1234&action=u_shift"
           Alamofire.request(urlString, method: .post, parameters: data_details,encoding: JSONEncoding.default, headers: nil).responseJSON {
               response in
               switch response.result {
               case .success:
                   if let JSON = response.result.value as? [String: Any] {
                       //print(JSON)
                       let message = JSON["res_status"] as! String
                       //print(message)
                       if(message == "200"){
                           let eventData = JSON["res_message"] as! String
                           //print(eventData)
                           ActivityLoaderView.stopAnimating()
                          onCompletion(eventData,true)
                        
                    }
                   }
                   break
               case .failure(let error):
                   ActivityLoaderView.stopAnimating()
                   //print(error)
                   onCompletion(nil,false)
               }
           }
       }
    
    // Mark: Unlink (See Followers)
    func UnlinkFollowers(params:[String:Any], onCompletion:@escaping CompletionHandler){
              
              ActivityLoaderView.startAnimating()
           //print(params)
              
           
              let urlString = baseURL+"user-access.php?api_key=1234&action=unlink_user"
              Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
                  response in
                  switch response.result {
                  case .success:
                      if let JSON = response.result.value as? [String: Any] {
                          //print(JSON)
                          let message = JSON["res_status"] as! String
                          //print(message)
                          if(message == "200"){
                              let eventData = JSON["res_data"] as! String
                              //print(eventData)
                              ActivityLoaderView.stopAnimating()
                             onCompletion(eventData,true)
                           
                       }
                      }
                      break
                  case .failure(let error):
                      ActivityLoaderView.stopAnimating()
                      //print(error)
                      onCompletion(nil,false)
                  }
              }
          }
    
    func deleteEvent(event_id:String, onCompletion:@escaping CompletionHandler)  {
        ActivityLoaderView.startAnimating()
        let params = ["event_id": event_id]
        let urlString = baseURL+"cso-action.php?api_key=1234&action=d_event"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                      let eventData = JSON as? [String: Any]
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    func duplicateEvent(event_id:String, onCompletion:@escaping CompletionHandler)  {
        ActivityLoaderView.startAnimating()
        /*
         {
         "user_id":"C1234563453",
         "event_id":"1",
         "user_type":"CSO",
         "user_device" :"123456"
         }
         
         */
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let params = ["user_id":userIDData["user_id"] as! String,"event_id": event_id,"user_type":"CSO","user_device": UIDevice.current.identifierForVendor!.uuidString]
        let urlString = baseURL+"cso-action.php?api_key=1234&action=dup_event"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON as? [String: Any]
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    
    func selectCountry(onCompletion:@escaping CompletionHandler)  {
        ActivityLoaderView.startAnimating()
       
        let urlString = baseURL+"master-data.php?api_key=1234&action=scountry"
        Alamofire.request(urlString, method: .post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let countryData = JSON as? [String: Any]
                        onCompletion(countryData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    
    func getStateList(country_id:String, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        
        let params = ["country_id": country_id]
        let urlString = baseURL+"master-data.php?api_key=1234&action=sstate"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let stateData = JSON["res_data"] as! NSArray
                        onCompletion(stateData,true)
                        ActivityLoaderView.stopAnimating()
                        }
                } else {
                    ActivityLoaderView.stopAnimating()
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    
    func updateEvent(event_id:String,event_type_id:String,event_heading:String,event_details:String,event_address:String,event_country:String,event_state:String,event_city:String,event_postcode:String,event_timezone:String,event_latitude:String,event_longitude:String,event_email:String,event_phone:String,event_image:String,event_register_start_date:String, event_register_end_date:String,event_end_time:String,event_start_time:String,event_waiver_doc:String,event_waiver_req:String, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        
        let params = ["event_id":event_id,
                      "event_type_id":event_type_id,
                      "event_heading":event_heading,
                      "event_details":event_details,
                      "event_address":event_address,
                      "event_country":event_country,
                      "event_state":event_state,
                      "event_city":event_city,
                      "event_postcode":event_postcode,
                      "event_timezone":event_timezone,
                      "event_latitude":event_latitude,
                      "event_longitude":event_longitude,
                      "event_email":event_email,
                      "event_phone":event_phone,
                      "event_image":event_image,
                      "event_waiver_doc": event_waiver_doc,
                      "event_end_time": event_end_time,
                      "event_start_time": event_start_time,
                      "event_register_start_date":event_register_start_date,
                      "event_register_end_date":event_register_end_date,
                      "event_waiver_req":event_waiver_req
                      
        ]
       
        //print(params)
        let urlString = baseURL+"cso-action.php?api_key=1234&action=u_event"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let stateData = JSON as! NSDictionary
                        onCompletion(stateData,true)
                        ActivityLoaderView.stopAnimating()
                    }
                } else {
                    ActivityLoaderView.stopAnimating()
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    
    func addEvent(event_type_id:String,event_heading:String,event_details:String,event_address:String,event_country:String,event_state:String,event_city:String,event_postcode:String,event_timezone:String,event_latitude:String,event_longitude:String,event_email:String,event_phone:String,event_image:String,event_register_start_date:String, event_register_end_date:String,event_start_time:String,event_end_time:String,event_waiver_doc:String,event_waiver_req:String, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        
        let params = ["user_id":userIDData["user_id"] as! String,
                      "event_type_id":event_type_id,
                      "event_heading":event_heading,
                      "event_details":event_details,
                      "event_address":event_address,
                      "event_country":event_country,
                      "event_state":event_state,
                      "event_city":event_city,
                      "event_postcode":event_postcode,
                      "event_timezone":event_timezone,
                      "event_latitude":event_latitude,
                      "event_longitude":event_longitude,
                      "event_email":event_email,
                      "event_phone":event_phone,
                      "event_image":event_image,
                      "event_register_start_date":event_register_start_date,
                      "event_register_end_date":event_register_end_date,
                      "event_start_time":event_start_time,
                      "event_end_time":event_end_time,
                      "event_waiver_doc":event_waiver_doc,
                      "event_waiver_req":event_waiver_req]
        let urlString = baseURL+"cso-action.php?api_key=1234&action=i_event"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let stateData = JSON["res_data"] as! NSDictionary
                        onCompletion(stateData,true)
                        ActivityLoaderView.stopAnimating()
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    func getShiftList(onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        /*
         "user_id":"C20190425J8jJm1iI5U5" }
         
         */
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        
        let params = ["user_id":userIDData["user_id"] as! String]
        let urlString = baseURL+"cso-action.php?api_key=1234&action=shift_task_list_cso"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                   if(message == "200"){
                        let ShiftList = JSON["res_data"] as! NSArray
                        let sortedArray = (ShiftList as NSArray).sortedArray(using: [NSSortDescriptor(key: "shift_task_name", ascending: true)]) as! [[String:AnyObject]]

                        onCompletion(sortedArray,true)
                        ActivityLoaderView.stopAnimating()
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    
    //Mark: Pre-filled Data
       
   func TimeFilledData(params:[String:Any],onCompletion:@escaping CompletionHandler) {
               
               ActivityLoaderView.startAnimating()
               
            

               //print(params)
               let url = baseURL+"cso-action.php?api_key=1234&action=mark_hours_completed"
               Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default
                   , headers: nil).responseJSON {
                       response in
                    switch response.result {
                       case .success:
                           if let JSON = response.result.value as? [String: Any] {
                               //print(JSON)
                               let message = JSON["res_status"] as! String
                               //print(message)
                               if(message == "200"){
                                   ActivityLoaderView.stopAnimating()
                              onCompletion(JSON["res_message"],true)
                               } else {
                                   ActivityLoaderView.stopAnimating()
                                   onCompletion(nil,false)
                                                   }
                           }
                           break
                       case .failure(let error):
                           ActivityLoaderView.startAnimating()
                           //print(error)
                           onCompletion(nil,false)
                       }
               }
           }
    
    //Mark: Filter Events Vol
        
    func FilterEvents(params:[String:Any],onCompletion:@escaping CompletionHandler) {
                
                ActivityLoaderView.startAnimating()
         
                //print(params)
    let url = baseURL+"search-event.php?api_key=1234&action=search_event_filter_vol"
                Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default
                    , headers: nil).responseJSON {
                        response in
                     switch response.result {
                        case .success:
                            if let JSON = response.result.value as? [String: Any] {
                                //print(JSON)
                                let message = JSON["res_status"] as! String
                                print(message)
                                if(message == "200"){
                                    ActivityLoaderView.stopAnimating()
                               onCompletion(JSON["res_data"],true)
                                } else {
                                    ActivityLoaderView.stopAnimating()
                                    onCompletion(nil,false)
                                                    }
                            }
                            break
                        case .failure(let error):
                            ActivityLoaderView.startAnimating()
                            //print(error)
                            onCompletion(nil,false)
                        }
                }
            }
     
    //Mark: VolunteerChangeHours
    
    func ChangeHours(data:[String:Any],onCompletion:@escaping CompletionHandler) {
            
            ActivityLoaderView.startAnimating()
            
        //print(data)
            let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
            let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
            
        
            let url = baseURL+"cso-action.php?api_key=1234&action=mark_hours"
            Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default
                , headers: nil).responseJSON {
                    response in
                 switch response.result {
                    case .success:
                        if let JSON = response.result.value as? [String: Any] {
                            //print(JSON)
                            let message = JSON["res_status"] as! String
                            //print(message)
                            if(message == "200"){
                                ActivityLoaderView.stopAnimating()
                           onCompletion(nil,true)
                            } else {
                                ActivityLoaderView.stopAnimating()
                                onCompletion(nil,false)
                                                }
                        }
                        break
                    case .failure(let error):
                        ActivityLoaderView.startAnimating()
                        //print(error)
                        onCompletion(nil,false)
                    }
            }
        }
    func DiscoveringEvents(search_row_number:String,search_keyword:String,search_page_size:String,search_city:String,search_event_type:String,search_org:String,search_postcode:String,search_state:String,onCompletion:@escaping CompletionHandler) {
         
         ActivityLoaderView.startAnimating()
         
         let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
         let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
         
         let params = [
             "seach_row_number":"0",
             "search_keyword":search_keyword,
             "search_page_size":"10",
             "search_city":search_city,
             "search_event_type":search_event_type,
             "search_org":search_org,
             "search_postcode":search_postcode,
             "search_state":search_state]
         //print(params)
         let url = baseURL+"search-event.php?api_key=1234&action=search_event_filter_vol"
         Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default
             , headers: nil).responseJSON {
                 response in
              switch response.result {
                 case .success:
                     if let JSON = response.result.value as? [String: Any] {
                         //print(JSON)
                         let message = JSON["res_status"] as! String
                         //print(message)
                         if(message == "200"){
                             let zipcode = JSON["res_data"] as! NSArray
                             onCompletion(zipcode,true)
                             ActivityLoaderView.stopAnimating()
                         } else {
                                                 ActivityLoaderView.stopAnimating()
                                                 onCompletion(nil,false)
                                             }
                     }
                     break
                 case .failure(let error):
                     ActivityLoaderView.startAnimating()
                     //print(error)
                     onCompletion(nil,false)
                 }
         }
     }
    func searchEvents(search_keyword:String,seach_row_number:String,search_page_size:String, onCompletion:@escaping CompletionHandler){
        
        ActivityLoaderView.startAnimating()
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        let date = Date()
        let formatter = DateFormatter()
         formatter.dateFormat = "MM-dd-yyyy"
        let current_date = formatter.string(from: date)
        let params = [
            "search_keyword":search_keyword,
            "seach_row_number":"0",
            "search_page_size":search_page_size,
            "current_date":current_date]
        //print(params)
        let url = baseURL + "search-event.php?api_key=1234&action=search_event"
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default
            , headers: nil).responseJSON {
                response in
                switch response.result {
                case .success:
                    if let JSON = response.result.value as? [String: Any] {
                        //print(JSON)
                        let message = JSON["res_status"] as! String
                        //print(message)
                        if(message == "200"){
                            let zipcode = JSON["res_data"] as! NSArray
                            onCompletion(zipcode,true)
                            ActivityLoaderView.stopAnimating()
                        }
                    } else {
                        ActivityLoaderView.stopAnimating()
                        onCompletion(nil,false)
                    }
                    break
                case .failure(let error):
                    ActivityLoaderView.stopAnimating()
                    //print(error)
                    onCompletion(nil,false)
                }
        }
        
    }
   // Mark : Event Send Request
    func EventSendRequest(cso_id:String,shift_id:String,event_id:String, onCompletion:@escaping CompletionHandler)  {

        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
               
        
           ActivityLoaderView.startAnimating()
        let params = ["cso_id":cso_id,
                      "event_id":event_id,
                      "shift_id":shift_id,
                      "user_device":UIDevice.current.identifierForVendor!.uuidString,
                      "user_id":userIDData["user_id"] as! String,
                      "user_type":"VOL"]
          //print(params)
           let urlString = baseURL+"search-event.php?api_key=1234&action=event_send_request"
           Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
               response in
               switch response.result {
               case .success:
                   if let JSON = response.result.value as? [String: Any] {
                       //print(JSON)
                       let message = JSON["res_status"] as! String
                       //print(message)
                       if(message == "200"){
                          // let stateData = JSON["res_data"] as! NSDictionary
                           onCompletion(JSON,true)
                           ActivityLoaderView.stopAnimating()
                       }
                   } else {
                       onCompletion(nil,false)
                   }
                   break
               case .failure(let error):
                   ActivityLoaderView.stopAnimating()
                   //print(error)
                   onCompletion(nil,false)
               }
           }
       }
    func addShift(event_id:String,shift_date:String,shift_vol_req:String,shift_start_time:String,shift_end_time:String,shift_rank:String,shift_task:String, onCompletion:@escaping CompletionHandler)  {
        
        ActivityLoaderView.startAnimating()
        let params = ["event_id":event_id,
                      "shift_date":shift_date,
                      "shift_vol_req":shift_vol_req,
                      "shift_start_time":shift_start_time,
                      "shift_end_time":shift_end_time,
                      "shift_rank":shift_rank,
                      "shift_task":shift_task]
        print(params)
        let urlString = baseURL+"cso-action.php?api_key=1234&action=i_shift"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                       // let stateData = JSON["res_data"] as! NSDictionary
                        onCompletion(JSON,true)
                        ActivityLoaderView.stopAnimating()
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    func selectTimeZone(onCompletion:@escaping CompletionHandler)  {
         ActivityLoaderView.startAnimating()
         
         let urlString = baseURL+"master-data.php?api_key=1234&action=stimezone"
         Alamofire.request(urlString, method: .post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
             response in
             switch response.result {
             case .success:
                 if let JSON = response.result.value as? [String: Any] {
                     //print(JSON)
                     let message = JSON["res_status"] as! String
                     //print(message)
                     if(message == "200"){
                         let countryData = JSON as? [String: Any]
                         onCompletion(countryData,true)
                         ActivityLoaderView.stopAnimating()
                         
                     }
                 } else {
                     onCompletion(nil,false)
                 }
                 break
             case .failure(let error):
                 ActivityLoaderView.stopAnimating()
                 //print(error)
                 onCompletion(nil,false)
             }
         }
     }
    func updateTimeZone(data:Dictionary<String,Any>,onCompletion:@escaping CompletionHandler)  {
        ActivityLoaderView.startAnimating()
        
        let urlString = baseURL+"cso-action.php?api_key=1234&action=u_timezone"
        Alamofire.request(urlString, method: .post, parameters:data,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let countryData = JSON as? [String: Any]
                        onCompletion(countryData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    
    func getUserTimeZone(user_id:String,onCompletion:@escaping CompletionHandler) {
        ActivityLoaderView.startAnimating()
        let params = ["user_id":user_id]
        let urlString = baseURL+"cso-action.php?api_key=1234&action=get_user_timezone"
        Alamofire.request(urlString, method: .post, parameters:params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let countryData = JSON["res_data"] as! [[String: Any]]
                         ActivityLoaderView.stopAnimating()
                        onCompletion(countryData,true)
                       
                        
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    func getDocumentType(onCompletion:@escaping CompletionHandler)  {
        ActivityLoaderView.startAnimating()
        
        let urlString = baseURL+"master-data.php?api_key=1234&action=sdoctype"
        Alamofire.request(urlString, method: .post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let countryData = JSON as? [String: Any]
                        onCompletion(countryData,true)
                        ActivityLoaderView.stopAnimating()
                        
                    }
                } else {
                    onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
  func getEventType( onCompletion:@escaping CompletionHandler)  {
      
      ActivityLoaderView.startAnimating()
      
      
      let urlString = baseURL+"master-data.php?api_key=1234&action=sevents"
      Alamofire.request(urlString, method: .get,encoding: JSONEncoding.default, headers: nil).responseJSON {
          response in
          switch response.result {
          case .success:
              if let JSON = response.result.value as? [String: Any] {
                  //print(JSON)
                  let message = JSON["res_status"] as! String
                  //print(message)
                  if(message == "200"){
                      let stateData = JSON["res_data"] as! NSArray
                      onCompletion(stateData,true)
                      ActivityLoaderView.stopAnimating()
                  }
              } else {
                ActivityLoaderView.stopAnimating()
                  onCompletion(nil,false)
              }
              break
          case .failure(let error):
              ActivityLoaderView.stopAnimating()
              //print(error)
              onCompletion(nil,false)
          }
      }
  }
    
    func getProfileData(user_id:String , onCompletion:@escaping CompletionHandler){
        
        ActivityLoaderView.startAnimating()
        
        let params = ["user_id": user_id]
        let urlString = baseURL+"user-access.php?api_key=1234&action=getprofile"
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String:Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200") {
                        let eventData = JSON["res_data"] as! NSDictionary
                        
                        ActivityLoaderView.stopAnimating()
                        onCompletion(eventData,true)
                    }else
                        if(message == "401"){
                            ActivityLoaderView.stopAnimating()
                            onCompletion(nil,true)
                    }
                    
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
    }
    func editProfile(user_id:String , onCompletion:@escaping CompletionHandler){
         
     //    ActivityLoaderView.startAnimating()
         
         let params = ["user_id": user_id]
         let urlString = baseURL+"user-access.php?api_key=1234&action=getprofilemob"
         Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON {
             response in
             switch response.result {
             case .success:
                 if let JSON = response.result.value as? [String:Any] {
                     //print(JSON)
                     let message = JSON["res_status"] as! String
                     //print(message)
                     if(message == "200") {
                         let eventData = JSON["res_data"] as! NSDictionary
                         
                       //  ActivityLoaderView.stopAnimating()
                         onCompletion(eventData,true)
                     }else
                         if(message == "401"){
                         //    ActivityLoaderView.stopAnimating()
                             onCompletion(nil,true)
                     }
                     
                 }
                 break
             case .failure(let error):
              //   ActivityLoaderView.stopAnimating()
                 //print(error)
                 onCompletion(nil,false)
             }
         }
     }
     
    
    
    
    func lockerList(user_id:String, onCompletion:@escaping CompletionHandler){
        
        ActivityLoaderView.startAnimating()
        
        let params = ["user_id": user_id]
        //locker-documents.php?api_key=1234&action=select_locker_doc
        let urlString = baseURL+"locker-documents.php?api_key=1234&action=select_locker_doc"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! NSArray
                        
                        ActivityLoaderView.stopAnimating()
                       onCompletion(eventData,true)
                        
                    }else if(message == "401"){
                    ActivityLoaderView.stopAnimating()
                        onCompletion(nil,false)
                    }
                    
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
      
    }
    
    
    func deletelocker(data_details:[String:Any], onCompletion:@escaping CompletionHandler){
           
           ActivityLoaderView.startAnimating()
        //print(data_details)
           
        
           let urlString = baseURL+"locker-documents.php?api_key=1234&action=d_locker_doc"
           Alamofire.request(urlString, method: .post, parameters: data_details,encoding: JSONEncoding.default, headers: nil).responseJSON {
               response in
               switch response.result {
               case .success:
                   if let JSON = response.result.value as? [String: Any] {
                       //print(JSON)
                       let message = JSON["res_status"] as! String
                       //print(message)
                       if(message == "200"){
                           let eventData = JSON["res_message"] as! String
                           //print(eventData)
                           ActivityLoaderView.stopAnimating()
                          onCompletion(eventData,true)
                        
                    }
                   }
                   break
               case .failure(let error):
                   ActivityLoaderView.stopAnimating()
                   //print(error)
                   onCompletion(nil,false)
               }
           }
         
       }
    func changeStatus(data_details:[String:Any], onCompletion:@escaping CompletionHandler){
              
              ActivityLoaderView.startAnimating()
           //print(data_details)
              
           
              let urlString = baseURL+"cso-action.php?api_key=1234&action=col_request_status"
              Alamofire.request(urlString, method: .post, parameters: data_details,encoding: JSONEncoding.default, headers: nil).responseJSON {
                  response in
                  switch response.result {
                  case .success:
                      if let JSON = response.result.value as? [String: Any] {
                          //print(JSON)
                          let message = JSON["res_status"] as! String
                          //print(message)
                          if(message == "200"){
                              let eventData = JSON["res_message"] as! String
                              //print(eventData)
                              ActivityLoaderView.stopAnimating()
                             onCompletion(eventData,true)
                           
                       }
                      }
                      break
                  case .failure(let error):
                      ActivityLoaderView.stopAnimating()
                      //print(error)
                      onCompletion(nil,false)
                  }
              }
            
          }
    func acceptMultipleRequest(data_details:[String:Any], onCompletion:@escaping CompletionHandler){
        
        ActivityLoaderView.startAnimating()
     //print(data_details)
        
     
        let urlString = baseURL+"cso-action.php?api_key=1234&action=col_request_status_multi"
        Alamofire.request(urlString, method: .post, parameters: data_details,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_message"] as! String
                        //print(eventData)
                        ActivityLoaderView.stopAnimating()
                       onCompletion(eventData,true)
                     
                 }
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
      
    }
    //Mark:- Volunteer Event Lists
    func VolunteerEventList(user_id:String , onCompletion:@escaping CompletionHandler){
        ActivityLoaderView.startAnimating()
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        //print(formattedDate)
        
        let params = ["user_id":user_id ,
                      "list_date":formattedDate]
        
        //print(params)
        
        let urlString = baseURL+"vol-action.php?api_key=1234&action=vol_dashboard_combine_mob"
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! NSDictionary
                        
                        ActivityLoaderView.stopAnimating()
                        onCompletion(eventData,true)
                        
                    }else if(message == "401"){
                        ActivityLoaderView.stopAnimating()
                        onCompletion(nil,true)
                    }
                    
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
        }
    //MARK:- ADD EVENT PROFILE DATA
    
    func getProfileData1(user_id:String , onCompletion:@escaping CompletionHandler){
           ActivityLoaderView.startAnimating()
          
           
           let params = ["user_id":user_id]
           
           //print(params)
           
           let urlString = baseURL+"user-access.php?api_key=1234&action=getprofile"
           Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON {
               response in
               switch response.result {
               case .success:
                   if let JSON = response.result.value as? [String: Any] {
                       //print(JSON)
                       let message = JSON["res_status"] as! String
                       //print(message)
                       if(message == "200"){
                           let eventData = JSON["res_data"] as! NSDictionary
                           
                           ActivityLoaderView.stopAnimating()
                           onCompletion(eventData,true)
                           
                       }else if(message == "401"){
                           ActivityLoaderView.stopAnimating()
                           onCompletion(nil,true)
                       }
                       
                   }
                   break
               case .failure(let error):
                   ActivityLoaderView.stopAnimating()
                   //print(error)
                   onCompletion(nil,false)
               }
           }
           
           }
    
    //  MARK:- CSO CHANGE STATUS
    
    func csoChangeRequestStatus(data_dict:Dictionary<String, Any> , onCompletion:@escaping CompletionHandler){
           ActivityLoaderView.startAnimating()
          
           //print(data_dict)
           
           let urlString = baseURL+"cso-action.php?api_key=1234&action=col_request_status"
           Alamofire.request(urlString, method: .post, parameters: data_dict, encoding: JSONEncoding.default, headers: nil).responseJSON {
               response in
               switch response.result {
               case .success:
                   if let JSON = response.result.value as? [String: Any] {
                       //print(JSON)
                       let message = JSON["res_status"] as! String
                       //print(message)
                       if(message == "200"){
                           let eventData = JSON as! NSDictionary
                           
                           ActivityLoaderView.stopAnimating()
                           onCompletion(eventData,true)
                           
                       }else if(message == "401"){
                           ActivityLoaderView.stopAnimating()
                           onCompletion(nil,true)
                       }
                       
                   }
                   break
               case .failure(let error):
                   ActivityLoaderView.stopAnimating()
                   //print(error)
                   onCompletion(nil,false)
               }
           }
           
           }
    
    
    func CsoAllRequest(user_id:String , onCompletion:@escaping CompletionHandler){
        ActivityLoaderView.startAnimating()
        
        let params = ["user_id":user_id]
        
        //print(params)
        
        let urlString = baseURL+"cso-action.php?api_key=1234&action=cso_all_request"
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! NSArray
                        
                        ActivityLoaderView.stopAnimating()
                        onCompletion(eventData,true)
                        
                    }else if(message == "401"){
                        ActivityLoaderView.stopAnimating()
                        onCompletion(nil,true)
                    }
                    
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
    }
    
    //MARK:- CHANGE RANK
    func changeRankinVol(data:Dictionary<String, Any> , onCompletion:@escaping CompletionHandler){
        ActivityLoaderView.startAnimating()
        //print(data)
        let urlString = baseURL+"cso-action.php?api_key=1234&action=mark_rank"
        Alamofire.request(urlString,method:.post, parameters:data, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON as! NSDictionary
                        
                        ActivityLoaderView.stopAnimating()
                        onCompletion(eventData,true)
                        }
                    }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
        
    }
    
    
    
    //MARK:- LOCKER FILE UPLOAD
    func uploadLockerFiles(data_details:[String:Any],file: Data, onCompletion:@escaping CompletionHandler){
            
            ActivityLoaderView.startAnimating()
         //print(data_details)
        let urlapi:String = baseURL+"file-upload.php" as String
            
        
          let documentName = data_details["document_name"]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
             for (key, value) in data_details {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
             }
             
            multipartFormData.append(file, withName: "document_file_name", fileName: data_details["document_name"] as! String, mimeType: "image/jpeg")
             }, to:urlapi )
         { (result) in
             switch result {
             case .success(let upload, _, _):
                 
                 upload.uploadProgress(closure: { (Progress) in
                     //print("Upload Progress: \(Progress.fractionCompleted)")
                 })
                 
                 upload.responseJSON { response in
                     //self.delegate?.showSuccessAlert()
                     //print(response.request)  // original URL request
                     //print(response.response) // URL response
                     //print(response.data)     // server data
                     //print(response.result)   // result of response serialization
                    //print(response.result.value)
                  
                    
                     if let JSON = response.result.value {
                         //print("JSON: \(JSON)")
                        ActivityLoaderView.stopAnimating()
                          onCompletion(JSON,true)
                        
                     }
                 }
                 
                 break
             case .failure(let encodingError):
                 //self.delegate?.showFailAlert()
                 //print(encodingError)
                  ActivityLoaderView.stopAnimating()
                onCompletion(nil,false)
             }
             
         }
          
          
        }
    
    //MARK:- CSO REGISTRATION DOCUMENT UPLOAD
    func csoregistrationStep2fileUPload(data_details:[String:Any],file: Data,file_name: String, onCompletion:@escaping CompletionHandler){
        
             ActivityLoaderView.startAnimating()
             print(data_details)
            let urlapi:String = baseURL+"file-upload.php" as String
                
              Alamofire.upload(multipartFormData: { (multipartFormData) in
                 for (key, value) in data_details {
        multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                 }
        multipartFormData.append(file, withName: "document_file_name", fileName: file_name, mimeType: "image/jpeg")
                 }, to:urlapi )
             { (result) in
                 switch result {
                 case .success(let upload, _, _):
                     
                     upload.uploadProgress(closure: { (Progress) in
                         //print("Upload Progress: \(Progress.fractionCompleted)")
                     })
                     
                     upload.responseJSON { response in
                         if let JSON = response.result.value as? [String: Any]{
                            let message = JSON["res_message"] as! String
                            print("JSON: \(JSON)")
                            ActivityLoaderView.stopAnimating()
                              onCompletion(message,true)
                            
                         }
                     }
                     
                     break
                 case .failure(let encodingError):
                     //self.delegate?.showFailAlert()
                     print(encodingError)
                      ActivityLoaderView.stopAnimating()
                    onCompletion(nil,false)
                 }
                
                 
             }
              
              
            }
        
    //MARK:- ADD EVENT Image Uplaod
    
    
    func addEventImageUpload(data_details:[String:Any],file: Data, onCompletion:@escaping CompletionHandler){
        
        ActivityLoaderView.startAnimating()
        //print(data_details)
        let urlapi:String = baseURL+"file-upload.php" as String
        
        
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in data_details {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            
            multipartFormData.append(file, withName: "event_image", fileName: data_details["img_name"] as! String, mimeType: "image/jpeg")
        }, to:urlapi )
        { (result) in
            switch result {
            case .success(let upload,_,_):
                
                upload.uploadProgress(closure: { (Progress) in
                    //print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //self.delegate?.showSuccessAlert()
                    //print(response.request)  // original URL request
                    //print(response.response) // URL response
                    //print(response.data)     // server data
                    //print(response.result)   // result of response serialization
                    //print(response.result.value)
                    //  self.showSuccesAlert()
                    //self.removeImage("frame", fileExtension: "txt")
                    
                    /////////////////
                    //                    //optional dictionary type
                    //                    let name = (responseObject as? [String : AnyObject])?["name"]
                    //
                    //                    //or unwrapping, name will be inferred as AnyObject
                    //                    if let myDictionary = responseObject as? [String : AnyObject] {
                    //                        let name = myDictionary["name"]
                    //                    }
                    //
                    //                    //or unwrapping, name will be inferred as String
                    //                    if let myDictionary = responseObject as? [String : String] {
                    //                        let name = myDictionary["name"]
                    //                    }
                    
                    /////////////////
                    
                    if let JSON = response.result.value {
                        //print("JSON: \(JSON)")
                        ActivityLoaderView.stopAnimating()
                        onCompletion(JSON,true)
                        
                    }
                }
                
                break
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                //print(encodingError)
                onCompletion(nil,false)
            }
            
        }
        
        
    }
    
   //MARK:- ADD EVENT File Uplaod
   
   
   func addEventFileUpload(data_details:[String:Any],file: Data, onCompletion:@escaping CompletionHandler){
       
       ActivityLoaderView.startAnimating()
       //print(data_details)
       let urlapi:String = baseURL+"file-upload.php" as String
       Alamofire.upload(multipartFormData: { (multipartFormData) in
           for (key, value) in data_details {
               multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
           }
           
           multipartFormData.append(file, withName: "event_waiver_doc", fileName: data_details["file_name"] as! String, mimeType: "image/jpeg")
       }, to:urlapi )
       { (result) in
           switch result {
           case .success(let upload,_,_):
               
               upload.uploadProgress(closure: { (Progress) in
                   //print("Upload Progress: \(Progress.fractionCompleted)")
               })
               
               upload.responseJSON { response in
                   //self.delegate?.showSuccessAlert()
                   //print(response.request)  // original URL request
                   //print(response.response) // URL response
                   //print(response.data)     // server data
                   //print(response.result)   // result of response serialization
                   //print(response.result.value)
                   
                   if let JSON = response.result.value {
                       //print("JSON: \(JSON)")
                       ActivityLoaderView.stopAnimating()
                       onCompletion(JSON,true)
                       
                   }
               }
               
               break
           case .failure(let encodingError):
               //self.delegate?.showFailAlert()
               //print(encodingError)
               onCompletion(nil,false)
           }
       }
   }

    //Mark:- Volunteer Event Lists
    func VolunteerEventList(userData:String , onCompletion:@escaping CompletionHandler){
            ActivityLoaderView.startAnimating()
        
        var strUserTimezone = "EST"
       let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
               let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
        if let timeZone = userIDData["user_timezone"] {
           strUserTimezone = timeZone as? String ?? "EST"
        }else{
           strUserTimezone = "EST"
        }
       
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "MM-dd-yyyy HH:mm:ss"
        format.timeZone = NSTimeZone(abbreviation: strUserTimezone) as TimeZone?
            let formattedDate = format.string(from: date)
            //print(formattedDate)
            
            let params = ["user_id":userData ,
                          "list_date":formattedDate]
            
            //print(params)
            
        let urlString = baseURL + "vol-action.php?api_key=1234&action=vol_dashboard_combine_mob"
            Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON {
                response in
                switch response.result {
                case .success:
                    if let JSON = response.result.value as? [String: Any] {
                        //print(JSON)
                       
                        let encodedData = NSKeyedArchiver.archivedData(withRootObject: JSON)
                        UserDefaults.standard.set(encodedData, forKey: "VolData")
                        UserDefaults.standard.synchronize()
                        let message = JSON["res_status"] as! String
                        //print(message)
                        if(message == "200"){
                            let eventData = JSON["res_data"] as! NSDictionary
                            //print(eventData)
                           
                            ActivityLoaderView.stopAnimating()
                            onCompletion(eventData,true)
                            
                        }else if(message == "401"){
                            ActivityLoaderView.stopAnimating()
                            onCompletion(nil,false)
                        }
                    }
                    break
                case .failure(let error):
                    ActivityLoaderView.stopAnimating()
                    //print(error)
                    onCompletion(nil,false)
                }
             }
          }
    
    //mark: Event Rating
    func EventRating(event_id:String,rating:String, onCompletion:@escaping CompletionHandler){

           ActivityLoaderView.startAnimating()
        
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultKeys.key_LoggedInUserData) as! Data
        let userIDData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as!  Dictionary<String, Any>
     
           let params = ["user_id": userIDData["user_id"] as! String,
                         "event_id":event_id,
                         "user_type":userIDData["user_type"] as! String,
                         "user_device":UIDevice.current.identifierForVendor!.uuidString,
                         "event_rating":rating]
           //print(params)
           let urlString = baseURL + "site-data.php?api_key=1234&action=event_rating"
           Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
               response in
               switch response.result {
               case .success:
                   if let JSON = response.result.value as? [String: Any] {
                       //print(JSON)
                       let message = JSON["res_status"] as! String
                       //print(message)
                       if(message == "200"){
                           let strMessage = JSON["res_message"] as! String
                           //print(strMessage)
                           
                           ActivityLoaderView.stopAnimating()
                           onCompletion(strMessage,true)

                       }else if(message == "401"){
                        
                        let strMessage = JSON["res_message"] as! String
                        //print(strMessage)
                           ActivityLoaderView.stopAnimating()
                           onCompletion(strMessage,false)
                       }

                   }
                   break
               case .failure(let error):
                   ActivityLoaderView.stopAnimating()
                   //print(error)
                   onCompletion(nil,false)
               }
           }

       }
    
    
    // Mark: VolunteerShifts
    func VolunteerShiftsDetails(user_id:String,event_id:String, onCompletion:@escaping CompletionHandler){

        ActivityLoaderView.startAnimating()

        let params = ["user_id": user_id,
                      "event_id":event_id]
        //print(params)
        let urlString = baseURL + "/search-event.php?api_key=1234&action=get_all_shift_vol"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! NSArray
                        //print(eventData)
                        
                        UserDefaults.standard.set(JSON["user_avg_rate"], forKey: "user_avg_rate")
            UserDefaults.standard.synchronize()

                        
                        ActivityLoaderView.stopAnimating()
                        onCompletion(eventData,true)

                    }else if(message == "401"){
                        ActivityLoaderView.stopAnimating()
                        onCompletion(nil,false)
                    }

                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }

    }
    
    // Mark : Volunteer Target
    
   func VolTargets(user_id:String, onCompletion:@escaping CompletionHandler)  {
        ActivityLoaderView.startAnimating()
        
    let params = ["user_id":user_id]
      print(params)
       
        let urlString = baseURL+"vol-action.php?api_key=1234&action=get_vol_targets"
        Alamofire.request(urlString, method: .post, parameters:params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                   // //print(JSON)
                    let message = JSON["res_status"] as! String
                   // //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! Array<Any>
                        print(eventData)
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                    }
                } else {
                     onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
              //  //print(error)
                onCompletion(nil,false)
            }
        }
    }
    
    // Forgot password
    func forgotPassword(user_email:String, onCompletion:@escaping CompletionHandler)  {
        ActivityLoaderView.startAnimating()
        
    let params = ["user_email":user_email]
      print(params)
       
        let urlString = baseURL+"user-access.php?api_key=1234&action=forgot_pass"
        Alamofire.request(urlString, method: .post, parameters:params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    let message = JSON["res_status"] as! String
                    if(message == "200"){
                        let eventData = JSON as! [String: Any]
                        //print(eventData)
                        onCompletion(eventData,true)
                        ActivityLoaderView.stopAnimating()
                    }else if (message == "401"){
                        let pwdata = JSON["res_status"] as! String
                        onCompletion(pwdata,false)
                        ActivityLoaderView.stopAnimating()
                    }
                } else {
                     onCompletion(nil,false)
                }
                break
            case .failure(let error):
                ActivityLoaderView.startAnimating()
              //  //print(error)
                onCompletion(nil,false)
            }
        }
    }
    // Sendbird get connected user
    func getConnectedUser(user_id:String,user_type:String, onCompletion:@escaping CompletionHandler){
        
        ActivityLoaderView.startAnimating()
        
       let params = ["user_id": user_id,"user_type":user_type]
        
        let urlString = baseURL+"user-access.php?api_key=1234&action=get_connected_users"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let connectedUsers = JSON["res_data"] as! NSArray
                        let sortedArray = (connectedUsers as NSArray).sortedArray(using: [NSSortDescriptor(key: "user_f_name", ascending: true)]) as! [[String:Any]]
                        ActivityLoaderView.stopAnimating()
                       onCompletion(sortedArray,true)
                        
                    }else if(message == "401"){
                    ActivityLoaderView.stopAnimating()
                        onCompletion(nil,false)
                    }
                    
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
      
    }
    func syncChannelToServer(user_id:String,channel_name:String,channel_url:String,channel_auto_invite:String, onCompletion:@escaping CompletionHandler){
           
           ActivityLoaderView.startAnimating()
           
          let params = ["user_id": user_id,"channel_name": channel_name,"channel_url": channel_url,"channel_auto_invite": channel_auto_invite,]
           
           let urlString = baseURL+"site-data.php?api_key=1234&action=insert_channel"
           Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
               response in
               switch response.result {
               case .success:
                   if let JSON = response.result.value as? [String: Any] {
                       //print(JSON)
                       let message = JSON["res_status"] as! String
                       //print(message)
                       if(message == "200"){
                           let responseString = JSON["res_message"] as! NSString
                           ActivityLoaderView.stopAnimating()
                          onCompletion(responseString,true)
                           
                       }else if(message == "401"){
                       ActivityLoaderView.stopAnimating()
                           onCompletion(nil,false)
                       }
                       
                   }
                   break
               case .failure(let error):
                   ActivityLoaderView.stopAnimating()
                   print(error)
                   onCompletion(nil,false)
               }
           }
         
       }
    
    
    
    func myOrgList(user_id:String, onCompletion:@escaping CompletionHandler){
        
        ActivityLoaderView.startAnimating()
        
        let params = ["user_id": user_id]
        //locker-documents.php?api_key=1234&action=select_locker_doc
        let urlString = baseURL+"vol-action.php?api_key=1234&action=my_cso"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! NSArray
                        
                        ActivityLoaderView.stopAnimating()
                       onCompletion(eventData,true)
                        
                    }else if(message == "401"){
                    ActivityLoaderView.stopAnimating()
                        onCompletion(nil,false)
                    }
                    
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
      
    }
    
    func searchOrgList(user_id:String, onCompletion:@escaping CompletionHandler){
        
        ActivityLoaderView.startAnimating()
        
        let params = ["user_id": user_id,"seach_row_number": "0", "search_page_size": "50", "search_email": "","search_organisation": "", "search_event_type": "", "search_city": "", "search_state": "", "search_postcode": ""  ]
        //locker-documents.php?api_key=1234&action=select_locker_doc
        let urlString = baseURL+"search-event.php?api_key=1234&action=search_cso_filter"
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let JSON = response.result.value as? [String: Any] {
                    //print(JSON)
                    let message = JSON["res_status"] as! String
                    //print(message)
                    if(message == "200"){
                        let eventData = JSON["res_data"] as! NSArray
                        
                        ActivityLoaderView.stopAnimating()
                       onCompletion(eventData,true)
                        
                    }else if(message == "401"){
                    ActivityLoaderView.stopAnimating()
                        onCompletion(nil,false)
                    }
                    
                }
                break
            case .failure(let error):
                ActivityLoaderView.stopAnimating()
                //print(error)
                onCompletion(nil,false)
            }
        }
      
    }
    
    func unLinkUser(user_id:String,cso_id:String,user_device:String, onCompletion:@escaping CompletionHandler){
          
          ActivityLoaderView.startAnimating()
          
        let params = ["vol_id": user_id, "cso_id": cso_id, "user_device": user_device]
          //locker-documents.php?api_key=1234&action=select_locker_doc
          let urlString = baseURL+"user-access.php?api_key=1234&action=unlink_user"
          Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
              response in
              switch response.result {
              case .success:
                  if let JSON = response.result.value as? [String: Any] {
                      //print(JSON)
                      let message = JSON["res_status"] as! String
                      //print(message)
                      if(message == "200"){
                          let responseString = JSON["res_data"] as! NSString
                          
                          ActivityLoaderView.stopAnimating()
                         onCompletion(responseString,true)
                          
                      }else if(message == "401"){
                      ActivityLoaderView.stopAnimating()
                          onCompletion(nil,false)
                      }
                      
                  }
                  break
              case .failure(let error):
                  ActivityLoaderView.stopAnimating()
                  //print(error)
                  onCompletion(nil,false)
              }
          }
        
      }
    
    func linkUser(user_id:String,cso_id:String,user_device:String, onCompletion:@escaping CompletionHandler){
             
             ActivityLoaderView.startAnimating()
             
           let params = ["vol_id": user_id, "cso_id": cso_id, "user_device": user_device]
             //locker-documents.php?api_key=1234&action=select_locker_doc
             let urlString = baseURL+"user-access.php?api_key=1234&action=link_user"
             Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
                 response in
                 switch response.result {
                 case .success:
                     if let JSON = response.result.value as? [String: Any] {
                         //print(JSON)
                         let message = JSON["res_status"] as! String
                         //print(message)
                         if(message == "200"){
                            
                             let responseString = JSON["res_data"] as! NSString
                             ActivityLoaderView.stopAnimating()
                            onCompletion(responseString,true)
                             
                         }else if(message == "401"){
                         ActivityLoaderView.stopAnimating()
                             onCompletion(nil,false)
                         }
                         
                     }
                     break
                 case .failure(let error):
                     ActivityLoaderView.stopAnimating()
                     //print(error)
                     onCompletion(nil,false)
                 }
             }
           
         }
    
    
    //Mark: ProfilePicImage
    
    func ProfileImage(data2:[String:Any],imgData:Data ,onCompletion:@escaping CompletionHandler){
        
        ActivityLoaderView.startAnimating()
        
        let ImageUpload = baseURL + "file-upload.php"
        
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "user_cover_pic",fileName: data2["img_name"] as! String, mimeType: "image/jpeg")
            for (key, value) in data2 {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            } //Optional for extra parameters
        },
                         to: ImageUpload)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result.value)
                    
                    if let JSON = response.result.value {
                        //print("JSON: \(JSON)"
                        ActivityLoaderView.stopAnimating()
                        onCompletion(JSON,true)
                        
                        
                    }
                }
                ActivityLoaderView.stopAnimating()
            case .failure(let encodingError):
                print(encodingError)
                
            }
        }
    }
    
    func profilePicture(data2:[String:Any],imgData:Data ,onCompletion:@escaping CompletionHandler){
        
        let ImageUpload = baseURL + "file-upload.php"
    
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "user_profile_pic",fileName: data2["img_name"] as! String, mimeType: "image/jpeg")
            for (key, value) in data2 {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            } //Optional for extra parameters
        },
                         to: ImageUpload)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result.value)
                    
                    if let JSON = response.result.value {
                        //print("JSON: \(JSON)"
                       
                        onCompletion(JSON,true)
                        
                        
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                
            }
        }
    }
     
}
