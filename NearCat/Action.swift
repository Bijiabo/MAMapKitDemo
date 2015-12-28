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