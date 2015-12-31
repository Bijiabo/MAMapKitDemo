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
            
            FNetManager.sharedInstance.PATCH(path: "cats/\(id).json", parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        // get by Id
        public class func getById (id: Int, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            FNetManager.sharedInstance.GET(path: "cats/\(id).json") { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        // get model keys
        public class func getModelKeys (completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            FNetManager.sharedInstance.GET(path: "catsModelKeys") { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
        
        // get users own cats
        public class func mine (completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "users/\(FHelper.current_user.id)/cats.json"

            FNetManager.sharedInstance.GET(path: path) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
        
        // set location for one cat
        public class func setLocation(latitude: Double, longitude: Double, catId: Int, completeHandler: (success: Bool, description: String)->Void) {
            let path = "cats/\(catId)/setLocation.json"
            let parameters: [String: AnyObject] = [
                "cat": [
                    "latitude": latitude,
                    "longitude": longitude
                ],
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.POST(path: path, parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, description: description)
                })
            }
        }
        
        // get nearby cats
        public class func nearby(latitude: Double, longitude: Double, catId: Int, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "nearbyCat"
            let parameters: [String: AnyObject] = [
                "latitude": latitude,
                "longitude": longitude,
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.GET(path: path, parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
    }
    
    // MARK: - tool functions
    // TODO: - pick up to FAction for FServiceManager
    private class func requestCompleteHandler( json json: JSON, error: ErrorType?,  completeHandler: (success: Bool, description: String)->Void ) {
        _requestComplete(json: json, error: error) { (success, data, description) -> Void in
            completeHandler(success: success, description: description)
        }
    }
    
    private class func requestCompleteHandler( json json: JSON, error: ErrorType?,  completeHandler: (success: Bool, data: JSON, description: String)->Void ) {
        _requestComplete(json: json, error: error) { (success, data, description) -> Void in
            completeHandler(success: success, data: data, description: description)
        }
    }
    
    private class func _requestComplete(json json: JSON, error: ErrorType?,  completeHandler: (success: Bool, data: JSON, description: String)->Void) {
        var success: Bool = false
        var description: String = error.debugDescription
        
        if error == nil {
            success = !json["error"].boolValue
            if !success {
                description = json["description"].stringValue
            }
        }
        
        completeHandler(success: success, data: json, description: description)
    }
}