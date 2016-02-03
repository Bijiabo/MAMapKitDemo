//
//  SettingNormalTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/2.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SettingNormalTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        Helper.UI.setLabel(titleLabel, forStyle: Constant.TextStyle.Body.Blue)
        extension_setDefaultSelectedColor()
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
    
    var displaySeparatorLineView: Bool = true {
        didSet {
            separatorLineView.hidden = !displaySeparatorLineView
        }
    }

}
