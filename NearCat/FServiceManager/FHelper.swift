//
//  FHelper.swift
//  F
//
//  Created by huchunbo on 15/11/7.
//  Copyright © 2015年 TIDELAB. All rights reserved.
//

import Foundation

public struct FHelper {
    
    // MARK: - token
    
    public static var token: String {
        return FTool.keychain.token()
    }
    
    public static var tokenID: String {
        return FTool.keychain.tokenID()
    }
    
    public static func setToken (id id: String, token: String) {
        FTool.keychain.defaultKeychain()["token"] = token
        FTool.keychain.defaultKeychain()["tokenID"] = id
    }
    
    public static func clearToken () {
        FTool.keychain.defaultKeychain()["token"] = nil
        FTool.keychain.defaultKeychain()["tokenID"] = nil
    }
    
    // MARK: - device token
    public static var deviceToken: String {
        set (newValue) {
            FTool.keychain.defaultKeychain()["deviceToken"] = newValue
        }
        
        get {
            if let device_token = FTool.keychain.defaultKeychain()["deviceToken"] {
                return device_token
            }
            return String()
        }
    }
    
    // MARK: - user information
    public static var current_user: User {
        set (newValue) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(newValue.name, forKey: "name")
        userDefaults.setObject(newValue.email, forKey: "email")
        userDefaults.setObject(newValue.avatar, forKey: "avatar")
        userDefaults.setInteger(newValue.id, forKey: "id")
        userDefaults.synchronize()
        }
        
        get {
            let valid: Bool = true
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let invalidUser = User(id: 0, name: String(), email: String(), valid: false)
            guard let name = userDefaults.stringForKey("name") else {return invalidUser}
            guard let email = userDefaults.stringForKey("email") else {return invalidUser}
            let id = userDefaults.integerForKey("id")
            
            var avatar: String = String()
            if let savedAvatar = userDefaults.stringForKey("avatar") {
                avatar = savedAvatar
            }
            
            return User(id: id, name: name, email: email, valid: valid, avatar: avatar)
        }
    }
    
    // MARK:
    // MARK: - user functions
    
    public static var logged_in: Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(FConstant.UserDefaults.FStatus.logged_in)
    }
    
    public static func current_user (user_id: Int) -> Bool {
        return current_user.id == user_id && current_user.valid && logged_in
    }
}
