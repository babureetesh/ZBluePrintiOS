//
//  getShiftDataCell.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 01/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class getShiftDataCell: UITableViewCell {

    
    @IBOutlet weak var shiftDate: UILabel!
    
    @IBOutlet weak var shiftMonth: UILabel!
    
    @IBOutlet weak var shiftDay: UILabel!
    
    @IBOutlet weak var lbnEventName: UILabel!
    
    @IBOutlet weak var lbnEventTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
