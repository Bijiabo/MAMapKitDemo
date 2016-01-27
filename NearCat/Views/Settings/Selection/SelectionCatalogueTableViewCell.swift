//
//  SelectionCatalogueTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/24.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SelectionCatalogueTableViewCell: UITableViewCell, CustomSeparatorCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
    
    var rawValue: String = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        extension_setDefaultSelectedColor()
        
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
        
        Helper.UI.setLabel(titleLabel, forStyle: Constant.TextStyle.Body.Blue)
        Helper.UI.setLabel(valueLabel, forStyle: Constant.TextStyle.Placeholder)
        valueLabel.text = String()
        
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
    
    var value: String = String() {
        didSet {
            valueLabel.text = value
        }
    }
    
    var displaySeparatorLine: Bool = true {
        didSet {
            separatorLineView.hidden = !displaySeparatorLine
        }
    }

}
