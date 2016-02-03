//
//  Helper.Ability.swift
//  NearCat
//
//  Created by huchunbo on 16/1/30.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import Photos

extension Helper {
    
    public class Ability {
        
        public class Photo {
            
            public class var hasAuthorization: Bool {
                get {
                    return PHPhotoLibrary.authorizationStatus() != .NotDetermined && PHPhotoLibrary.authorizationStatus() != .Denied
                }
            }
            
            public class func requestAuthorization(block block: (success: Bool)->Void ) {
                PHPhotoLibrary.requestAuthorization { (status) -> Void in
                    if status != .NotDetermined && status != .Denied {
                        block(success: true)
                    } else {
                        block(success: false)
                    }
                }
            }
            
        }
        
    }
    
}