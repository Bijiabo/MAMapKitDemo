//
//  PrivateMessageListTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PrivateMessageListTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var userName: String = String() {
        didSet {
            _updateContentLabel()
        }
    }
    
    var content: String = String() {
        didSet {
            _updateContentLabel()
        }
    }
    
    private func _updateContentLabel() {
        contentLabel.text = "\(userName): \(content)"
    }
    
    var userId: Int = 0 

}
