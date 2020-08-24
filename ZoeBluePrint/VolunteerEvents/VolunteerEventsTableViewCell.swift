//
//  VolunteerEventsTableViewCell.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 23/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolunteerEventsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var TitleLabel:UILabel!
    @IBOutlet weak var DescriptionLabel:UILabel!
    @IBOutlet weak var DateLabel:UILabel!
    @IBOutlet weak var DLabel:UILabel!
    @IBOutlet weak var MonthLabel:UILabel!
    @IBOutlet weak var WeekLabel:UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
