//
//  SeeFollowersTableViewCell.swift
//  ZoeBlue//print
//
//  Created by iOS Training on 27/11/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit

protocol delegateSeeFollowers{
    func unlinkClicked(selectedRow:Int)
    func chatClicked(selectedRow:Int)
    
}


class SeeFollowersTableViewCell: UITableViewCell {
    var delegate :delegateSeeFollowers?
    
    @IBOutlet weak var StudentName: UILabel!
    
    @IBOutlet weak var GradeDate: UILabel!
    
    
    @IBOutlet weak var lightStarView: FloatRatingView!
    
    
    @IBOutlet weak var AttendedHrsLbn: UILabel!
    
    
    @IBOutlet weak var rank_status: UIButton!
    
    
    @IBOutlet weak var RankImage: UIImageView!
    
    @IBOutlet weak var emailLAbel: UILabel!
    
    @IBOutlet weak var NumberLabel: UILabel!
   
    @IBOutlet weak var rankAverage: UILabel!
    @IBOutlet weak var attendhour: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var attendRating: UILabel!
    
    @IBOutlet weak var btnMessagePressed: UIButton!
    @IBOutlet weak var unlinkPressed: UIButton!
    @IBOutlet weak var btnUnlinkFollowersTapped: UIButton!
    
    @IBOutlet weak var AverageRateView: FloatRatingView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func btnUnlink(_ sender: UIButton) {
        
      
        delegate?.unlinkClicked(selectedRow: sender.tag)

    
    }
    
    
    @IBAction func unlinkButton(_ sender: UIButton) {
          delegate?.unlinkClicked(selectedRow: sender.tag)
        
    }
    
    @IBAction func btnMessage(_ sender: UIButton) {
        
//         message?.messageClicked(selectedRow: sender.tag)
        delegate?.chatClicked(selectedRow: sender.tag)
      
    }
    
    
   
    
    
    
    
    
    
}
