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
        
        // UILabel
        
        class func setLabel(label: UILabel, forStyle style: Constant.TextStyle.type) {
            label.font = style.font
            label.textColor = style.color
        }
        
        class func setLabelLineSpacing(label label: UILabel, lineSpacing: CGFloat) {
            if let attributedString = label.attributedText {
                label.attributedText = Helper.UI.setLineSpacingForAttributedString(attributedString, lineSpacing: lineSpacing)
            } else if let text = label.text {
                label.attributedText = Helper.UI.setLineSpacingForAttributedString(NSAttributedString(string: text), lineSpacing: lineSpacing)
            }
        }
        
        // AttributedString
        
        class func setLineSpacingForAttributedString(attributedString: NSAttributedString, lineSpacing: CGFloat) -> NSMutableAttributedString {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            
            let _mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            _mutableAttributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, _mutableAttributedString.length))
            
            return _mutableAttributedString
        }

    }
    
}
