//
//  VolunteerUpcomingTableViewCell.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 07/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolunteerUpcomingTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var WeekLabel: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var Description2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
