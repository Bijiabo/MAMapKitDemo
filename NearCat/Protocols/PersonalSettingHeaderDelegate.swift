//
//  PersonalSettingHeaderDelegate.swift
//  NearCat
//
//  Created by huchunbo on 16/1/23.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation

@objc protocol PersonalSettingHeaderDelegate {
    optional func tapAvatar()
    optional func longPressBackgroundImage()
}