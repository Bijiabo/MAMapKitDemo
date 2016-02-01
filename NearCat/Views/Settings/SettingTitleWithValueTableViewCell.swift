//
//  SettingTitleWithValueTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/2.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SettingTitleWithValueTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        extension_setDefaultSelectedColor()
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
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
    
    var displaySeparatorLineView: Bool = true {
        didSet {
            separatorLineView.hidden = !displaySeparatorLineView
        }
    }

}
