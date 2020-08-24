//
//  NotificationTableViewCell.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 17/01/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ImageView: UIImageView!
     @IBOutlet weak var TitleLabel: UILabel!
     @IBOutlet weak var DescriptionLable: UILabel!
      @IBOutlet weak var DateTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
