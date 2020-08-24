//
//  ConnectedUserListTableViewCell.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 10/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
protocol delegateConnectedUserlistCell{
    func checkMarkClicked(selectedRow:Int)
}
class ConnectedUserListTableViewCell: UITableViewCell {
     var delegate :delegateConnectedUserlistCell?
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUserImage: UIImageView!
    @IBOutlet weak var btnCheckMark: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkMarkSelect(_ sender: UIButton) {
        delegate?.checkMarkClicked(selectedRow: sender.tag)
    }
}
