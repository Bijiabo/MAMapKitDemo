//
//  User.swift
//  F
//
//  Created by huchunbo on 15/11/7.
//  Copyright © 2015年 TIDELAB. All rights reserved.
//

import Foundation

public class User {
    public let id: Int
    public var name: String
    public var email: String
    public var valid: Bool
    public var avatar: String
    
    public init (id: Int, name: String, email: String, valid: Bool = true, avatar: String = String()) {
        
        self.id = id
        self.name = name
        self.email = email
        self.valid = valid
        self.avatar = avatar
    }
}