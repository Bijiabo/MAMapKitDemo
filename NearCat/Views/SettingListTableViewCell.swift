//
//  SettingListTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/11.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SettingListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
    
    var identifier: String = String()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        extension_setDefaultSelectedColor()
        
        Helper.UI.setLabel(titleLabel, forStyle: Constant.TextStyle.Cell.Title.Blue)
        
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var title: String? = String() {
        didSet {
            titleLabel.text = title
        }
    }
    
    var displaySeparator: Bool = true {
        didSet {
            separatorLineView.hidden = !displaySeparator
        }
    }

}
