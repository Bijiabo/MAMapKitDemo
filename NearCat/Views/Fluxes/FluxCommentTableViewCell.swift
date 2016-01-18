//
//  FluxCommentTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/10.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class FluxCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var thumbsCountButton: UIButton!
    
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
    
    var content: String = String() {
        didSet {
            contentLabel.text = content
        }
    }
    
    var avatarURL: String = String() {
        didSet {
            // TODO: complete display user's avatar image function
        }
    }
    
    var date: String = String() {
        didSet {
            dateLabel.text = date
        }
    }
    
    var thumbsCount: Int = 0 {
        didSet {
            let thumbsCountButtonTitle: String = "thumbs \(thumbsCount)"
            thumbsCountButton.setTitle(thumbsCountButtonTitle, forState: UIControlState.Normal)
            thumbsCountButton.setTitle(thumbsCountButtonTitle, forState: UIControlState.Highlighted)
            thumbsCountButton.setTitle(thumbsCountButtonTitle, forState: UIControlState.Selected)
            if #available(iOS 9.0, *) {
                thumbsCountButton.setTitle(thumbsCountButtonTitle, forState: UIControlState.Focused)
            }
        }
    }

}
