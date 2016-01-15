//
//  PrivateMessages.swift
//  NearCat
//
//  Created by huchunbo on 16/1/15.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Action {
    public class privateMessages {
        
        public class func list(completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "private_messages.json?token=\(FHelper.token)"
            
            FNetManager.sharedInstance.GET(path: path) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
        
        public class func withUser(userId userId: Int, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "/private_messages/with_user/\(userId).json?token=\(FHelper.token)"
            
            FNetManager.sharedInstance.GET(path: path) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }

    }
}