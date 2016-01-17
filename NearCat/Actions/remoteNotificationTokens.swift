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
        
        public class func create(token token: String, completeHandler: ((success: Bool, data: JSON, description: String)->Void) = {(success: Bool, data: JSON, description: String) in} ) {
            let parameters: [String : AnyObject] = [
                "remote_notification_token": [
                    "token": token
                ],
                "token": FHelper.logged_in ? FHelper.token : String()
            ]
            FNetManager.sharedInstance.POST(path: "remote_notification_tokens.json", parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        // remove relationship between user to device token id
    
        public class func removeRelationship(token token: String, completeHandler: ((success: Bool, data: JSON, description: String)->Void) = {(success: Bool, data: JSON, description: String) in} ) {
            let parameters = [
                "remote_notification_token": [
                    "token": token,
                    "user_token": FHelper.logged_in ? FHelper.token : String()
                ]
            ]
            FNetManager.sharedInstance.DELETE(path: "remote_notification_tokens.json", parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        // remove old device token id
        
        public class func destroy(token token: String, completeHandler: ((success: Bool, data: JSON, description: String)->Void) = {(success: Bool, data: JSON, description: String) in} ) {
            let parameters = [
                "remote_notification_token": [
                    "token": token,
                    "user_token": String()
                ]
            ]
            FNetManager.sharedInstance.DELETE(path: "remote_notification_tokens.json", parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
    }
}