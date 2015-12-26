//
//  CatArchiveDetailItemTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit

class CatArchiveDetailItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
