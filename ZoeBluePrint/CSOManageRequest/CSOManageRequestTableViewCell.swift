//
//  CSOManageRequestTableViewCell.swift
//  ZoeBlue//print
//
//  Created by HashTag Labs on 22/10/19.
//  Copyright © 2019 Reetesh Bajpai. All rights reserved.
//

import UIKit
protocol tagNumberOfButton {
    func tagNumberForRankChange(tag:Int)
    func tagNumberForStatusChange(tag:Int)
    func tagNumberForchat(tag:Int)
    func tagNumberForSelection(tag:Int)
    
}
class CSOManageRequestTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var ChatOptionTapped: UIButton!
    
    @IBOutlet weak var updatebutton: UIButton!
    @IBOutlet weak var EmailDescription: UILabel!
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var TaskDescription: UILabel!
    @IBOutlet weak var dateDescription: UILabel!
    @IBOutlet weak var timeDescription: UILabel!
    @IBOutlet weak var AttendedDesription: UILabel!
    @IBOutlet weak var rankPressed: UIButton!
    @IBOutlet weak var statusChanged: UIButton!
    @IBOutlet weak var RankDescription: UILabel!
    @IBOutlet weak var statusDescription: UILabel!
    
    @IBOutlet weak var lablRankComment: UILabel!
    
    @IBOutlet weak var lightStarView: FloatRatingView!
    @IBOutlet weak var lablChangeStatus: UILabel!
    @IBOutlet weak var lablRate: UILabel!
    @IBOutlet weak var lablDeclineComment: UILabel!
    @IBOutlet weak var declineComment: UILabel!
    @IBOutlet weak var RankComment: UILabel!
    var delegateObj:tagNumberOfButton!
   @IBOutlet weak var starViewCell: FloatRatingView!
    
    @IBOutlet weak var btnSelection: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func UpdateButtonTapped(_ sender: Any) {
        
    
//       var index_value = self.statusChanged.tag
//                    print(index_value)
//                   self.delegateObj.tagNumberForRankChange(tag: index_value)
//
        
    }
    
    @IBAction func rankfunction(_ sender: Any) {
        var index_value = self.rankPressed.tag
         //print(index_value)
        self.delegateObj.tagNumberForRankChange(tag: index_value)
        
    }
    
    
    
    @IBAction func btnChating(_ sender: Any) {
        
        print("chat button clicked")
        let index_value = self.ChatOptionTapped.tag
         print(index_value)
        self.delegateObj.tagNumberForchat(tag: index_value)
    }
    
    
    @IBAction func btnStatus(_ sender: Any) {
        
        var status_btn_index = self.statusChanged.tag
        print(status_btn_index)
        self.delegateObj.tagNumberForStatusChange(tag: status_btn_index)
        
        let index_value = self.statusChanged.tag
               print(index_value)
              self.delegateObj.tagNumberForRankChange(tag: index_value)
    }
    
    @IBAction func btnSelection(_ sender: Any) {
   let index_value = self.btnSelection.tag
        self.delegateObj.tagNumberForSelection(tag: index_value)
    }
    
    
}
