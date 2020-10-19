//
//  RegistrationViewController.swift
//  ZoeBlue//print
//
//  Created by Reetesh Bajpai on 05/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class RegistrationViewController: BaseViewController {

    
    
    @IBOutlet weak var viewOrganization: UIView!
    @IBOutlet weak var viewVolunteer: UIView!
    @IBOutlet weak var lblAmVolunteer: UILabel!
    
    @IBOutlet weak var lblAmCSO: UILabel!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var registrationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapVol = UITapGestureRecognizer(target: self, action: #selector(self.handleTapVol(_:)))
        self.viewVolunteer.addGestureRecognizer(tapVol)
        
        let tapCso = UITapGestureRecognizer(target: self, action: #selector(self.handleTapCso(_:)))
        self.viewOrganization.addGestureRecognizer(tapCso)
    }
    
    @objc func handleTapVol(_ sender: UITapGestureRecognizer? = nil) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "volreg") as! VolRegistration
//        self.present(nextViewController, animated:true, completion:nil)
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    @objc func handleTapCso(_ sender: UITapGestureRecognizer? = nil) {
           
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CSORegistrationViewController") as! CSORegistration
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.setNavigationBarHidden(toHide: false)
    }

    @IBAction func btnCSORegistrationTapped(_ sender: Any) {
        
        
    }
    @IBAction func btnStudentRegisterTapped(_ sender: Any) {
        
        
    }
   
    
    @IBAction func back_button(_ sender: Any) {
       performSegueToReturnBack()
    }
    
    

}
