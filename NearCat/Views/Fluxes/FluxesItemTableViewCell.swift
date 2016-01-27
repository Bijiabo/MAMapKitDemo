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
    @IBOutlet weak var separatorLineView: UIView!
    
    var id: Int = 0
    var userId: Int = 0
    weak var navigationController: UINavigationController?
    weak var followActionController: FollowActionControllerProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentImageView.clipsToBounds = true
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        selectedBackgroundView = UIView(frame: bounds)
        selectedBackgroundView!.backgroundColor = Constant.Color.CellSelected
        
        followButton.layer.cornerRadius = 12.0
        followButton.layer.borderColor = Constant.Color.Theme.CGColor
        followButton.layer.borderWidth = 1.0
        
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
        
        // add tap avatar action
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapAvatar:")))
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
            let likeCountButtonTitle: String = "\(likeCount)"
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
            let commentCountButtonTitle: String = "\(commentCount)"
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
            let distanceCountButtonTitle: String = "\(distance) Km"
            distanceCountButton.setTitle(distanceCountButtonTitle, forState: UIControlState.Normal)
            distanceCountButton.setTitle(distanceCountButtonTitle, forState: UIControlState.Highlighted)
            distanceCountButton.setTitle(distanceCountButtonTitle, forState: UIControlState.Selected)
            if #available(iOS 9.0, *) {
                distanceCountButton.setTitle(distanceCountButtonTitle, forState: UIControlState.Focused)
            }
        }
    }
    
    var following: Bool = true {
        didSet {
            followButton.hidden = following || userId == FHelper.current_user.id
        }
    }

    var date: String = String() {
        didSet {
            dateLabel.text = date
        }
    }
    
    func tapAvatar(sender: UITapGestureRecognizer) {
        let personalPageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("personalPage") as! PersonalPageTableViewController
        personalPageVC.user_id = userId
        navigationController?.pushViewController(personalPageVC, animated: true)
    }
    
    @IBAction func tapFollowButton(sender: AnyObject) {
        followActionController?.follow?(userId: userId)
    }

}
