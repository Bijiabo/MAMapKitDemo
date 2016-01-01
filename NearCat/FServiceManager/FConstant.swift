//
//  FConstant.swift
//  F
//
//  Created by huchunbo on 15/11/10.
//  Copyright © 2015年 TIDELAB. All rights reserved.
//

import Foundation

public struct FConstant {
    public struct Notification {
        // FStatus
        public struct FStatus {
            public static let addObserver = "FStatus_AddObserver"
            public static let removeObserver = "FStatus_RemoveObserver"

            public static let didLogin = "FStatus_DidLogin"
            public static let didLogout = "FStatus_DidLogout"
        }
    }
    
    public struct UserDefaults {
        //FStatus
        public struct FStatus {
            public static let logged_in = "logged_in"
        }
    }
    
    public struct String {
        public struct FStatus {
            public static let loginStatus = "_loginStatus"
        }
    }
}