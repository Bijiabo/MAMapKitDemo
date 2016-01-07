//
//  FConfiguration.swift
//  FServiceManager
//
//  Created by huchunbo on 15/12/22.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation

private let _FConfigurationSharedInstance = FConfiguration()

public class FConfiguration {
    
    public class var sharedInstance : FConfiguration {
        return _FConfigurationSharedInstance
    }
    
    public var host = "http://192.168.31.200:3000/"
    public var Secret_key = "Change"
}