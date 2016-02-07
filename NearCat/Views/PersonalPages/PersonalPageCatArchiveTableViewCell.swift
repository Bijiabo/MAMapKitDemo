//
//  PersonalPageCatArchiveTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/6.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalPageCatArchiveTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var avatarImageView: AvatarImageView!
    
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var genderTitleLabel: UILabel!
    @IBOutlet weak var breedTitleLabel: UILabel!
    @IBOutlet weak var ageTitleLabel: UILabel!
    @IBOutlet weak var tagTitleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    
    @IBOutlet weak var tagContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        
        contentView.backgroundColor = Constant.Color.TableViewBackground
        containerView.backgroundColor = UIColor.whiteColor()
        containerView.layer.cornerRadius = 5.0
        
        Helper.UI.setLabel(nameTitleLabel, forStyle: Constant.TextStyle.Body.Blue)
        Helper.UI.setLabel(genderTitleLabel, forStyle: Constant.TextStyle.Body.Blue)
        Helper.UI.setLabel(breedTitleLabel, forStyle: Constant.TextStyle.Body.Blue)
        Helper.UI.setLabel(ageTitleLabel, forStyle: Constant.TextStyle.Body.Blue)
        Helper.UI.setLabel(tagTitleLabel, forStyle: Constant.TextStyle.Body.Blue)
        
        Helper.UI.setLabel(nameLabel, forStyle: Constant.TextStyle.Body.G2)
        Helper.UI.setLabel(genderLabel, forStyle: Constant.TextStyle.Body.G2)
        Helper.UI.setLabel(ageLabel, forStyle: Constant.TextStyle.Body.G2)
        Helper.UI.setLabel(breedLabel, forStyle: Constant.TextStyle.Body.G2)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var catData: JSON = JSON([]) {
        didSet {
            nameLabel.text = catData["name"].stringValue
            ageLabel.text = "\(catData["age"].intValue)岁"
            genderLabel.text = catData["gender"].intValue == 1 ? "公猫" : "母猫"
            breedLabel.text = catData["breed"].stringValue
            
            if let avatarPath = catData["avatar"].string {
                Helper.setRemoteImageForImageView(avatarImageView, imagePath: avatarPath)
            }
        }
    }

}
