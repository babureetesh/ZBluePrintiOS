//
//  LockerViewController.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 11/09/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
import Alamofire

class LockerViewController: UIViewController   {

    
    let data = ["https://images5.alphacoders.com/581/581655.jpg"]

    
    var upcomingEvents = [[String:Any]]()
   
    
    
    @IBOutlet weak var InternalContentTable: UITableView!
          var DocumentContents: Dictionary<String, Any>?
    
     let documentInteractionConroller = UIDocumentInteractionController()
    
        override func viewDidLoad() {
        super.viewDidLoad()
    
       // Do any additional setup after loading the view.
            
            
//            self.InternalContentTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//            documentInteractionConroller.delegate = self
//
//            let url = URL(string: "https://blue//print.hashtaglabs.in/api/locker-documents.php?api_key=1234&action=select_locker_doc")
//
//            let task = URLSession.shared.dataTask(with: url!) { (data,response,error) in
//
//                if error != nil{
//                    //print(error!)
//                }
//                else{
//
//                    if let urlContent = data {
//
//                        do{
//                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
//
//                            //print(jsonResult)
//                            //print(jsonResult["user_id"]!!)
//                        }   catch {
//                                 //print("json Processing Failed")
//                        }
//                    }
//                }
//            }
//            task.resume()
        }
    
    @IBAction func LocalGalleryButton(_ sender: Any) {
        
        
//        //original code
//    storeAndShare(withURLString: "https://images5.alphacoders.com/581/581655.jpg")
//
//        let user_id = "user_id"
//        let parameters: [String:Any] = [
//            "user_id": user_id
//        ]
//Alamofire.request("https://blue//print.hashtaglabs.in/api/locker-documents.php?api_key=1234&action=select_locker_doc", method: .post, parameters: parameters) }
    }
}


extension LockerViewController {
    
    func share(url: URL) {
        documentInteractionConroller.url = url
        documentInteractionConroller.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionConroller.name = url.localizedName ?? url.lastPathComponent
        documentInteractionConroller.presentPreview(animated: true)
}
    
    func storeAndShare(withURLString: String) {
        guard let url = URL(string: withURLString) else { return }
        /// START YOUR ACTIVITY INDICATOR HERE
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.jpg")
            do {
                try data.write(to: tmpURL)
            } catch {
                //print(error)
            }
            DispatchQueue.main.async {
                /// STOP YOUR ACTIVITY INDICATOR HERE
                self.share(url: tmpURL)
            }
            }.resume()
    }
}

//func getEventList(user_id:String, onCompletion:@escaping CompletionHandler)  {
//
//    ActivityLoaderView.startAnimating()
//
//    let params = ["user_id": user_id]
//    let urlString = "https://ztp.hashtaglabs.in/apiblue//print/locker-documents.php?api_key=1234&action=select_locker_doc"
//    Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
//        response in
//        switch response.result {
//        case .success:
//            if let JSON = response.result.value as? [String: Any] {
//                //print(JSON)
//                let message = JSON["res_status"] as! String
//                //print(message)
//                if(message == "200"){
//                    let eventData = JSON["res_data"] as! NSArray
//                    onCompletion(eventData,true)
//                    ActivityLoaderView.stopAnimating()
//
//                }
//            } else {
//                onCompletion(nil,false)
//            }
//            break
//        case .failure(let error):
//            ActivityLoaderView.startAnimating()
//            //print(error)
//            onCompletion(nil,false)
//        }
//    }
//}

extension LockerViewController: UIDocumentInteractionControllerDelegate {
    /// If presenting atop a navigation stack, provide the navigation controller in order to animate in a manner consistent with the rest of the platform
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
        }
        return navVC
    }
}
extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}

extension LockerViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LockerTableViewCell", for: indexPath) as! LockerTableViewCell
        let eventData = upcomingEvents[indexPath.row]
       // //print(eventData)
        cell.DocLabel.text = eventData["DocumentLabel"] as? String
        cell.DocImage.image = eventData["Image"] as? UIImage
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return data.count
      
       
    
        }
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
     {
        if (editingStyle == UITableViewCell.EditingStyle.delete)
        {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    
   
}


