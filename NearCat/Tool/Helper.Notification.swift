//
//  Helper.Notification.swift
//  NearCat
//
//  Created by huchunbo on 16/1/26.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit

extension Helper {
    
    public class Notification {
        class func setupCustomStyle() {
            JDStatusBarNotification.addStyleNamed("NC") { (style: JDStatusBarStyle!) -> JDStatusBarStyle! in
                // main properties
                style.barColor = UIColor(red:1, green:1, blue:1, alpha:1)
                style.textColor = Constant.Color.Theme
                style.font = UIFont.systemFontOfSize(10.0)
                
                // advanced properties
                style.animationType = JDStatusBarAnimationType.Move
                let textShadow = NSShadow()
                style.textShadow = textShadow
                style.textVerticalPositionAdjustment = 0
                
                // progress bar
                style.progressBarColor = Constant.Color.Theme
                style.progressBarHeight = 1.0
                style.progressBarPosition = JDStatusBarProgressBarPosition.Bottom
                
                return style;
            }
        }
        
        class func show(text text: String = "获取数据中...喵", loading: Bool = true) {
            JDStatusBarNotification.showWithStatus(text, styleName: "NC")
            JDStatusBarNotification.showProgress(0.2)
            self.loading(loading)
        }
        
        class func loading(loading: Bool) {
            JDStatusBarNotification.showActivityIndicator(loading, indicatorStyle: UIActivityIndicatorViewStyle.Gray)
        }
        
        class func hide(text text: String = "") {
            
            if !text.isEmpty {
                show(text: text, loading: false)
            }
            
            JDStatusBarNotification.showProgress(1.0)
            JDStatusBarNotification.dismissAfter(0.5)
        }
        
    }
    
}
