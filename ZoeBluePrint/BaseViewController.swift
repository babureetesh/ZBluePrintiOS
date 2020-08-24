//
//  BaseViewController.swift
//  ZoeBlue//print
//
//  Created by Reetesh Bajpai on 05/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func setNavigationBarHidden(toHide:Bool)  {
        self.navigationController?.navigationBar.isHidden = toHide
    }
}
