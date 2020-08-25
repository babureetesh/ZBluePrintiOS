//
//  IntroScreenViewController.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 22/08/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class IntroScreenViewController: UIViewController {

    
    @IBOutlet weak var btnContinueDone: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var imgviewIntro: UIImageView!
    var introDataDictArray = [Dictionary<String, String>]()
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        introDataDictArray = [["imgname": "bookyourcsoevents.png", "title": "BOOK YOUR ORG EVENTS", "desc":"It's so easy to manage your volunteer Calendar and connect with organizations", "btntitle": "CONTINUE","bckColor": "FDDBB3"],["imgname": "somewheretohangout.png", "title": "SOMEWHERE TO HANGOUT", "desc":"KEEP the conversation going! Chat with your friends and keep in the loop with the ORG announcements.", "btntitle": "CONTINUE","bckColor": "C5EFE7"],["imgname": "placefordocument.png", "title": "A PLACE FOR DOCUMENTS", "desc":"Load and store files to keep you organized and on track. Managing your hours quick and easy.", "btntitle": "CONTINUE","bckColor": "F7BED0"],["imgname": "trackyourhours.png", "title": "TRACK YOUR HOURS", "desc":"One centralized location to track your community service hours and manage your progress to put target GPA", "btntitle": "CONTINUE","bckColor": "C5EFE7"],["imgname": "youareconnected.png", "title": "YOU'RE CONNECTED", "desc":"Have direct access to school and ORG administrators. Ask questions, get feedback and keep up to date.", "btntitle": "I'M DONE","bckColor": "F7BED0"]]
        
        
      self.lblTitle.text = introDataDictArray[index]["title"]
        self.lblDesc.text = introDataDictArray[index]["desc"]
        self.btnContinueDone.setTitle(introDataDictArray[index]["btntitle"], for: .normal)
        self.view.backgroundColor =  self.colorWithHexString(hexString: introDataDictArray[index]["bckColor"]!)
        self.imgviewIntro.image = UIImage(named: introDataDictArray[index]["imgname"]!)
    }
    @IBAction func btnSkipClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnClickContinueDone(_ sender: Any) {
        
        index = index + 1
        if (index > 4) {
            
             dismiss(animated: true, completion: nil)
        }else{
            self.view.backgroundColor =  self.colorWithHexString(hexString: introDataDictArray[index]["bckColor"]!)
            self.lblTitle.text = introDataDictArray[index]["title"]
            self.lblDesc.text = introDataDictArray[index]["desc"]
            self.btnContinueDone.setTitle(introDataDictArray[index]["btntitle"], for: .normal)
            self.imgviewIntro.image = UIImage(named: introDataDictArray[index]["imgname"]!)
        }
    }
    
    func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {

        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0

        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
