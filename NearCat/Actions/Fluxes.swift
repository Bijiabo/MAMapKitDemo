//
//  Fluxes.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Action {
    public class fluxes {
        // create
        public class func create(motion motion: String, content: String, image: NSData?, completeHandler: (success: Bool, description: String)->Void) {
            Helper.Notification.show(text: "努力提交中...")
            FNetManager.sharedInstance.UPLOAD(path: "fluxes.json?token=\(FHelper.token)",
                multipartFormData: { (multipartFormData) -> Void in
                    if let imageData = image {
                        multipartFormData.appendBodyPart(data: imageData, name: "flux[picture]", fileName: "\(NSDate().timeIntervalSince1970).jpg", mimeType: "image/jpeg")
                    }else{
                        multipartFormData.appendBodyPart(data: "".dataUsingEncoding(NSUTF8StringEncoding)!, name: "flux[picture]")
                    }
                    //multipartFormData.appendBodyPart(fileURL: uploadImageURL, name: "flux[picture]")
                    multipartFormData.appendBodyPart(data: motion.dataUsingEncoding(NSUTF8StringEncoding)!, name: "flux[motion]")
                    multipartFormData.appendBodyPart(data: content.dataUsingEncoding(NSUTF8StringEncoding)!, name: "flux[content]")
                },
                completionHandler: { (request, response, json, error) -> Void in
                    Helper.Notification.hide(text: "发布成功！")
                    completeHandler(success: json["success"].boolValue, description: json["description"].stringValue)
                },
                failedHandler: {(success: Bool, description: String) in
                    Helper.Notification.hide(text: "发布失败... \(description)")
                    completeHandler(success: success, description: description)
                }
            )
        }
        
        // get list
        public class func list(var page page: Int = 0, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            if page < 0 { page=0 }
            FNetManager.sharedInstance.GET(path: "fluxes.json?page=\(page)&token=\(FHelper.token)") { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
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
        
        // get comments
        public class func comments(id id: String, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            FNetManager.sharedInstance.GET(path: "fluxes/\(id)/comments.json") { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        // get flux detail
        
        public class func detail(id id: String, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            FNetManager.sharedInstance.GET(path: "fluxes/\(id).json?token=\(FHelper.token)") { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        // create a flux comment
        
        public class func createComment(content content: String, fluxId: Int, parentCommentId: Int? = nil, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            Helper.Notification.show(text: "努力提交中...")
            
            let params: [String: AnyObject] = [
                "flux_comment": [
                    "content": content,
                    "flux_id": fluxId,
                    "parentComment_id": parentCommentId == nil ? 0 : parentCommentId!
                ],
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.POST(path: "flux_comments.json", parameters: params) { (request, response, json, error) -> Void in
                
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    
                    if success {
                        Helper.Notification.hide(text: "评论成功！")
                    } else {
                        Helper.Notification.hide(text: "评论失败...")
                    }
                    
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
        
        // like and cancel like
        
        public class func like(fluxId id: Int, completeHandler: ((success: Bool, description: String)->Void)?=nil) {
            let path: String = "flux_likes.json"
            let parameters: [String: AnyObject] = [
                "flux_like": [
                    "flux_id": id
                ],
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.POST(path: path, parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, description) -> Void in
                    completeHandler?(success: success, description: description)
                })
            }
        }
        
        public class func cancelLike(fluxId id: Int, completeHandler: ((success: Bool, description: String)->Void)?=nil) {
            let path: String = "flux_likes/cancel_like.json"
            let parameters: [String: AnyObject] = [
                "flux_like": [
                    "flux_id": id
                ],
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.DELETE(path: path, parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, description) -> Void in
                    completeHandler?(success: success, description: description)
                })
            }
        }

    }
}