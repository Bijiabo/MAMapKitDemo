//
//  ArchiveListEditableTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/31.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class ArchiveListEditableTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
    
    var identifier: String = String()
    var headerTitle: String = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        Helper.UI.setLabel(titleLabel, forStyle: Constant.TextStyle.Body.Blue)
        Helper.UI.setLabel(valueLabel, forStyle: Constant.TextStyle.Placeholder.G4)
        
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
        
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
