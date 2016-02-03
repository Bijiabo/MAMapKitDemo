//
//  CatArchiveListTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/1.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class CatArchiveListTableViewCell: UITableViewCell {

    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        extension_setDefaultSelectedColor()
        
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
        Helper.UI.setLabel(catNameLabel, forStyle: Constant.TextStyle.Cell.Title.Blue)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var name: String = String() {
        didSet {
            catNameLabel.text = name
        }
    }
    
    var displaySeparatorLine: Bool = true {
        didSet {
            separatorLineView.hidden = !displaySeparatorLine
        }
    }

}
