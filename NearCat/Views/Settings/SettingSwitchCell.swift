//
//  SettingSwitchCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/2.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SettingSwitchCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var separatorLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .None
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
        Helper.UI.setLabel(titleLabel, forStyle: Constant.TextStyle.Body.Blue)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapSwitchButton(sender: AnyObject) {
        if switchButton.on {
            
        } else {
            
        }
    }
    
    var title: String = String() {
        didSet {
            titleLabel.text = title
        }
    }
    
    var on: Bool = true {
        didSet {
            switchButton.setOn(on, animated: false)
        }
    }
    
    var displaySeparatorLineView: Bool = true {
        didSet {
            separatorLineView.hidden = !displaySeparatorLineView
        }
    }

}
