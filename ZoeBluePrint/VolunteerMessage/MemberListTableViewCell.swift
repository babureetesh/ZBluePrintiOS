//
//  MemberListTableViewCell.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 14/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
protocol delegateWritePermissionSelection{
    func checkMarkClicked(selectedRow:Int)
}
class MemberListTableViewCell: UITableViewCell {
 var delegate :delegateWritePermissionSelection?
    @IBOutlet weak var btnWritePermission: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgViewUser: UIImageView!
    @IBOutlet weak var lblWritePermission: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func writePermissionSelection(_ sender: UIButton) {
        delegate?.checkMarkClicked(selectedRow: sender.tag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
