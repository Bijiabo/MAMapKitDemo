//
//  Trends.swift
//  NearCat
//
//  Created by huchunbo on 16/1/10.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Action {
    public class trends {
        // TODO: add get trends list function, has been read function
        
        // get trends list
        public class func list (var page page: Int = 1, completeHandler: (success: Bool, data: JSON, description: String)->Void) {
            if page < 1 { page = 1 }
            let path = "trends.json?page=\(page)&token=\(FHelper.token)"
            
            FNetManager.sharedInstance.GET(path: path) { (request, response, json, error) -> Void in
                Action.requestCompleteHandler(json: json, error: error, completeHandler: { (success, data, description) -> Void in
                    completeHandler(success: success, data: data, description: description)
                })
            }
        }
    }
}