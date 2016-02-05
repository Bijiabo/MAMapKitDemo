//
//  PersonalPageMainPageTitleWithValueTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/6.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PersonalPageMainPageTitleWithValueTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        Helper.UI.setLabel(titleLabel, forStyle: Constant.TextStyle.Body.Blue)
        Helper.UI.setLabel(valueLabel, forStyle: Constant.TextStyle.Body.G3)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var title: String = String() {
        didSet {
            titleLabel.text = title
        }
    }
    
    var value: String = String() {
        didSet {
            valueLabel.text = value
        }
    }

}
