//
//  CatAnnotationView.swift
//  NearCat
//
//  Created by huchunbo on 16/1/1.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation

class CatAnnotationView: MAAnnotationView {
    var calloutView: CatCalloutView?
    var calloutImage: UIImage?
    
    let kCalloutWidth: CGFloat = 200.0
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
            calloutView?.subtitle = annotation.subtitle!()

            addSubview(calloutView!)
            bringSubviewToFront(calloutView!)
            
        } else {
            calloutView?.removeFromSuperview()
        }
        
        super.setSelected(selected, animated: animated)
    }
}