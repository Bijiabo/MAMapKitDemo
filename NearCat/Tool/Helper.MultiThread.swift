//
//  Helper.MultiThread.swift
//  NearCat
//
//  Created by huchunbo on 16/1/29.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation

extension Helper {
    
    public class MultiThread {
        struct Queue {
            static var Serial: dispatch_queue_t {
                get {
                    return dispatch_queue_create("cat.near.Queue", DISPATCH_QUEUE_SERIAL)
                }
            }
            
            static var Concurent: dispatch_queue_t {
                get {
                    return dispatch_queue_create("cat.near.Queue", DISPATCH_QUEUE_CONCURRENT)
                }
            }       
        }
    }
    
}
