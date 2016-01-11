//
//  Settings_Header_TableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/11.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class Settings_Header_TableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var catsLabel: UILabel!
    @IBOutlet weak var followAndThumbCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        clipsToBounds = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
