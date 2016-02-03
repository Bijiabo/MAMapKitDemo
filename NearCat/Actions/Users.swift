//
//  User.swift
//  NearCat
//
//  Created by huchunbo on 16/1/15.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Action {
    public class users {
        public class func informationFor(userId userId: Int, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "users/\(userId).json?token=\(FHelper.token)"
            
            FNetManager.sharedInstance.GET(path: path) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json["user"], error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
        
        public class func selfInformation(completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "users/self_information.json?token=\(FHelper.token)"
            
            FNetManager.sharedInstance.GET(path: path) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    
                    if success {
                        FHelper.current_user.name = data["name"].stringValue
                        FHelper.current_user.email = data["email"].stringValue
                        FHelper.current_user.avatar = data["avatar"].stringValue
                    }
                    
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
        
        public class func updateSelfInformation(data data: [String: AnyObject], completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "users/update_information.json"
            let parameters: [String: AnyObject] = [
                "user": data,
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.POST(path: path, parameters: parameters) { (request, response, json, error) -> Void in
                
                if json["success"].boolValue {
                    FHelper.current_user.name = json["name"].stringValue
                    FHelper.current_user.email = json["email"].stringValue
                    FHelper.current_user.avatar = json["avatar"].stringValue
                }
                
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        public class func updateAvatar(image image: UIImage, completeHandler: (success: Bool, description: String)->Void) {
            let path = "users/update_information.json?token=\(FHelper.token)"
            
            guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
                completeHandler(success: false, description: "image data error.")
                return
            }
            
            FNetManager.sharedInstance.UPLOAD(path: path,
                multipartFormData: { (multipartFormData) -> Void in
                    multipartFormData.appendBodyPart(data: imageData, name: "user[avatar]", fileName: "\(NSDate().timeIntervalSince1970).jpg", mimeType: "image/jpeg")
                },
                completionHandler: { (request, response, json, error) -> Void in
                    
                    if json["success"].boolValue {
                        FHelper.current_user.avatar = json["avatar"].stringValue
                    }
                    
                    completeHandler(success: json["success"].boolValue, description: json["description"].stringValue)
                },
                failedHandler: {(success: Bool, description: String) in
                    completeHandler(success: success, description: description)
                }
            )
        }
    }
}