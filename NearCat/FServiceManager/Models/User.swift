//
//  User.swift
//  F
//
//  Created by huchunbo on 15/11/7.
//  Copyright © 2015年 TIDELAB. All rights reserved.
//

import Foundation

public class User {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    public let id: Int
    public var name: String {
        didSet {
            userDefaults.setObject(name, forKey: "name")
            userDefaults.synchronize()
        }
    }
    public var email: String {
        didSet {
            userDefaults.setObject(email, forKey: "email")
            userDefaults.synchronize()
        }
    }
    public var valid: Bool
    public var avatar: String {
        didSet {
            userDefaults.setObject(avatar, forKey: "avatar")
            userDefaults.synchronize()
        }
    }
    
    public init (id: Int, name: String, email: String, valid: Bool = true, avatar: String = String()) {
        
        self.id = id
        self.name = name
        self.email = email
        self.valid = valid
        self.avatar = avatar
    }
}