//
//  notificationCell.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 06/12/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class notificationCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var LbnProject1: UILabel!
    
    
    @IBOutlet weak var lbnDateAndTime: UILabel!
    @IBOutlet weak var lbnNotification: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
