//
//  Follow.swift
//  NearCat
//
//  Created by huchunbo on 16/1/13.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Action {
    public class follow {
        
        // get following list data
        
        public class func following(userId userId: Int, var page: Int = 1, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            if page < 1 { page = 1 }
            let path = "users/\(userId)/following.json?page=\(page)&token=\(FHelper.token)"
            
            FNetManager.sharedInstance.GET(path: path) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
        
        // do following
        
        public class func follow(userId userId: Int, completeHandler: (success: Bool, description: String)->Void = {(success, description) in }) {
            let path = "relationships.json"
            let parameters: [String: AnyObject] = [
                "id": userId,
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.POST(path: path, parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, description: description)
                })
            }
        }
        
        // cancel follow
        
        public class func unfollow(userId userId: Int, completeHandler: (success: Bool, description: String)->Void = {(success, description) in }) {
            let path = "relationships/unfollow.json"
            let parameters: [String: AnyObject] = [
                "id": userId,
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.DELETE(path: path, parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, description: description)
                })
            }
        }

    }
}