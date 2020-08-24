//
//  DashboardEventsTableViewCell.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 06/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class DashboardEventsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblDescription1: UILabel!
    @IBOutlet weak var lblDescription2: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
