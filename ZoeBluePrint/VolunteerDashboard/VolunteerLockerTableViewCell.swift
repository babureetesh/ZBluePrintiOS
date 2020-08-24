//
//  VolunteerLockerTableViewCell.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 21/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
protocol dataPass1 {
    func tagNumber(tag:Int)
    func tagdown(tag:Int)
}
class VolunteerLockerTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var DeleteButtonPressed:UIButton!
     @IBOutlet weak var DownloadButtonPressed:UIButton!
    var delegate:dataPass1!
    @IBOutlet weak var ImageLabel:UIImageView!
    @IBOutlet weak var DocumentTitle:UILabel!
    @IBOutlet weak var DocDescription:UILabel!
    @IBOutlet weak var DateLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func DeleteButtonTapped(_ sender: Any) {
        let b:Int! = ((sender as AnyObject).tag as! Int)
        self.delegate.tagdown(tag:b)
    }
    
  @IBAction func downloadButtonTapped(_ sender: Any) {
        let a:Int! = ((sender as AnyObject).tag as! Int)
        // delegate.tagNumber(tag: a!)
        self.delegate.tagNumber(tag: a)
    }
    
    
    

}
