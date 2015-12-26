//
//  Constant.swift
//  NearCat
//
//  Created by huchunbo on 15/12/26.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation

public struct Constant {

    struct Notification {
        struct Alert {
            static let Dictionary: [String: String] = [
                "showLoginTextField": "Alert_ShowLoginTextField",
                "showLoading": "Alert_ShowLoading",
                "hideLoading": "Alert_HideLoading",
                "showError": "Alert_showError"
            ]
            
            static let showLoginTextField = Dictionary["showLoginTextField"]!
            static let showLoading = Dictionary["showLoading"]!
            static let hideLoading = Dictionary["hideLoading"]!
            static let showError = Dictionary["showError"]!
        }
    }
    
}
