//
//  CustomSegmentedControl.swift
//  NearCat
//
//  Created by huchunbo on 16/1/5.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//
import UIKit

@IBDesignable class SegmentedControl : UIControl {
    
    private var labels = [UILabel]()
    var thumbView = UIView()
    
    weak var delegate: SegmentedControlDelegate?
    
    let highlightTextColor: UIColor = UIColor(red:0.36, green:0.5, blue:0.66, alpha:1)
    let normalTextColor: UIColor = UIColor(red:0.51, green:0.51, blue:0.51, alpha:1)
    
    var items:[String] = ["Item 1","Item 2","Item 3"] {
        didSet{
            setupLabels()
        }
    }
    
    var previousSelectedIndex: Int = 0
    var selectedIndex : Int = 0 {
        willSet {
            previousSelectedIndex = selectedIndex
        }
        
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setupView()
    }
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        let bgColor: UIColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1)
        
        layer.cornerRadius = frame.height / 2
        layer.borderColor = bgColor.CGColor
        layer.borderWidth = 2
        
        backgroundColor = bgColor
        setupLabels()
        insertSubview(thumbView, atIndex: 0)

        clipsToBounds = true
    }
    
    func setupLabels(){
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll(keepCapacity: true)
        
        for index in 1...items.count {
            let label = UILabel(frame:CGRectZero)
            label.font = UIFont.systemFontOfSize(12.0)
            label.text = items[index - 1]
            label.textAlignment = .Center
            label.textColor = (index-1) == selectedIndex ? highlightTextColor : normalTextColor
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectFrame = self.bounds
        let newWidth = CGRectGetWidth(selectFrame) / CGFloat(items.count)
        selectFrame.size.width = newWidth
        thumbView.frame = selectFrame
        thumbView.backgroundColor = UIColor.whiteColor()
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        thumbView.layer.borderWidth = 2.0
        thumbView.layer.borderColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1).CGColor
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0...labels.count - 1 {
            let label = labels[index]
            
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRectMake(xPosition, 0, labelWidth, labelHeight)
        }
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        var calculatedIndex : Int?
        for (index,item) in labels.enumerate() {
            if item.frame.contains(location){
                calculatedIndex = index
            }
        }
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }
        return false
    }
    
    func displayNewSelectedIndex(){
        let label = labels[selectedIndex]
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            self.thumbView.frame = label.frame
            }, completion: {
                (complete) in
        })
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.labels[self.previousSelectedIndex].textColor = self.normalTextColor
            label.textColor = self.highlightTextColor
        }
        
        delegate?.segementedControlSelectedIndexUpdated(index: selectedIndex)
    }
    
    var percent: CGFloat = 0 {
        didSet {
            thumbView.frame.origin.x = frame.size.width * percent
        }
    }
}