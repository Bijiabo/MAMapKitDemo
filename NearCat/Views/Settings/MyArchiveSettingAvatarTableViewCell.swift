//
//  MyArchiveSettingAvatarTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/24.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class MyArchiveSettingAvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarContainerView: UIView!
    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var avatarLabel: UILabel!
    
    var delegate: MyArchiveTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .None
        backgroundColor = Constant.Color.TableViewBackground
        
        avatarContainerView.layer.cornerRadius = 50.0
        avatarContainerView.clipsToBounds = true
        avatarImageView.backgroundColor = Constant.Color.Theme
        
        Helper.UI.setLabel(avatarLabel, forStyle: Constant.TextStyle.Cell.Small.White)
        
        avatarContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapAvatar:")))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var title: String = "修改头像" {
        didSet {
            avatarLabel.text = title
        }
    }
    
    // MARK: - user actions
    
    func tapAvatar(sender: UITapGestureRecognizer) {
        delegate?.tapAvatar()
    }

}
