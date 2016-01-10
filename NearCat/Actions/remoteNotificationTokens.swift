//
//  remoteNotificationTokens.swift
//  NearCat
//
//  Created by huchunbo on 16/1/11.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Action {
    public class remoteNotificationTokens {
        
        // create token
        
        public class func create(token token: String, userId: Int? = nil, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let parameters = [
                "remote_notification_token": [
                    "token": token,
                    "user_id": userId == nil ? "" : "\(userId!)"
                ]
            ]
            FNetManager.sharedInstance.POST(path: "remote_notification_tokens.json", parameters: parameters) { (request, response, json, error) -> Void in
                print(error)
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
    }
}