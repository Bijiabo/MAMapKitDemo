//
//  FollowingTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/13.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var id: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectedBackgroundView = UIView(frame: bounds)
        selectedBackgroundView!.backgroundColor = Constant.Color.CellSelected
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var userName: String = String() {
        didSet {
            userNameLabel.text = userName
        }
    }
}
