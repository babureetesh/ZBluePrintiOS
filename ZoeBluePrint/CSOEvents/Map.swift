//
//  Map.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 12/10/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import MapKit
protocol LatLongdata {
    func mapData(lang:String,lat:String,city:String,postal_code:String,address:String)
    
}

class Map: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var map: MKMapView!
    var city:String = ""
    var postalcode:String = ""
    var address:String = ""
    @IBOutlet weak var lbnLocation: UILabel!
    var state_name:String?
    var state_code:String?
    let locationManager = CLLocationManager()
   // locationManager.requestWhenInUseAuthorization()
    var latitu:String = ""
    var longitu:String = ""
    var flag:Bool = false
    var delegate:LatLongdata!
    @IBAction func btnOk(_ sender: Any) {
        if flag {
          //  //print(longitu)
           // //print(latitu)
          // let a = longitu as! String
         //  let b = latitu as! String
           // if ((longitu != nil) && (latitu != nil)) {
            self.delegate.mapData(lang: longitu, lat: latitu, city: self.city, postal_code: self.postalcode, address: self.address)
            self.dismiss(animated: true, completion: nil)
           // }
            
        }
        
        
    }
    @IBAction func btnCancle(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
  
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    map.delegate = self
        self.lbnLocation.text = "Location out of Selected state: \(self.state_name as! String)"
     
     let tap = UITapGestureRecognizer(target: self, action: #selector(longTap))
     map.addGestureRecognizer(tap)
    }
    
    @objc func longTap(sender: UIGestureRecognizer){
         
         for annotation in self.map.annotations {
             if let _ = annotation as? MKUserLocation {
                 // keep the user location
             } else {
                 self.map.removeAnnotation(annotation)
             }
         }

         //print("long tap")
         if sender.state == .ended {
             let locationInView = sender.location(in: map)
             let locationOnMap = map.convert(locationInView, toCoordinateFrom: map)
             addAnnotation(location: locationOnMap)
        }
     }

  func addAnnotation(location: CLLocationCoordinate2D){
             let annotation = MKPointAnnotation()
             annotation.coordinate = location
       //  //print(location)
         //var locValue:CLLocationCoordinate2D = manager.location!.coordinate
         let lat : String = location.latitude.description
         let lng : String = location.longitude.description
         
         self.latitu = lat
         self.longitu = lng
         self.getAddressFromLatLon(pdblLatitude: lat, withLongitude: lng)
             annotation.title = ""
             annotation.subtitle = ""
             self.map.addAnnotation(annotation)
     }
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
             var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
             let lat: Double = Double("\(pdblLatitude)")!
             //21.228124
             let lon: Double = Double("\(pdblLongitude)")!
             //72.833770
             let ceo: CLGeocoder = CLGeocoder()
             center.latitude = lat
             center.longitude = lon
             
             let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
             
             
             ceo.reverseGeocodeLocation(loc, completionHandler:
                 {(placemarks, error) in
                     if (error != nil)
                     {
                         //print("reverse geodcode fail: \(error!.localizedDescription)")
                     }
                     let pm = placemarks! as [CLPlacemark]
                     
                     if pm.count > 0 {
                         let pm = placemarks![0]
//                         //print(pm.country)
//                         //print(pm.locality)
//                         //print(pm.subLocality)
//                         //print(pm.thoroughfare)
//                         //print(pm.postalCode)
//                         //print(pm.subThoroughfare)
//                         //print(pm.administrativeArea)
//                         //print(pm.subAdministrativeArea)
                         var addressString : String = ""
                         if pm.subLocality != nil {
                             addressString = addressString + pm.subLocality! + ", "
                         }
                         if pm.thoroughfare != nil {
                             addressString = addressString + pm.thoroughfare! + ", "
                            self.address = pm.thoroughfare!
                         }
                         if pm.locality != nil {
                             addressString = addressString + pm.locality! + ", "
                            self.city = pm.locality!
                         }
                         if pm.country != nil {
                             addressString = addressString + pm.country! + ", "
                         }
                         if pm.postalCode != nil {
                             addressString = addressString + pm.postalCode! + " "
                            self.postalcode = pm.postalCode!
                         }
                         
                        if(pm.administrativeArea == self.state_code){
                         
                            self.lbnLocation.text = addressString
                            // //print(addressString)
                            self.lbnLocation.textColor = UIColor.green
                             self.flag = true
                         }else{
                            self.lbnLocation.text = NSLocalizedString("Location out of Selected state:", comment: "") + (self.state_name!)
                            self.lbnLocation.textColor = UIColor.red
                            // //print("Location out of Selected state: Delaware")
                         }
                     }
             })
             
         }
}
extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
            pinView!.pinTintColor = UIColor.black
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let doSomething = view.annotation?.title! {
               //print("do something")
            }
        }
    
  }
        
}



