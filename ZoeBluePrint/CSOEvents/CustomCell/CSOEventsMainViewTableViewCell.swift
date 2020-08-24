//
//  CSOEventsMainViewTableViewCell.swift
//  ZoeBlue//print
//
//  Created by Rishi Chaurasia on 20/07/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit


class CSOEventsMainViewTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblEventTitle: VerticalAlignLabel!
    @IBOutlet weak var lblEvenRegistration: VerticalAlignLabel!
    @IBOutlet weak var eventActionButton: UIButton!
    
    @IBOutlet weak var lbnevnetTime: VerticalAlignLabel!
    
    
    
    
    
     var actionBlock: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblEventTitle.contentMode = .center
        lblEvenRegistration.contentMode = .top
        lbnevnetTime.contentMode = .top
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func eventActionButtonClicked(_ sender: Any) {
        actionBlock?()
    }
    
}

