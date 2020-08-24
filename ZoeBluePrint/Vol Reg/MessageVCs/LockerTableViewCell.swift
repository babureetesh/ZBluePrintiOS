//
//  LockerTableViewCell.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 20/09/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class LockerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DocImage: UIImageView!
    @IBOutlet weak var DocLabel: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func DownloadingButtonPressed(_ sender: Any) {
    
    }
    
    
    
    @IBAction func DeleteButtonPressed(_ sender: Any) {

        
}
}
