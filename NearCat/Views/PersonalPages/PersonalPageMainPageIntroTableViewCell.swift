//
//  PersonalPageMainPageIntroTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/6.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PersonalPageMainPageIntroTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        Helper.UI.setLabel(contentLabel, forStyle: Constant.TextStyle.Body.G2)
        Helper.UI.setLabel(addressLabel, forStyle: Constant.TextStyle.Cell.Small.G4)
        Helper.UI.setLabel(distanceLabel, forStyle: Constant.TextStyle.Cell.Small.Blue)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var content: String = String() {
        didSet {
            contentLabel.attributedText = Helper.UI.setLineSpacingForAttributedString(NSAttributedString(string: content), lineSpacing: Constant.TextStyle.Body.G2.font.pointSize*0.2)
        }
    }
    
    var address: String = String() {
        didSet {
            addressLabel.text = address
        }
    }
    
    var distance: String = String() {
        didSet {
            distanceLabel.text = distance
        }
    }

}
