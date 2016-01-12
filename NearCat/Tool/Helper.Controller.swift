//
//  Helper.Controller.swift
//  NearCat
//
//  Created by huchunbo on 16/1/12.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit

extension Helper {
    
    public class Controller {
        
        public class func getByStoryboardIdentifier(identifier: String) -> UIViewController {
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(identifier)
        }
        
    }
    
}