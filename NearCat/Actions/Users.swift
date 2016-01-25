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
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        public class func updateAvatar(image image: UIImage, completeHandler: (success: Bool, description: String)->Void) {
            let path = "users/update_information.json?token=UI1SkkGomiDeXq-jYoikOA" //\(FHelper.token)"
            
            guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
                completeHandler(success: false, description: "image data error.")
                return
            }
            
            FNetManager.sharedInstance.UPLOAD(path: path,
                multipartFormData: { (multipartFormData) -> Void in
                    multipartFormData.appendBodyPart(data: imageData, name: "user[avatar]", fileName: "xxx.jpg", mimeType: "image/jpeg")
                },
                completionHandler: { (request, response, json, error) -> Void in
                    completeHandler(success: json["success"].boolValue, description: json["description"].stringValue)
                },
                failedHandler: {(success: Bool, description: String) in
                    completeHandler(success: success, description: description)
                }
            )
        }
    }
}