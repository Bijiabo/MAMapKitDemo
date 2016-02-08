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
            
            calloutView?.userInteractionEnabled = true
            calloutView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapCallout:")))

            addSubview(calloutView!)
            bringSubviewToFront(calloutView!)
            
            calloutView?.animate()
            
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
    
    func tapCallout(sender: UITapGestureRecognizer) {
        NSLog("tapCallout")
        if let data = data {
            let vc = Helper.Controller.CatDetail
            vc.catId = data["id"].intValue
            Helper.Controller.pushViewController(vc)
        }
        
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let calloutRect: CGRect = CGRect(x: bounds.origin.x - (kCalloutWidth - bounds.size.width)/2.0 , y: bounds.origin.y - kCalloutHeight, width: kCalloutWidth, height: kCalloutHeight)
        
        if CGRectContainsPoint(bounds, point) {
            return self
        } else if CGRectContainsPoint(calloutRect, point) && selected {
            return calloutView
        } else {
            return nil
        }
    }
}