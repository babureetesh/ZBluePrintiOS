//
//  RegistrationViewController.swift
//  ZoeBlue//print
//
//  Created by Reetesh Bajpai on 05/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class RegistrationViewController: BaseViewController {

    
    
    @IBOutlet weak var lblAmVolunteer: UILabel!
    
    @IBOutlet weak var lblAmCSO: UILabel!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var registrationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
