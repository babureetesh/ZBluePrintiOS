//
//  CustomDetailTableViewCell.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 18/06/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class CustomDetailTableViewCell: UITableViewCell {

    
   
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var lableDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
}
