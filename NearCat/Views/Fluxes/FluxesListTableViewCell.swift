//
//  FluxesListTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class FluxesListTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var catNameAndAgeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentImageViewHeight: NSLayoutConstraint!
    
    var id: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentImageView.clipsToBounds = true
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    var content: String = String() {
        didSet {
            contentLabel.text = content
        }
    }
    
    var imageHeight: Int = 0 {
        didSet {
            contentImageViewHeight.constant = CGFloat(imageHeight)
            contentImageView.updateConstraintsIfNeeded()
            self.updateConstraintsIfNeeded()
        }
    }

}
