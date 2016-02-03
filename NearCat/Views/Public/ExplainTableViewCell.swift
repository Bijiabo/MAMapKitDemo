//
//  ExplainTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/2.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class ExplainTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .None
        Helper.UI.setLabel(contentLabel, forStyle: Constant.TextStyle.Cell.Small.G4)
        backgroundColor = Constant.Color.TableViewBackground
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var content: String = String() {
        didSet {
            contentLabel.attributedText = Helper.UI.setLineSpacingForAttributedString(NSAttributedString(string: content), lineSpacing: Constant.TextStyle.Cell.Small.G4.font.pointSize*0.2)
        }
    }

}
