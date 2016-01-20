//
//  SearchLocationResultTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/20.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SearchLocationResultTableViewCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        extension_setDefaultSelectedColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var locationName: String = String() {
        didSet {
            locationNameLabel.text = locationName
        }
    }
    
    var locationInfo: String = String() {
        didSet {
            locationInfoLabel.text = locationInfo
        }
    }

}
