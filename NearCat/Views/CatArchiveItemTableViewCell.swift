//
//  CatArchiveItemTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit

class CatArchiveItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    var key: String = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
