//
//  FAction.swift
//  F
//
//  Created by huchunbo on 15/11/4.
//  Copyright © 2015年 TIDELAB. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

public class FAction: NSObject {
    subscript(request: String) -> AnyObject? {
        if let value = self.valueForKey(request) {
            return value
        }
        
        return nil
    }
    
    // MARK:
    // MARK: actions
    public class func checkLogin (completeHandler: (success: Bool, description: String)->Void ) {
        FNetManager.sharedInstance.GET(path: "check_token.json?token=\(FHelper.token)") { (request, response, json, error) -> Void in
            var success: Bool = false
            var description: String = error.debugDescription
            if error == nil {
                success = json["success"].boolValue
                description = json["description"].stringValue
                
                FHelper.current_user = User(id: json["user"]["id"].intValue , name: json["user"]["name"].stringValue, email: json["user"]["email"].stringValue, valid: true, avatar: json["avatar"].stringValue)
            }
            
            completeHandler(success: success, description: description)
        }
    }
    
    public class func login (email: String, password: String, completeHandler: (success: Bool, description: String)->Void ) {
        
        let parameters = [
            "email": email,
            "password": password,
            "deviceID": FTool.Device.ID(),
            "deviceName": FTool.Device.Name()
        ]
        
        FNetManager.sharedInstance.POST(path: "request_new_token.json", parameters: parameters) { (request, response, json, error) -> Void in
            var success: Bool = false
            var description: String = error.debugDescription
            print(json)
            if error == nil {
                success = !json["error"].boolValue
                if !success {
                    description = json["description"].stringValue
                } else {
                    NSNotificationCenter.defaultCenter().postNotificationName(FConstant.Notification.FStatus.didLogin, object: nil)
                }
                
                //save token
                FHelper.setToken(id: json["token"]["id"].stringValue, token: json["token"]["token"].stringValue)
                FHelper.current_user = User(id: json["token"]["user_id"].intValue , name: json["name"].stringValue, email: json["email"].stringValue, valid: true, avatar: json["avatar"].stringValue)
            }
            
            completeHandler(success: success, description: description)
        }
    }
    
    public class func register (email: String, name: String, password: String, completeHandler: (success: Bool, description: String)->Void ) {
        
        let parameters = [
            "user": [
                "email": email,
                "name": name,
                "password": password,
                "password_confirmation": password
            ]
        ]
        
        //TODO: finish viewController
        FNetManager.sharedInstance.POST(path: "users.json", parameters: parameters) { (request, response, json, error) -> Void in
            var success: Bool = false
            var description: String = String()
            
            if error == nil {
                success = !json["error"].boolValue
                if !success {
                    description = json["description"].stringValue
                }
            } else {
                description = error.debugDescription
            }
            completeHandler(success: success, description: description)
        }
    }
    
    public class func logout () {
        FNetManager.sharedInstance.DELETE(path: "tokens/\(FHelper.tokenID).json?token=\(FHelper.token)") { (request, response, json, error) -> Void in
            if error == nil {
                NSNotificationCenter.defaultCenter().postNotificationName(FConstant.Notification.FStatus.didLogout, object: nil)
                FHelper.clearToken()
            }
        }
    }
    
    // MARK: - Get
    
    public class func GET(path path: String, completeHandler: (request: NSURLRequest, response:  NSHTTPURLResponse?, json: JSON, error: ErrorType?)->Void) {
        FNetManager.sharedInstance.GET(path: "\(path).json?token=\(FHelper.token)") { (request, response, json, error) -> Void in
            completeHandler(request: request, response: response, json: json, error: error)
        }
    }
    
    // MARK: - Fluxes
    public class fluxes {
        // create
        public class func create(motion motion: String, content: String, image: NSData?, completeHandler: (success: Bool, description: String)->Void) {
            FNetManager.sharedInstance.UPLOAD(path: "fluxes.json?token=\(FHelper.token)",
                multipartFormData: { (multipartFormData) -> Void in
                    if let imageData = image {
                        multipartFormData.appendBodyPart(data: imageData, name: "flux[picture]", fileName: "xxx.jpg", mimeType: "image/jpeg")
                    }else{
                        multipartFormData.appendBodyPart(data: "".dataUsingEncoding(NSUTF8StringEncoding)!, name: "flux[picture]")
                    }
                    //multipartFormData.appendBodyPart(fileURL: uploadImageURL, name: "flux[picture]")
                    multipartFormData.appendBodyPart(data: motion.dataUsingEncoding(NSUTF8StringEncoding)!, name: "flux[motion]")
                    multipartFormData.appendBodyPart(data: content.dataUsingEncoding(NSUTF8StringEncoding)!, name: "flux[content]")
                },
                completionHandler: { (request, response, json, error) -> Void in
                    completeHandler(success: json["success"].boolValue, description: json["description"].stringValue)
                },
                failedHandler: {(success: Bool, description: String) in
                    completeHandler(success: success, description: description)
                }
            )
        }
        
        // get list
        public class func list(var page page: Int = 0, completeHandler: (request: NSURLRequest, response:  NSHTTPURLResponse?, json: JSON, error: ErrorType?)->Void) {
            if page < 0 { page=0 }
            FNetManager.sharedInstance.GET(path: "fluxes.json?page=\(page)") { (request, response, json, error) -> Void in
                completeHandler(request: request, response: response, json: json, error: error)
            }
        }
        
        // destroy
        public class func destroy(id id: String, completeHandler: (success: Bool, description: String)->Void = {(success: Bool, description: String) in }) {
            FNetManager.sharedInstance.DELETE(path: "fluxes/\(id).json", parameters: ["token": FHelper.token]) { (request, response, json, error) -> Void in
                var success: Bool = false
                var description: String = String()
                
                if error == nil {
                    success = !json["error"].boolValue
                    description = json["description"].stringValue
                    completeHandler(success: success, description: description)
                } else {
                    description = error.debugDescription
                    completeHandler(success: success, description: description)
                }
            }
        }
    }
    
}