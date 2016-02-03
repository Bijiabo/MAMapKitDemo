//
//  AvatarImageView.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override func awakeFromNib() {
        super.awakeFromNib()
        
        _setupCorners()
    }
    
    private func _setupCorners() {
        backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1)
        layer.cornerRadius = frame.width / 2.0
        clipsToBounds = true
    }
    
}
