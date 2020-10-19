//
//  Utility.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 20/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import Foundation
import UIKit

class Utility: NSObject {
    typealias CompletionHandler = (_ result:[[String:Any]]?,_ isSuccess:Bool)->Void;
    
    
    public class func removeChildVC(vc:UIViewController) {
        vc.willMove(toParent: nil)
               vc.view.removeFromSuperview()
               vc.removeFromParent()
    }
    public class func presentWithNavigationController(destinationVC:UIViewController, currentVC:UIViewController) {
           let navController = UINavigationController(rootViewController: destinationVC)
           navController.navigationBar.isHidden = true
           navController.modalPresentationStyle = .overFullScreen
        
           //present(navController, animated: true)
       
            currentVC.present(navController, animated: true)
            
        
           
       }
    
    class func getShortMonthString(monthNumber:Int) -> String {
        switch monthNumber {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "Aug"
        case 9:
            return "Sept"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
            
        default:
            ""
        }
        return ""
    }
    
   class func getDateFromString(dateString:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    if let date = dateFormatter.date(from:dateString) {
        return date
    }
        return nil
    }
    
   class func getDayOfTheWeek(myDate:Date) -> String? {
        let weekdays = [
            "Sun",
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat"
        ]
        
        let _: Calendar = .current //NSCalendar.currentCalendar
        let components = Calendar.current.component(.weekday, from: myDate)
        //print("compon \(components - 1)")
        return weekdays[components - 1]
    }
    
    
   class func removeViewControllerAddedOnTabBarController(viewController:ViewController)  {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func fetchCountryList(onCompletion:@escaping CompletionHandler) {
        var countryList:[[String:Any]]?
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.selectCountry() {
            (responce, isSuccess) in
            if isSuccess {
                if let countryData = responce as? [String: Any] {
                    for (_,value) in countryData {
                        if let values = value as? [[String:Any]] {
                            countryList = values
                            break
                        }
                    }
                }
            }
            onCompletion(countryList, isSuccess)
        }
    }
    func fetchTimeZone(onCompletion:@escaping CompletionHandler)  {
         var timeZoneList:[[String:Any] ]?
         
         
         //  Call for Getting Event Type list
         let serviceHanlder = ServiceHandlers()
         serviceHanlder.selectTimeZone() { (responce, isSuccess) in
                 if isSuccess {
                 if let countryData = responce as? [String: Any] {
                     for (_,value) in countryData {
                         if let values = value as? [[String:Any]] {
                             timeZoneList = values
                             break
                         }
                     }
                 }
             }
             onCompletion(timeZoneList, isSuccess)
         }
         
     }
    func fetchDocumentType(onCompletion:@escaping CompletionHandler)  {
          var timeZoneList:[[String:Any] ]?
          
          
          //  Call for Getting Event Type list
          let serviceHanlder = ServiceHandlers()
          serviceHanlder.getDocumentType() { (responce, isSuccess) in
                  if isSuccess {
                  if let countryData = responce as? [String: Any] {
                      for (_,value) in countryData {
                          if let values = value as? [[String:Any]] {
                              timeZoneList = values
                              break
                          }
                      }
                  }
              }
              onCompletion(timeZoneList, isSuccess)
          }
          
      }
    func fetchEventTypeList(onCompletion:@escaping CompletionHandler)  {
            var typeList:[[String:Any] ]?
            
            
            //  Call for Getting Event Type list
            let serviceHanlder = ServiceHandlers()
            serviceHanlder.getEventType() { (responce, isSuccess) in
                if isSuccess {
                    if let EventTypeData = responce as? [[String:Any] ] {
                        typeList = EventTypeData
                    }
                }
                onCompletion(typeList, isSuccess)
            }
           
        }
    func fetchStateList(onCompletion:@escaping CompletionHandler)  {
        var statelist:[[String:Any] ]?
        
        let serviceHanlder = ServiceHandlers()
        serviceHanlder.getStateList(country_id:"1") { (responce, isSuccess) in
            if isSuccess {
                if let stateData = responce as? [[String:Any] ] {
                    statelist = stateData
                }
            }
            onCompletion(statelist, isSuccess)
        }
    }
    
    
}



