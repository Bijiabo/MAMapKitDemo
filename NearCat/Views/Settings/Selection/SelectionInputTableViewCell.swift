//
//  SelectionInputTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/24.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SelectionInputTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var separatorLineView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapClearButton(sender: AnyObject) {
        
    }

    var placeholder: String = String() {
        didSet {
            textInput.placeholder = placeholder
        }
    }
}
