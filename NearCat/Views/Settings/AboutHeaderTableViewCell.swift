//
//  AboutHeaderTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/2.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class AboutHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        Helper.UI.setLabel(versionLabel, forStyle: Constant.TextStyle.SegmentedControl.Tab.Blue)
        backgroundColor = Constant.Color.TableViewBackground
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var version: String = "1.0.0" {
        didSet {
            versionLabel.text = "版本 \(version)"
        }
    }
}
