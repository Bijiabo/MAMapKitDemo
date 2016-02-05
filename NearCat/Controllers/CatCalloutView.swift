//
//  CatCalloutView.swift
//  NearCat
//
//  Created by huchunbo on 16/1/1.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit

class CatCalloutView: UIView {
    
    var image: UIImage = UIImage() {
        didSet {
            portraitView.image = image
        }
    }
    var title: String = String() {
        didSet {
            titleLabel.text = title
        }
    }
    var subtitle: String = String() {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    var portraitView: UIImageView = UIImageView()
    var subtitleLabel: UILabel!
    var titleLabel: UILabel!
    
    let kArrorHeight: CGFloat = 14.0
    let kArrorWidth: CGFloat = 32.0
        
    override func drawRect(rect: CGRect) {
        drawInContext(UIGraphicsGetCurrentContext()!)
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2.0
    }
 
    func drawInContext(context: CGContextRef) {
        CGContextSetLineWidth(context, 2.0)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        
        getDrawPath(context)
        CGContextFillPath(context)
    }
    
    func getDrawPath(context: CGContextRef) {
        let rrect: CGRect = bounds
        let minx: CGFloat = CGRectGetMinX(rrect)
        let midx: CGFloat = CGRectGetMidX(rrect)
        let maxx = CGRectGetMaxX(rrect)
        let miny = CGRectGetMinY(rrect)
        let maxy = CGRectGetMaxY(rrect) - kArrorHeight - 6.0
        let radius: CGFloat = maxy/2.0
        
        CGContextMoveToPoint(context, midx + kArrorWidth/2.0 + 20.0, maxy)
        CGContextAddArcToPoint(context, midx + kArrorWidth/2.0, maxy, midx, maxy + kArrorHeight, 5.0)
//        CGContextMoveToPoint(context, midx + kArrorHeight, maxy)
        CGContextAddArcToPoint(context, midx, maxy + kArrorHeight, midx - kArrorWidth/2.0, maxy, 5.0)
//        CGContextAddLineToPoint(context, midx, maxy + kArrorHeight)
        CGContextAddArcToPoint(context, midx - kArrorWidth/2.0, maxy, midx - kArrorWidth/2.0 - 20.0, maxy, 5.0)
//        CGContextAddLineToPoint(context, midx - kArrorHeight, maxy)
        
        CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius)
        CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius)
        CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius)
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius)
        CGContextClosePath(context)
    }
    
    let kPortraitMargin: CGFloat = 5.0
    let kPortraitWidth: CGFloat = 40.0
    let kPortraitHeight: CGFloat = 40.0
    
    let kTitleWidth: CGFloat = 150.0
    let kTitleHeight: CGFloat = 20.0
    let kSubTitleHeight: CGFloat = 17.0
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        initSubViews()
        
        userInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapCalloutView:")))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapCalloutView(sender: UITapGestureRecognizer) {
        Helper.Controller.pushViewController(Helper.Controller.CatDetail)
    }
    
    func initSubViews() {
        // 添加图片
        portraitView = UIImageView(frame: CGRect(x: kPortraitMargin, y: kPortraitMargin, width: kPortraitWidth, height: kPortraitHeight))
        portraitView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
        portraitView.layer.cornerRadius = kPortraitHeight/2.0
        portraitView.clipsToBounds = true
        addSubview(portraitView)
        
        // 添加标题
        titleLabel = UILabel(frame: CGRect(x: kPortraitMargin + kPortraitWidth + 12.0, y: kPortraitMargin, width: kTitleWidth, height: kTitleHeight))
        Helper.UI.setLabel(titleLabel, forStyle: Constant.TextStyle.Cell.Title.Blue)
        titleLabel.text = "Title"
        addSubview(titleLabel)
        
        // 添加副标题
        subtitleLabel = UILabel(frame: CGRect(x: kPortraitMargin + kPortraitWidth + 12.0, y: kPortraitMargin + kTitleHeight + 4.0 , width: kTitleWidth, height: kSubTitleHeight))
        Helper.UI.setLabel(subtitleLabel, forStyle: Constant.TextStyle.Cell.Small.G4)
        subtitleLabel.text = "Subtitle"
        addSubview(subtitleLabel)
        
        // 添加向右箭头
        let nextImageView = UIImageView(frame: CGRect(x: bounds.width - 54.0, y: 2.0, width: 48.0, height: 48.0))
        nextImageView.image = UIImage(named: "icon_next")
        addSubview(nextImageView)
        
        // add test button
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        button.backgroundColor = Constant.Color.Pink
//        button.setTitle("test", forState: UIControlState.Normal)
//        button.addTarget(self, action: Selector("test:"), forControlEvents: UIControlEvents.TouchUpInside)
//        addSubview(button)
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        
        if CGRectContainsPoint(bounds, point) {
            return self
        } else {
            return nil
        }
    }
    
    
    
}