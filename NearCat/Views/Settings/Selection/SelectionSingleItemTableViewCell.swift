//
//  SelectionSingleItemTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/24.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SelectionSingleItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkStatusImageView: UIImageView!
    @IBOutlet weak var separatorLineView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
        Helper.UI.setLabel(titleLabel, forStyle: Constant.TextStyle.Cell.Title.Blue)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var check: Bool = false {
        didSet {
            if check {
                checkStatusImageView.image = UIImage(named: "list_icon_check_sel")
            } else {
                checkStatusImageView.image = UIImage(named: "list_icon_check_nor")
            }
        }
    }
    
    var title: String = String() {
        didSet {
            titleLabel.text = title
        }
    }
    
    var displayUnselectMark: Bool = true {
        didSet {
            if !check && !displayUnselectMark {
                checkStatusImageView.hidden = true
            } else {
                checkStatusImageView.hidden = false
            }
        }
    }

}
