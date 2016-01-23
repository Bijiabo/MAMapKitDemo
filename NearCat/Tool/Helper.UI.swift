//
//  Helper.UI.swift
//  NearCat
//
//  Created by huchunbo on 16/1/23.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit

extension Helper {
    
    public class UI {
        class func setLabel(label: UILabel, forStyle style: Constant.TextStyle.type) {
            label.font = style.font
            label.textColor = style.color
        }

    }
    
}
