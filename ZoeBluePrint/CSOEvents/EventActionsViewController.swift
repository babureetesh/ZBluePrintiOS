//
//  EventActionsViewController.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 20/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

protocol EventActionsViewControllerDelegate: class {
    func eventSelected( eventDetail: [String: Any]?, eventType:EventActionsViewController.SelectedEventType)
}


class EventActionsViewController: UIViewController {
    enum SelectedEventType:String {
        case Event_Edit = "Edit Event"
        case Event_Delete = "Delete Event"
        case Event_View = "View Event"
        case Shift_Add = "Add Shift"
        case Shift_View = "View Shift"
        case Event_Duplicate = "Duplicate Event"
        case None = "none"
    }
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var btnEventView: UIButton!
    @IBOutlet weak var shiftViewImage: UIImageView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var duplicateImage: UIImageView!
    @IBOutlet weak var eventViewImage: UIImageView!
    @IBOutlet weak var btnDuplicate: UIButton!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var btnShiftView: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    var  eventDetail: [String: Any]?
    
    
     weak var delegate: EventActionsViewControllerDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let defaults = UserDefaults.standard.string(forKey: "ChangeTheme")
//        if defaults == "Dark Mode"{
//            
//            DarkMode()
//        }else if defaults == "Light Mode"{
//           LightMode()
//            
//        }
        
    }

    func DarkMode(){
    
        mainView.backgroundColor = .lightGray
        btnEdit.backgroundColor = .darkGray
        btnEdit.setTitleColor(UIColor.white, for: UIControl.State.normal)
        editImage.image = UIImage(named: "lightThemePencil.png")
        
        btnDelete.backgroundColor = .darkGray
        btnDelete.setTitleColor(UIColor.white, for: UIControl.State.normal)
        deleteImage.image = UIImage(named: "LightInkeddownload.png")
        
        btnEventView.backgroundColor = .darkGray
        btnEventView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        eventViewImage.image = UIImage(named: "lighteye-open.png")
        
        btnDuplicate.backgroundColor = .darkGray
        btnDuplicate.setTitleColor(UIColor.white, for: UIControl.State.normal)
        duplicateImage.image = UIImage(named: "lightduplicateback.png")
        
        btnAdd.backgroundColor = .darkGray
        btnAdd.setTitleColor(UIColor.white, for: UIControl.State.normal)
        addImage.image = UIImage(named: "lightAdding.png")
        
        btnShiftView.backgroundColor = .darkGray
        btnShiftView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        shiftViewImage.image = UIImage(named: "lighteye-open.png")
        
    
    }
    func LightMode(){
        
        mainView.backgroundColor = .lightGray
        btnEdit.backgroundColor = .white
        btnEdit.setTitleColor(UIColor.black, for: UIControl.State.normal)
        editImage.image = UIImage(named: "edit2.png")
        
        btnDelete.backgroundColor = .white
        btnDelete.setTitleColor(UIColor.black, for: UIControl.State.normal)
        deleteImage.image = UIImage(named: "Inkeddownload.png")
        
        btnEventView.backgroundColor = .white
        btnEventView.setTitleColor(UIColor.black, for: UIControl.State.normal)
        eventViewImage.image = UIImage(named: "eye-open.png")
        
        btnDuplicate.backgroundColor = .white
        btnDuplicate.setTitleColor(UIColor.black, for: UIControl.State.normal)
        duplicateImage.image = UIImage(named: "duplicateback.png")
        
        btnAdd.backgroundColor = .white
        btnAdd.setTitleColor(UIColor.black, for: UIControl.State.normal)
        addImage.image = UIImage(named: "adding.png")
        
        btnShiftView.backgroundColor = .white
        btnShiftView.setTitleColor(UIColor.black, for: UIControl.State.normal)
        shiftViewImage.image = UIImage(named: "eye-open.png")
        
    }
    
    
    func removeMeNow(selectedEvent:[String: Any]?, eventType:EventActionsViewController.SelectedEventType)  {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
       
        if (selectedEvent != nil) {
            delegate?.eventSelected(eventDetail: selectedEvent, eventType: eventType)
        }
//        delegate?.eventSelected(selectedEvent)
      
        
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        removeMeNow(selectedEvent: nil, eventType: .None)
    }
    
    @IBAction func addShiftTapped(_ sender: Any) {
        removeMeNow(selectedEvent: eventDetail, eventType: .Shift_Add)
    }
    @IBAction func viewShiftTapped(_ sender: Any) {
        removeMeNow(selectedEvent: eventDetail, eventType: .Shift_View)
    }
    
    @IBAction func editEventTapped(_ sender: Any) {
        removeMeNow(selectedEvent: eventDetail, eventType: .Event_Edit)
    }
    @IBAction func deleteEventTapped(_ sender: Any) {
        self.removeMeNow(selectedEvent: self.eventDetail, eventType: .Event_Delete)
        
    }
    
    @IBAction func viewEventTapped(_ sender: Any) {
        removeMeNow(selectedEvent:eventDetail, eventType: .Event_View)
    }
    @IBAction func eventDuplicate(_ sender: Any) {
        removeMeNow(selectedEvent:eventDetail, eventType: .Event_Duplicate)
    }
}
