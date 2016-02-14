//
//  Helper.Alert.swift
//  NearCat
//
//  Created by huchunbo on 16/1/30.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation

extension Helper {
    public class Alert {
        
        public class func show(title title: String, message: String = "", animated: Bool = true) {
//            let message: [String: AnyObject] = [
//                "title": title,
//                "message": message,
//                "animated": animated
//            ]
            let alertView = KKAlertView(title: title, message: message, buttonTitle: "好", isNormal: true) { () -> Void in
                
            }
            alertView.show()
//            NSNotificationCenter.defaultCenter().postNotificationName(Constant.Notification.Alert.showError, object: message)
        }
        
    }
}