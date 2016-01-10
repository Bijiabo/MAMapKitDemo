//
//  FluxDetailTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/10.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class FluxDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var catNameAndAgeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeCountButton: UIButton!
    @IBOutlet weak var commentCountButton: UIButton!
    @IBOutlet weak var distanceCountButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
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
            userNameLabel.text = userName
        }
    }
    
    var content: String = String() {
        didSet {
            contentLabel.text = content
        }
    }
    
    var date: String = String() {
        didSet {
            dateLabel.text = date
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
    
    var catName: String = String() {
        didSet {
            _updateCatNameAndAgeLabel()
        }
    }
    
    var catAge: Int = 0 {
        didSet {
            _updateCatNameAndAgeLabel()
        }
    }
    
    private func _updateCatNameAndAgeLabel() {
        catNameAndAgeLabel.text = "\(catName) \(catAge)岁"
    }
    
    // TODO: - set images display
}
