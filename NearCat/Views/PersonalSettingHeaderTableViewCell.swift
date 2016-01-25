//
//  Settings_Header_TableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/11.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalSettingHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImageContainerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var catsLabel: UILabel!
    @IBOutlet weak var followAndThumbCountLabel: UILabel!
    
    var delegate: PersonalSettingHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundImageContainerView.clipsToBounds = true
        clipsToBounds = false
        selectionStyle = .None
        
        // add tap gestures
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapAvatar:")))
        backgroundImageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: Selector("longPressBackgroundImage:")))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var userName: String = String() {
        didSet {
            usernameLabel.text = userName
        }
    }
    
    var cats: [JSON] = [JSON]() {
        didSet {
            let catsNamses = cats.map { (cat) -> String in
                cat["name"].stringValue
            }
            catsLabel.text = catsNamses.joinWithSeparator(", ")
        }
    }
    
    var followingCount: Int = 0 {
        didSet {
            _updateFollowAndThumbCountLabel()
        }
    }
    
    var thumbCount: Int = 0 {
        didSet {
            _updateFollowAndThumbCountLabel()
        }
    }

    private func _updateFollowAndThumbCountLabel() {
        followAndThumbCountLabel.text = "\(followingCount)人关注 \(thumbCount)个赞"
    }
    
    // MARK: - user actions
    
    func tapAvatar(sender: UITapGestureRecognizer) {
        delegate?.tapAvatar?()
    }
    
    func longPressBackgroundImage(sender: UILongPressGestureRecognizer) {
        delegate?.longPressBackgroundImage?()
    }
}
