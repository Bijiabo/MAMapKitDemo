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
    @IBOutlet weak var commentCountButton: UIButton!
    @IBOutlet weak var distanceCountButton: UIButton!
    @IBOutlet weak var likeCountButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    var id: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentImageView.clipsToBounds = true
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    var likeCount: Int = 0 {
        didSet {
            let likeCountButtonTitle: String = "like \(likeCount)"
            likeCountButton.setTitle(likeCountButtonTitle, forState: UIControlState.Normal)
            likeCountButton.setTitle(likeCountButtonTitle, forState: UIControlState.Highlighted)
            likeCountButton.setTitle(likeCountButtonTitle, forState: UIControlState.Selected)
            if #available(iOS 9.0, *) {
                likeCountButton.setTitle(likeCountButtonTitle, forState: UIControlState.Focused)
            }
        }
    }
    
    var commentCount: Int = 0 {
        didSet {
            let commentCountButtonTitle: String = "comment \(commentCount)"
            commentCountButton.setTitle(commentCountButtonTitle, forState: UIControlState.Normal)
            commentCountButton.setTitle(commentCountButtonTitle, forState: UIControlState.Highlighted)
            commentCountButton.setTitle(commentCountButtonTitle, forState: UIControlState.Selected)
            if #available(iOS 9.0, *) {
                commentCountButton.setTitle(commentCountButtonTitle, forState: UIControlState.Focused)
            }
        }
    }
    
    var distance: Double = 0 {
        didSet {
            let distanceCountButtonTitle: String = "Distance \(distance) Km"
            distanceCountButton.setTitle(distanceCountButtonTitle, forState: UIControlState.Normal)
            distanceCountButton.setTitle(distanceCountButtonTitle, forState: UIControlState.Highlighted)
            distanceCountButton.setTitle(distanceCountButtonTitle, forState: UIControlState.Selected)
            if #available(iOS 9.0, *) {
                distanceCountButton.setTitle(distanceCountButtonTitle, forState: UIControlState.Focused)
            }
        }
    }
    
    var showFollowButton: Bool = true {
        didSet {
            followButton.hidden = !showFollowButton
        }
    }

    var date: String = String() {
        didSet {
            dateLabel.text = date
        }
    }

}
