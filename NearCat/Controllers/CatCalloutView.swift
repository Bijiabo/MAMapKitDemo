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
    
    var portraitView: UIImageView!
    var subtitleLabel: UILabel!
    var titleLabel: UILabel!
    
    let kArrorHeight: CGFloat = 10.0
        
    override func drawRect(rect: CGRect) {
        drawInContext(UIGraphicsGetCurrentContext()!)
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
    }
 
    
    func drawInContext(context: CGContextRef) {
        CGContextSetLineWidth(context, 2.0)
        CGContextSetFillColorWithColor(context, UIColor(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 0.8).CGColor)
        
        getDrawPath(context)
        CGContextFillPath(context)
    }
    
    func getDrawPath(context: CGContextRef) {
        let rrect: CGRect = bounds
        let radius: CGFloat = 6.0
        let minx: CGFloat = CGRectGetMinX(rrect)
        let midx: CGFloat = CGRectGetMidX(rrect)
        let maxx = CGRectGetMaxX(rrect)
        let miny = CGRectGetMinY(rrect)
        let maxy = CGRectGetMaxY(rrect) - kArrorHeight
        
        CGContextMoveToPoint(context, midx + kArrorHeight, maxy)
        CGContextAddLineToPoint(context, midx, maxy + kArrorHeight)
        CGContextAddLineToPoint(context, midx - kArrorHeight, maxy)
        
        CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius)
        CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius)
        CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius)
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius)
        CGContextClosePath(context)
    }
    
    let kPortraitMargin: CGFloat = 5.0
    let kPortraitWidth: CGFloat = 70
    let kPortraitHeight: CGFloat = 50
    
    let kTitleWidth: CGFloat = 120
    let kTitleHeight: CGFloat = 20
    
    
        
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        initSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews() {
        // 添加图片
        portraitView = UIImageView(frame: CGRect(x: kPortraitMargin, y: kPortraitMargin, width: kPortraitWidth, height: kPortraitHeight))
        portraitView.backgroundColor = UIColor.blackColor()
        addSubview(portraitView)
        
        // 添加标题
        titleLabel = UILabel(frame: CGRect(x: kPortraitMargin * 2 + kPortraitWidth, y: kPortraitMargin, width: kTitleWidth, height: kTitleHeight))
        titleLabel.font = UIFont.boldSystemFontOfSize(14)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "title"
        addSubview(titleLabel)
        
        // 添加副标题
        subtitleLabel = UILabel(frame: CGRect(x: kPortraitMargin * 2 + kPortraitWidth, y: kPortraitMargin * 2 + kTitleHeight, width: kTitleWidth, height: kTitleHeight))
        subtitleLabel.font = UIFont.systemFontOfSize(12)
        subtitleLabel.textColor = UIColor.lightGrayColor()
        subtitleLabel.text = "subtitle"
        addSubview(subtitleLabel)
    }
        
        
    
}