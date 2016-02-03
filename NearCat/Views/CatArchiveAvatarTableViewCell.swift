//
//  CatArchiveAvatarTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit

class CatArchiveAvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    var delegate: CatArchiveDetailTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        
        avatarImageView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2.0
        
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapAvatarImageView:")))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func tapAvatarImageView(sender: UITapGestureRecognizer) {
        delegate?.tapAvatar()
    }

}
