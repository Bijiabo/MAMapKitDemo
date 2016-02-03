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
    @IBOutlet weak var thumbsCountButton: LikeButton!
    @IBOutlet weak var separatorLineView: UIView!
    
    var fluxId: Int = 0 {
        didSet {
            thumbsCountButton.fluxId = fluxId
        }
    }
    
    var commentId: Int = 0 {
        didSet {
            thumbsCountButton.fluxCommentId = commentId
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        Helper.UI.setLabel(dateLabel, forStyle: Constant.TextStyle.Cell.Small.G4)
        if let thumbsCountButtonTitleLabel = thumbsCountButton.titleLabel {
            Helper.UI.setLabel(thumbsCountButtonTitleLabel, forStyle: Constant.TextStyle.Cell.Small.G4)
        }
        
        selectedBackgroundView = UIView(frame: bounds)
        selectedBackgroundView!.backgroundColor = Constant.Color.CellSelected
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private var _userName: NSAttributedString = NSAttributedString()
    var userName: String = String() {
        didSet {
            _userName = NSAttributedString(string: "\(userName): ", attributes: [ NSForegroundColorAttributeName: Constant.Color.Theme ])
        }
    }
    
    private var _content: NSAttributedString = NSAttributedString()
    var content: String = String() {
        didSet {
            _content = NSAttributedString(string: content, attributes: [ NSForegroundColorAttributeName: Constant.Color.G4 ])
            let contentAttributedString = NSMutableAttributedString(attributedString: _userName)
            contentAttributedString.appendAttributedString(_content)
            contentLabel.attributedText = Helper.UI.setLineSpacingForAttributedString(contentAttributedString, lineSpacing: Constant.TextStyle.Body.Blue.font.pointSize*0.2)
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
            thumbsCountButton.count = thumbsCount
        }
    }
    
    var liked: Bool = false {
        didSet {
            thumbsCountButton.liked = liked
        }
    }

}
