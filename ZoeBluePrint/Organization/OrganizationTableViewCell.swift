//
//  OrganizationTableViewCell.swift
//  ZoeBluePrint
//
//  Created by Reetesh Bajpai on 19/08/20.
//  Copyright © 2020 Reetesh Bajpai. All rights reserved.
//

import UIKit


protocol delegateOrganizationCell{
    func linkUnlink(selectedRow:Int)
    
    
}
class OrganizationTableViewCell: UITableViewCell {

    @IBOutlet weak var orgName: UILabel!
    @IBOutlet weak var orgEmail: UILabel!
    @IBOutlet weak var btnLink: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    
    var delegate :delegateOrganizationCell?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnLinkUnlink(_ sender: UIButton) {
        
        delegate?.linkUnlink(selectedRow: sender.tag)
    }

}
