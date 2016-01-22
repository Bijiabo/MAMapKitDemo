//
//  Constant.swift
//  NearCat
//
//  Created by huchunbo on 15/12/26.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit

public struct Constant {

    struct Notification {
        struct Alert {
            static let Dictionary: [String: String] = [
                "showLoginTextField": "Alert_ShowLoginTextField",
                "showRegisterTextField": "Alert_ShowRegisterTextField",
                "showLoading": "Alert_ShowLoading",
                "hideLoading": "Alert_HideLoading",
                "showError": "Alert_showError"
            ]
            
            static let showLoginTextField = Dictionary["showLoginTextField"]!
            static let showRegisterTextField = Dictionary["showRegisterTextField"]!
            static let showLoading = Dictionary["showLoading"]!
            static let hideLoading = Dictionary["hideLoading"]!
            static let showError = Dictionary["showError"]!
        }
        
        struct Location {
            static let didUpdate = "Location_didUpdate"
        }
    }
    
    struct Color {
        static let Theme: UIColor = UIColor(red:0.36, green:0.5, blue:0.66, alpha:1)
        static let CellSelected: UIColor = UIColor(red:0.36, green:0.5, blue:0.66, alpha:0.1)
        static let Pink: UIColor = UIColor(red:1, green:0.35, blue:0.43, alpha:1)
    }
    
}
