//
//  LockerDetailTableViewCell.swift
//  ZoeBlueprint
//
//  Created by iOS Training on 24/09/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
protocol dataPass {
    func tagNumber(tag:Int)
    func tagdown(tag:Int)
}
class LockerDetailTableViewCell: UITableViewCell {

     
    @IBOutlet weak var NoDataView1: UIView!
       
       @IBOutlet weak var NoDataFound2: UILabel!
    
    @IBOutlet weak var lbnDocumentName: UILabel!
    
    @IBOutlet weak var lbnDocumentDate: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lbnText: UILabel!
    
    @IBOutlet weak var btnDownload: UIButton!
    
    @IBOutlet weak var btnTrash: UIButton!
   //
    var delegate:dataPass?
    @IBAction func clickDownload(_ sender: Any) {
        
        let b:Int! = ((sender as AnyObject).tag as! Int)
        self.delegate!.tagdown(tag:b)
        
        
    }
    
    
    @IBAction func clickDelete(_ sender: Any) {
        
        let a:Int! = ((sender as AnyObject).tag as! Int)
       // delegate.tagNumber(tag: a!)
        self.delegate!.tagNumber(tag: a)
        
         
                       
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
