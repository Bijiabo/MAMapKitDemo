//
//  CatAnnotationView.swift
//  NearCat
//
//  Created by huchunbo on 16/1/1.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import SwiftyJSON

class CatAnnotationView: MAAnnotationView {
    var calloutView: CatCalloutView?
    var calloutImage: UIImage?
    
    let kCalloutWidth: CGFloat = 240.0
    let kCalloutHeight: CGFloat = 70.0
        
    override func setSelected(selected: Bool, animated: Bool) {
        if self.selected == selected { return }
        
        if selected {
            if calloutView == nil {
                calloutView = CatCalloutView(frame: CGRect(x: 0, y: 0, width: kCalloutWidth, height: kCalloutHeight))
                calloutView?.center = CGPoint(x: CGRectGetWidth(bounds)/2.0 + calloutOffset.x, y: -CGRectGetHeight(self.calloutView!.bounds) / 2.0 + self.calloutOffset.y)
            }
            
            if let calloutImage = calloutImage {
                calloutView?.image = calloutImage
            }
            calloutView?.title = annotation.title!()
            
            if let data = self.data {
                calloutView?.subtitle = data["breed"].stringValue
                if
                    let avatarPath = data["avatar"].string,
                    let calloutView = calloutView
                {
                    Helper.setRemoteImageForImageView(calloutView.portraitView, imagePath: avatarPath)
                }
            }

            addSubview(calloutView!)
            bringSubviewToFront(calloutView!)
            
        } else {
            calloutView?.removeFromSuperview()
        }
        
        super.setSelected(selected, animated: animated)
    }
    
    var data: JSON? {
        get {
            if let dataFromString = annotation.subtitle!().dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let data = JSON(data: dataFromString)
                return data
            }
            return nil
        }
    }
}