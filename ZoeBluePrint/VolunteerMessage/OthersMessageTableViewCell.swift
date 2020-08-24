//
//  OthersMessageTableViewCell.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 22/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit

class OthersMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblmessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
