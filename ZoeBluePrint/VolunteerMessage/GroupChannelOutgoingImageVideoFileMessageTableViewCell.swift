//
//  GroupChannelOutgoingImageVideoFileMessageTableViewCell.swift
//  SendBird-iOS
//
//  Created by Jed Gyeong on 11/6/18.
//  Copyright © 2018 SendBird. All rights reserved.
//

import UIKit
import SendBirdSDK
import AlamofireImage
import FLAnimatedImage

class GroupChannelOutgoingImageVideoFileMessageTableViewCell: UITableViewCell {
    weak var delegate: GroupChannelMessageTableViewCellDelegate?
    var channel: SBDGroupChannel?
    var msg: SBDFileMessage?
    var imageHash: Int = 0
    
    private var hideReadCount = false
    
    @IBOutlet weak var dateSeperatorContainerView: UIView!
    @IBOutlet weak var dateSeperatorLabel: UILabel!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var imageFileMessageImageView: FLAnimatedImageView!
    @IBOutlet weak var messageDateLabel: UILabel!
    @IBOutlet weak var messageStatusContainerView: UIView!
    @IBOutlet weak var fileTransferProgressViewContainerView: UIView!
    @IBOutlet weak var fileTransferProgressCircleView: CustomProgressCircle!
    @IBOutlet weak var fileTransferProgressLabel: UILabel!
    @IBOutlet weak var sendingFailureContainerView: UIView!
    @IBOutlet weak var readStatusContainerView: UIView!
    @IBOutlet weak var readStatusLabel: UILabel!
    @IBOutlet weak var sendingFlagImageView: UIImageView!
    @IBOutlet weak var resendButtonContainerView: UIView!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var videoPlayIconImageView: UIImageView!
    @IBOutlet weak var imageMessagePlaceholderImageView: UIImageView!
    @IBOutlet weak var videoMessagePlaceholderImageView: UIImageView!
    
    @IBOutlet weak var dateSeperatorContainerViewTopMargin: NSLayoutConstraint!
    @IBOutlet weak var dateSeperatorContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var messageStatusContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var messageContainerViewTopMargin: NSLayoutConstraint!
    @IBOutlet weak var messageContainerViewBottomMargin: NSLayoutConstraint!
    
    static let kDateSeperatorContainerViewTopMargin: CGFloat = 3.0
    static let kDateSeperatorContainerViewHeight: CGFloat = 65.0
    static let kMessageContainerViewTopMarginNormal: CGFloat = 6.0
    static let kMessageContainerViewTopMarginReduced: CGFloat = 3.0
    static let kMessageContainerViewBottomMarginNormal: CGFloat = 14.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMessage(currMessage: SBDFileMessage, prevMessage: SBDBaseMessage?, nextMessage: SBDBaseMessage?, failed: Bool) {
        var hideDateSeperator = false
        var hideMessageStatus = false
        var decreaseTopMargin = false
        
        self.msg = currMessage
        
        let clickMessageContainteGesture = UITapGestureRecognizer(target: self, action: #selector(GroupChannelOutgoingImageVideoFileMessageTableViewCell.clickImageVideoFileMessage(_:)))
        self.messageContainerView.addGestureRecognizer(clickMessageContainteGesture)
        
        let longClickMessageContainerGesture = UILongPressGestureRecognizer(target: self, action: #selector(GroupChannelOutgoingImageVideoFileMessageTableViewCell.longClickImageVideoFileMessage(_:)))
        self.messageContainerView.addGestureRecognizer(longClickMessageContainerGesture)
        
        self.resendButton.addTarget(self, action: #selector(GroupChannelOutgoingImageVideoFileMessageTableViewCell.clickResendImageVideoFileMessage(_:)), for: .touchUpInside)
        
        var prevMessageSender: SBDUser?
        var nextMessageSender: SBDUser?
        
        if prevMessage != nil {
            if prevMessage is SBDUserMessage {
                prevMessageSender = (prevMessage as! SBDUserMessage).sender
            }
            else if prevMessage is SBDFileMessage {
                prevMessageSender = (prevMessage as! SBDFileMessage).sender
            }
        }
        
        if nextMessage != nil {
            if nextMessage is SBDUserMessage {
                nextMessageSender = (nextMessage as! SBDUserMessage).sender
            }
            else if nextMessage is SBDFileMessage {
                nextMessageSender = (nextMessage as! SBDFileMessage).sender
            }
            
            if nextMessageSender != nil && nextMessageSender!.userId == self.msg!.sender!.userId {
                let nextReadCount = self.channel?.getReadMembers(with: nextMessage!, includeAllMembers: false).count
                let currReadCount = self.channel?.getReadMembers(with: self.msg!, includeAllMembers: false).count
                if nextReadCount == currReadCount || nextMessage!.messageId != 0 {
                    self.hideReadCount = true
                }
            }
        }
        
        if prevMessage != nil && Utils.checkDayChangeDayBetweenOldTimestamp(oldTimestamp: (prevMessage?.createdAt)!, newTimestamp: self.msg!.createdAt) {
            hideDateSeperator = false
        }
        else {
            hideDateSeperator = true
        }
        
        if prevMessageSender != nil && prevMessageSender?.userId == self.msg!.sender?.userId {
            if hideDateSeperator {
                decreaseTopMargin = true
            }
            else {
                decreaseTopMargin = false
            }
        }
        else {
            decreaseTopMargin = false
        }
        
        if nextMessageSender != nil && nextMessageSender?.userId == self.msg!.sender?.userId {
            if Utils.checkDayChangeDayBetweenOldTimestamp(oldTimestamp: (self.msg?.createdAt)!, newTimestamp: (nextMessage?.createdAt)!) {
                hideMessageStatus = false
            }
            else {
                hideMessageStatus = true
            }
        }
        else {
            hideMessageStatus = false
        }
        
        if hideDateSeperator {
            self.dateSeperatorContainerView.isHidden = true
            self.dateSeperatorContainerViewHeight.constant = 0
            self.dateSeperatorContainerViewTopMargin.constant = 0
        }
        else {
            self.dateSeperatorContainerView.isHidden = false
            self.dateSeperatorLabel.text = Utils.getDateStringForDateSeperatorFromTimestamp((self.msg?.createdAt)!)
            self.dateSeperatorContainerViewHeight.constant = GroupChannelOutgoingImageVideoFileMessageTableViewCell.kDateSeperatorContainerViewHeight
            self.dateSeperatorContainerViewTopMargin.constant = GroupChannelOutgoingImageVideoFileMessageTableViewCell.kDateSeperatorContainerViewTopMargin
        }
        
        if decreaseTopMargin {
            self.messageContainerViewTopMargin.constant = GroupChannelOutgoingImageVideoFileMessageTableViewCell.kMessageContainerViewTopMarginReduced
        }
        else {
            self.messageContainerViewTopMargin.constant = GroupChannelOutgoingImageVideoFileMessageTableViewCell.kMessageContainerViewTopMarginNormal
        }
        
        if hideMessageStatus && self.hideReadCount && !failed {
            self.messageDateLabel.text = ""
            self.messageStatusContainerView.isHidden = true
            self.readStatusContainerView.isHidden = true
            self.hideBottomMargin()
        }
        else {
            self.messageStatusContainerView.isHidden = false
            
            if (failed) {
                self.messageDateLabel.text = ""
                self.readStatusContainerView.isHidden = true
                self.resendButtonContainerView.isHidden = false
                self.resendButton.isEnabled = true
                self.sendingFailureContainerView.isHidden = false
                self.sendingFlagImageView.isHidden = true
            }
            else {
                self.messageDateLabel.text = Utils.getMessageDateStringFromTimestamp((self.msg?.createdAt)!)
                self.readStatusContainerView.isHidden = false
                self.showReadStatus(readCount: (self.channel?.getReadMembers(with: self.msg!, includeAllMembers: false).count)!)
                self.resendButtonContainerView.isHidden = true;
                self.resendButton.isEnabled = false
                self.sendingFailureContainerView.isHidden = true
                self.sendingFlagImageView.isHidden = true
            }
            
            self.messageContainerViewBottomMargin.constant = GroupChannelOutgoingImageVideoFileMessageTableViewCell.kMessageContainerViewBottomMarginNormal
        }
    }
    
    func getMessage() -> SBDFileMessage? {
        return self.msg
    }
    
    func showProgress(_ progress: CGFloat) {
        self.fileTransferProgressViewContainerView.isHidden = false
        self.sendingFailureContainerView.isHidden = true
        self.readStatusContainerView.isHidden = true
        self.fileTransferProgressCircleView.drawCircle(progress: progress)
        self.fileTransferProgressLabel.text = String(format: "%.2lf%%", progress * 100.0)
    }
    
    func hideProgress() {
        self.fileTransferProgressViewContainerView.isHidden = true
        self.sendingFailureContainerView.isHidden = true
    }
    
    func hideElementsForFailure() {
        self.fileTransferProgressViewContainerView.isHidden = true
        self.resendButtonContainerView.isHidden = true
        self.resendButton.isEnabled = false
        self.sendingFailureContainerView.isHidden = true
    }
    
    func showElementsForFailure() {
        self.fileTransferProgressViewContainerView.isHidden = true
        self.resendButtonContainerView.isHidden = false
        self.resendButton.isEnabled = true
        self.sendingFailureContainerView.isHidden = false
        self.bringSubviewToFront(self.sendingFailureContainerView)
        self.messageDateLabel.isHidden = true
    }
    
    func showReadStatus(readCount: Int) {
        self.sendingFlagImageView.isHidden = true
        self.readStatusContainerView.isHidden = false
        self.readStatusLabel.text = String(format: "Read %lu ∙", readCount)
        self.messageDateLabel.isHidden = false
    }
    
    func hideReadStatus() {
        self.sendingFlagImageView.isHidden = true
        self.readStatusContainerView.isHidden = true
    }
    
    func showBottomMargin() {
        self.messageContainerViewBottomMargin.constant = GroupChannelOutgoingImageVideoFileMessageTableViewCell.kMessageContainerViewBottomMarginNormal
    }
    
    func hideBottomMargin() {
        self.messageContainerViewBottomMargin.constant = 0
    }
    
    func hideAllPlaceholders() {
        self.videoPlayIconImageView.isHidden = true
        self.imageMessagePlaceholderImageView.isHidden = true
        self.videoMessagePlaceholderImageView.isHidden = true
    }
    
    @objc func clickImageVideoFileMessage(_ recognizer: UITapGestureRecognizer) {
        if let delegate = self.delegate {
            if delegate.responds(to: #selector(GroupChannelMessageTableViewCellDelegate.didClickImageVideoFileMessage(_:))) {
                delegate.didClickImageVideoFileMessage!(self.msg!)
            }
        }
    }
    
    @objc func longClickImageVideoFileMessage(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            if let delegate = self.delegate {
                if delegate.responds(to: #selector(GroupChannelMessageTableViewCellDelegate.didLongClickImageVideoFileMessage(_:))) {
                    delegate.didLongClickImageVideoFileMessage!(self.msg!)
                }
            }
        }
    }
    
    @objc func clickResendImageVideoFileMessage(_ sender: AnyObject) {
        if let delegate = self.delegate {
            if delegate.responds(to: #selector(GroupChannelMessageTableViewCellDelegate.didClickResendImageVideoFileMessage(_:))) {
                delegate.didClickResendImageVideoFileMessage!(self.msg!)
            }
        }
    }
    
    func setAnimatedImage(_ image: FLAnimatedImage?, hash: Int) {
        if image == nil || hash == 0 {
            self.imageHash = 0
            self.imageFileMessageImageView.animatedImage = nil
        }
        else {
            if self.imageHash == 0 || self.imageHash != hash {
                self.imageFileMessageImageView.image = nil
                self.imageFileMessageImageView.animatedImage = image
                self.imageHash = hash
            }
        }
    }
    
    func setImage(_ image: UIImage?) {
        if image == nil || hash == 0 {
            self.imageHash = 0
            self.imageFileMessageImageView.image = nil
        }
        else {
            let newImageHash = image!.jpegData(compressionQuality: 0.5).hashValue
            if self.imageHash == 0 || self.imageHash != hash {
                self.imageFileMessageImageView.animatedImage = nil
                self.imageFileMessageImageView.image = image
                self.imageHash = newImageHash
            }
        }
    }
}
