//
//  NotificationListTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class NotificationListTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = Constant.Color.TableViewBackground
        containerView.backgroundColor = UIColor.whiteColor()
        containerView.layer.cornerRadius = 5.0
        containerView.layer.shadowColor = UIColor.blackColor().CGColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        containerView.layer.shadowRadius = 1.0
        containerView.layer.shadowOpacity = 0.1
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width - 24.0, height: 150), byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.path = path.CGPath
        headerImageView.layer.mask = maskLayer
        headerImageView.clipsToBounds = true
        
        Helper.UI.setLabel(titleLabel, forStyle: Constant.TextStyle.Cell.Title.Blue)
        Helper.UI.setLabel(contentLabel, forStyle: Constant.TextStyle.Body.G2)
        Helper.UI.setLabel(dateLabel, forStyle: Constant.TextStyle.Cell.Small.G4)
        
        // set selected style
        selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            containerView.backgroundColor = Constant.Color.CellSelected
        } else {
            containerView.backgroundColor = UIColor.whiteColor()
        }
    }
    
    var title: String = String() {
        didSet {
            titleLabel.text = title
        }
    }
    
    var content: String = String() {
        didSet {
            contentLabel.attributedText = Helper.UI.setLineSpacingForAttributedString(NSAttributedString(string: content), lineSpacing: Constant.TextStyle.Body.G2.font.pointSize*0.2)
        }
    }
    
    var date: String = String() {
        didSet {
            dateLabel.text = date
        }
    }

}
