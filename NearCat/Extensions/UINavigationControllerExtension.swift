//
//  UINavigationControllerExtension.swift
//  NearCat
//
//  Created by huchunbo on 16/1/30.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation

extension UINavigationController {
    
    func extension_hideBackButtonTitle() {
        navigationBar.topItem?.title = ""
        navigationBar.backItem?.title = ""
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.leftBarButtonItem?.title = ""
    }
    
    func extension_backgroundTransparent(backgroundTransparent: Bool) {
        if backgroundTransparent {
            navigationBar.barTintColor = UIColor.clearColor()
            navigationBar.backgroundColor = UIColor.clearColor()
            navigationBar.setBackgroundImage(UIImage(named: "transparent"), forBarMetrics: UIBarMetrics.Default)
            navigationBar.hideBottomHairline()
            navigationBar.tintColor = UIColor.whiteColor()
        } else {
            navigationBar.barTintColor = nil
            navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
            navigationBar.showBottomHairline()
            navigationBar.tintColor = Constant.Color.Theme
        }
    }
    
}