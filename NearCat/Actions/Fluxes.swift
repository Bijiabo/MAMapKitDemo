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
        public class func list(var page page: Int = 0, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            if page < 0 { page=0 }
            FNetManager.sharedInstance.GET(path: "fluxes.json?page=\(page)") { (request, response, json, error) -> Void in
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
    }
}