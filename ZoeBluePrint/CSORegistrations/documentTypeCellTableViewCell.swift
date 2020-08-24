//
//  documentTypeCellTableViewCell.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 18/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
protocol csoregistrationdeletebutton {
    func deleteButton(delTag:Int)
}
class documentTypeCellTableViewCell: UITableViewCell{
 
    
    @IBOutlet weak var documentImage: UIImageView!
    
    @IBOutlet weak var lbnDocumentTitle: UILabel!
    
    @IBOutlet weak var lbnDocumentSubTitle: UILabel!
    
    @IBOutlet weak var deletebuttonInDocumentView: UIButton!
    var delegate:csoregistrationdeletebutton?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func deleteButton(_ sender: Any) {
        
        let b:Int! = ((sender as AnyObject).tag as! Int)
        self.delegate?.deleteButton(delTag: b)
        
    }
    
    

}
