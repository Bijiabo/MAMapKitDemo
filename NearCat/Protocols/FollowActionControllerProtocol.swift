//
//  FollowActionControllerProtocol.swift
//  NearCat
//
//  Created by huchunbo on 16/1/19.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation

@objc protocol FollowActionControllerProtocol {
    optional func follow(userId userId: Int)
    optional func unfollow(userId userId: Int)
}
