//
//  PersonalPageSegmentedControlView.swift
//  NearCat
//
//  Created by huchunbo on 16/2/5.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PersonalPageSegmentedControlViewController: UIViewController {

    @IBOutlet weak var highlightView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    weak var delegate: SegmentedControlDelegate?
    var selectedIndex: Int = 0 {
        didSet {
            _updateHighlightDisplay()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func tapLeftButton(sender: AnyObject) {
        _tapButtonForIndex(0)
    }
    
    @IBAction func tapCenterButton(sender: AnyObject) {
        _tapButtonForIndex(1)
    }
    
    @IBAction func tapRightButton(sender: AnyObject) {
        _tapButtonForIndex(2)
    }
    
    var titles: [String] = [String]() {
        didSet {
            setupButtonTitles()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func _tapButtonForIndex(index: Int) {
        selectedIndex = index
        delegate?.segementedControlSelectedIndexUpdated(index: index)
    }
    
    private func _updateHighlightDisplay() {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            
            switch self.selectedIndex {
            case 0:
                self.highlightView.frame.origin.x = self.leftButton.frame.origin.x
            case 1:
                self.highlightView.frame.origin.x = self.centerButton.frame.origin.x
            default:
                self.highlightView.frame.origin.x = self.rightButton.frame.origin.x
            }
            
            }, completion: nil)
    }
    
    func setupButtonTitles() {
        guard titles.count < 3 else {return}
        
        leftButton.setTitle(titles[0], forState: UIControlState.Normal)
        centerButton.setTitle(titles[1], forState: UIControlState.Normal)
        rightButton.setTitle(titles[2], forState: UIControlState.Normal)
    }
    
}
