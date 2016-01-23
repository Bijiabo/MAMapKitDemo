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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .None
        backgroundColor = Constant.Color.TableViewBackground
        
        avatarContainerView.layer.cornerRadius = 50.0
        avatarContainerView.clipsToBounds = true
        
        Helper.UI.setLabel(avatarLabel, forStyle: Constant.TextStyle.Cell.Small.White)
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

}
