//
//  Action.swift
//  NearCat
//
//  Created by huchunbo on 15/12/28.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation
import SwiftyJSON
//import FServiceManager

public class Action {
    
    // MARK: - tool functions
    // TODO: - pick up to FAction for FServiceManager
    public class func requestCompleteHandler( json json: JSON, error: ErrorType?,  completeHandler: (success: Bool, description: String)->Void ) {
        _requestComplete(json: json, error: error) { (success, data, description) -> Void in
            completeHandler(success: success, description: description)
        }
    }
    
    public class func requestCompleteHandler( json json: JSON, error: ErrorType?,  completeHandler: (success: Bool, data: JSON, description: String)->Void ) {
        _requestComplete(json: json, error: error) { (success, data, description) -> Void in
            completeHandler(success: success, data: data, description: description)
        }
    }
    
    public class func _requestComplete(json json: JSON, error: ErrorType?,  completeHandler: (success: Bool, data: JSON, description: String)->Void) {
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

