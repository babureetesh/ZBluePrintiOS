//
//  VolEventsListTableViewCell.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 25/07/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolEventsListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
