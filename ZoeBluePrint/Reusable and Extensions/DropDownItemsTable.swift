//
//  DropDownItemsTable.swift
//  DropDownMenuComponent
//
//  Created by Rishi Chaurasia on 03/08/19.
//  Copyright © 2019 rishi. All rights reserved.
//

import UIKit

class DropDownItemsTable: UITableViewController {
    
    private enum valueType:String {
        case strings = "string"
        case dictionary = "dictionary"
     
        case unknown = "unknown"
    }
    
    typealias SelectionHandler = (Any) -> Void
   
    private var valuesType:valueType
    private let stringValues:[String]?
    private let dictionaryValues:[[String:Any]]?
    var country:String?
    private var onSelect : SelectionHandler?
    
    init(_ values : Any) {
        if let stringVals = values as? [String] {
            self.stringValues = stringVals
            self.dictionaryValues = nil
           self.valuesType = .strings
        
        } else  if let dictionaryVals = values as? [[String:Any]] {
            self.dictionaryValues = dictionaryVals
            self.stringValues = nil
            self.valuesType = .dictionary
       

        }else {
            self.dictionaryValues = nil
            self.stringValues = nil
            self.valuesType = .unknown
        
        }
    
        super.init(style: .plain)
        self.tableView.tableFooterView = UIView()

        
    }
    
    func showPopoverInDestinationVC( destination:UIViewController, sourceView: UIView,  onSelect : SelectionHandler? = nil) {
        self.onSelect = onSelect
        self.preferredContentSize = CGSize(width: 300, height: 220)
       
        switch valuesType {
         case .strings:
          
        var intHeight = 40
        let noOfCells = stringValues?.count ?? 0
        intHeight = (noOfCells * intHeight) + 10
          
             self.preferredContentSize = CGSize(width: 300, height: intHeight)
         case .dictionary:
          var intHeight = 40
          let noOfCells = dictionaryValues?.count ?? 0
          intHeight = (noOfCells * intHeight) + 10
             self.preferredContentSize = CGSize(width: 300, height: intHeight)
         default:
             self.preferredContentSize = CGSize(width: 300, height: 220)
         }
        
        let presentationController = RenderAsPopover.configurePresentation(forController: self)
        presentationController.sourceView = sourceView
        presentationController.sourceRect = sourceView.bounds
        presentationController.permittedArrowDirections = [.down, .up]
        destination.present(self, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch valuesType {
        case .strings:
            return stringValues?.count ?? 0
        case .dictionary:
            return dictionaryValues?.count ?? 0
        default:
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var cellTitle = ""
        
        
        if let strings = stringValues {
            cellTitle = strings[indexPath.row]
        }else  if let dictionaries = dictionaryValues {
            let rowData = dictionaries[indexPath.row]
            if let title = rowData [GetStateServiceStrings.keyStateName] as? String {
                cellTitle = title
            } else  if let title = rowData [GetCountryServiceStrings.keyCountryName] as? String {
                cellTitle = title
            } else  if let title = rowData [GetAddShiftSelectShiftStrings.keyShiftTaskName] as? String {
                cellTitle = title
            }
            else if let title = rowData [GetShiftRankListStrings.keyRank] as? String {
                cellTitle = title
            }
            else  if let title = rowData [GetEventType.keyEventTypeName] as? String {
                cellTitle = title
            }
            else  if let title = rowData [GetTimeZone.timeZoneName] as? String {
                cellTitle =   "\(title) [\(rowData [GetTimeZone.timeZoneCode] ?? "")]"
                print(cellTitle)
            }
            else  if let title = rowData [GetDocumentType.documentTypeName] as? String {
                cellTitle = title
            }else if let title = rowData[DayLight.day_status] as? String {
                cellTitle = title
            }else if let title = rowData[GetQuestionType.answer_detail] as? String{
                cellTitle = title
            }
        }
        cell.textLabel?.text = cellTitle //stringValues?[indexPath.row] ?? ""
        cell.textLabel?.font = UIFont(name: "Roboto_Regular", size: 14) 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        
        if let strings = stringValues {
            onSelect?(strings[indexPath.row] )
        } else  if let dictionaries = dictionaryValues {
            onSelect?(dictionaries[indexPath.row] )
        }
        
        
    }
}

class RenderAsPopover : NSObject, UIPopoverPresentationControllerDelegate {
    
    // `sharedInstance` because the delegate property is weak - the delegate instance needs to be retained.
    private static let sharedInstance = RenderAsPopover()
    
    private override init() {
        super.init()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    static func configurePresentation(forController controller : UIViewController) -> UIPopoverPresentationController {
        controller.modalPresentationStyle = .popover
        let presentationController = controller.presentationController as! UIPopoverPresentationController
        presentationController.delegate = RenderAsPopover.sharedInstance
        return presentationController
    }
    
}
