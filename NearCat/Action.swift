//
//  Action.swift
//  NearCat
//
//  Created by huchunbo on 15/12/28.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation
import SwiftyJSON
import FServiceManager

public class Action {
    public class cats {
        // destroy
        public class func destroy(id id: String, completeHandler: (success: Bool, description: String)->Void = {(success: Bool, description: String) in }) {
            // TODO: pick up public func
            FNetManager.sharedInstance.DELETE(path: "cats/\(id).json", parameters: ["token": FHelper.token]) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        // create
        public class func create (name: String, age: Int, breed: String, completeHandler: (success: Bool, description: String)->Void ) {
            let parameters: [String: AnyObject] = [
                "cat": [
                    "name": name,
                    "age": age,
                    "breed": breed,
                    "user_id": FHelper.current_user.id
                ],
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.POST(path: "cats.json", parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        // update
        public class func update (id id: Int, catData: [String: AnyObject], completeHandler: (success: Bool, description: String)->Void) {
            
            let parameters: [String: AnyObject] = [
                "cat": catData,
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.POST(path: "cats.json", parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
    }
    
    // MARK: - tool functions
    // TODO: - pick up to FAction for FServiceManager
    private class func requestCompleteHandler( json json: JSON, error: ErrorType?,  completeHandler: (success: Bool, description: String)->Void ) {
        var success: Bool = false
        var description: String = error.debugDescription
        
        if error == nil {
            success = !json["error"].boolValue
            if !success {
                description = json["description"].stringValue
            }
        }
        
        completeHandler(success: success, description: description)
    }
}