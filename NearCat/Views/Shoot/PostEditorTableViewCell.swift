//
//  PostEditorTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/20.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PostEditorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var content: String {
        get {
            return contentTextView.text
        }
    }
    
    var contentCount: Int {
        get {
            return contentTextView.text.characters.count
        }
    }

}
