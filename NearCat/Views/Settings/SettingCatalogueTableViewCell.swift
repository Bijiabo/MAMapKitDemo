//
//  SettingCatalogueTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/2.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SettingCatalogueTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        extension_setDefaultSelectedColor()
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
        Helper.UI.setLabel(titleLabel, forStyle: Constant.TextStyle.Body.Blue)
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
