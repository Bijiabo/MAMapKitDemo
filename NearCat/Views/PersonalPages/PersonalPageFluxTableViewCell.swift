//
//  PersonalPageFluxTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/6.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PersonalPageFluxTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var separatorLineView: UIView!
    
    var id: Int = 0
    var liked: Bool = false {
        didSet {
            let image: UIImage = liked ? UIImage(named: "cell_comment_icon_like_sel")! : UIImage(named: "cell_comment_icon_like_nor")!
            
            likeButton.setImage(image, forState: UIControlState.Normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        extension_setDefaultSelectedColor()
        
        Helper.UI.setLabel(dateLabel, forStyle: Constant.TextStyle.Body.Blue)
        Helper.UI.setLabel(contentLabel, forStyle: Constant.TextStyle.Body.G2)
        separatorLineView.backgroundColor = Constant.Color.TableViewBackground
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var date: String = String() {
        didSet {
            dateLabel.text = date
        }
    }
    
    var content: String = String() {
        didSet {
            contentLabel.attributedText = Helper.UI.setLineSpacingForAttributedString(NSAttributedString(string: content), lineSpacing: Constant.TextStyle.Body.G2.font.pointSize*0.2)
        }
    }
    
    var displaySeparatorLineView: Bool = true {
        didSet {
            separatorLineView.hidden = !displaySeparatorLineView
        }
    }

    @IBAction func tapLikeButton(sender: AnyObject) {
    }
    
}
