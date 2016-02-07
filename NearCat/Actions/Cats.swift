//
//  Cats.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Action {
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
        public class func update (id id: Int, catData: [String: AnyObject], completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let parameters: [String: AnyObject] = [
                "cat": catData,
                "token": FHelper.token
            ]
            
            FNetManager.sharedInstance.PATCH(path: "cats/\(id).json", parameters: parameters) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
            }
        }
        
        // modify avatar
        
        public class func updateAvatar(id id: Int, image: UIImage, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "cats/\(id).json?token=\(FHelper.token)"
            
            guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
                completeHandler(success: false, data: JSON([]), description: "image data error.")
                return
            }
            
            FNetManager.sharedInstance.UPLOAD(path: path,
                multipartFormData: { (multipartFormData) -> Void in
                    multipartFormData.appendBodyPart(data: imageData, name: "cat[avatar]", fileName: "\(NSDate().timeIntervalSince1970).jpg", mimeType: "image/jpeg")
                },
                completionHandler: { (request, response, json, error) -> Void in
                    
                    Action.requestCompleteHandler(json: json, error: error, completeHandler: completeHandler)
                },
                failedHandler: {(success: Bool, description: String) in
                    completeHandler(success: success, data: JSON([]), description: description)
                }
            )
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
        
        public class func byUserId (userId: Int, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "users/\(userId)/cats.json"
            
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
        public class func nearby(latitude: Double, longitude: Double, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            let path = "nearbyCat.json?latitude=\(latitude)&longitude=\(longitude)"
            
            FNetManager.sharedInstance.GET(path: path) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
    }
}
