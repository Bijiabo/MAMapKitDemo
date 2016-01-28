//
//  TrendsListTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class TrendsListTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var separatorLineView: UIView!
    
    var type: String = String()
    var id: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        extension_setDefaultSelectedColor()
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
        previewImageView.clipsToBounds = true
        Helper.UI.setLabel(contentLabel, forStyle: Constant.TextStyle.Body.G2)
        Helper.UI.setLabel(dateLabel, forStyle: Constant.TextStyle.Cell.Small.G4)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var _userName: NSAttributedString = NSAttributedString()
    var userName: String = String() {
        didSet {
            _userName = NSAttributedString(string: userName, attributes: [
                NSForegroundColorAttributeName: Constant.Color.Theme,
                NSFontAttributeName: Constant.Font.Regular.Size_13
                ])
        }
    }
    
    var action: String = String()
    
    var _content: NSAttributedString = NSAttributedString()
    var content: String = String() {
        didSet {
            _content = NSAttributedString(string: " \(action)\(content)", attributes: [
                NSForegroundColorAttributeName: Constant.Color.G2,
                NSFontAttributeName: Constant.Font.Regular.Size_13
                ])
            let _contentMutableString = NSMutableAttributedString(attributedString: _userName)
            _contentMutableString.appendAttributedString(_content)
            contentLabel.attributedText = _contentMutableString
        }
    }
    
    var date: String = String() {
        didSet {
            dateLabel.text = date
        }
    }

}
