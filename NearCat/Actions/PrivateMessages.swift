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
        
        // get user's own message group list
        
        public class func list(completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "private_messages.json?token=\(FHelper.token)"
            
            FNetManager.sharedInstance.GET(path: path) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
        
        // get list for messages with other user
        
        public class func withUser(userId userId: Int, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "private_messages/with_user/\(userId).json?token=\(FHelper.token)"
            
            FNetManager.sharedInstance.GET(path: path) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
        
        // send message to other user

        public class func send(toUser toUser: Int, content: String, image: NSData?, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            FNetManager.sharedInstance.UPLOAD(path: "private_messages.json",
                multipartFormData: { (multipartFormData) -> Void in
                    let containerName: String = "private_message"
                    if let imageData = image {
                        multipartFormData.appendBodyPart(data: imageData, name: "\(containerName)[picture]", fileName: "\(NSDate().timeIntervalSince1970).jpg", mimeType: "image/jpeg")
                    }else{
                        multipartFormData.appendBodyPart(data: "".dataUsingEncoding(NSUTF8StringEncoding)!, name: "\(containerName)[picture]")
                    }
                    
                    multipartFormData.appendBodyPart(data: String(toUser).dataUsingEncoding(NSUTF8StringEncoding)!, name: "\(containerName)[to_user_id]")
                    multipartFormData.appendBodyPart(data: content.dataUsingEncoding(NSUTF8StringEncoding)!, name: "\(containerName)[content]")
                    multipartFormData.appendBodyPart(data: FHelper.token.dataUsingEncoding(NSUTF8StringEncoding)!, name: "token")
                },
                completionHandler: { (request, response, json, error) -> Void in
                    completeHandler(success: json["success"].boolValue, data: json, description: json["description"].stringValue)
                },
                failedHandler: {(success: Bool, description: String) in
                    completeHandler(success: success, data: JSON([]), description: description)
                }
            )
        }
    }
}