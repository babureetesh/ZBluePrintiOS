//
//  DateSelectionViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 31/08/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class DateSelectionViewController: UIViewController {
    
    
    
    private let startDate:Date?
    private let endDate:Date?
    
    typealias SelectionHandler = (Date) -> Void
    private var onSelect : SelectionHandler?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    init(startDate:Date?, endDate:Date?) {
        self.startDate = startDate
        self.endDate = endDate
        super.init(nibName: "DateSelectionViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func removeMeNow()  {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        removeMeNow()
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        onSelect?(datePicker.date)
        removeMeNow()
    }
    
    func captureSelectDateValue(_:Any, inMode:UIDatePicker.Mode, onSelect : SelectionHandler? = nil) {
        if ((startDate != nil) && (endDate != nil)){
        datePicker.minimumDate = startDate
        datePicker.maximumDate = endDate
        }
        self.onSelect = onSelect
        datePicker.datePickerMode = inMode
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


