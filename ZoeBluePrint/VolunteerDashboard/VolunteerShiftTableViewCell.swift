//
//  VolunteerShiftTableViewCell.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 12/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

class VolunteerShiftTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var WeekLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var StatusNameTapped: UIButton!
    @IBOutlet weak var StatusName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func ShiftListTapped(_ sender: Any) {
        
        
        
        
        let index_value = self.StatusNameTapped.tag
            //print(index_value)
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: ["selectedIndex":index_value])
        

        
}
    

}

