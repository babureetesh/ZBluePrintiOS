//
//  EventDetailTableViewCell.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 11/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class EventDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
