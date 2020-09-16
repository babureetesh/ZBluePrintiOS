//
//  ChatGroupListTableViewCell.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 07/05/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit
protocol delegateChatGroupList{
    func memberClicked(selectedRow:Int)
    func plusClicked(selectedRow:Int)
}


class ChatGroupListTableViewCell: UITableViewCell {
    var delegate :delegateChatGroupList?
    @IBOutlet weak var lblChatGroupName: UILabel!
    @IBOutlet weak var lblChatLastMsg: UILabel!
     @IBOutlet weak var lblChatLastMsgDate: UILabel!
    @IBOutlet weak var lblUnReadMsgCount: UILabel!
    @IBOutlet weak var imgGroupChat: UIImageView!
    @IBOutlet weak var btnMember: UIButton!
    @IBOutlet weak var btnPlus: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func plusClicked(_ sender: UIButton) {
        
        delegate?.plusClicked(selectedRow: sender.tag)
    }
    @IBAction func btnMemberClicked(_ sender: UIButton) {
        
      
        delegate?.memberClicked(selectedRow: sender.tag)

    
    }

}
