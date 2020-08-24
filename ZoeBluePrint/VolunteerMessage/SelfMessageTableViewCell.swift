//
//  SelfMessageTableViewCell.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 22/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class SelfMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
