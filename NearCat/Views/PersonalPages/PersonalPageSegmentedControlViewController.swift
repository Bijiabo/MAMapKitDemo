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
            if let view = view as? PersonalPageSegmentedControlView {
                view.selectedIndex = selectedIndex
            }
        }
    }
    
    @IBAction func tapLeftButton(sender: UIButton) {
        _tapButtonForIndex(0)
    }
    
    @IBAction func tapCenterButton(sender: UIButton) {
        _tapButtonForIndex(1)
    }
    
    @IBAction func tapRightButton(sender: UIButton) {
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    private func _tapButtonForIndex(index: Int) {
        
        if let view = view as? PersonalPageSegmentedControlView {
            view.selectedIndex = index
        }
        
        delegate?.segementedControlSelectedIndexUpdated(index: index)
    }
    
    func setupButtonTitles() {
        guard titles.count < 3 else {return}
        
        leftButton.setTitle(titles[0], forState: UIControlState.Normal)
        centerButton.setTitle(titles[1], forState: UIControlState.Normal)
        rightButton.setTitle(titles[2], forState: UIControlState.Normal)
    }
    
}

class PersonalPageSegmentedControlView: UIView {
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var highlightView: UIView!
    
    var selectedIndex: Int = 0 {
        didSet {
            updateHighlightDisplay()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Helper.UI.setLabel(leftButton.titleLabel!, forStyle: Constant.TextStyle.Cell.Title.Blue)
        Helper.UI.setLabel(rightButton.titleLabel!, forStyle: Constant.TextStyle.Cell.Title.G2)
        Helper.UI.setLabel(centerButton.titleLabel!, forStyle: Constant.TextStyle.Cell.Title.G2)
    }
    
    func updateHighlightDisplay() {
        
        UIView.animateWithDuration(0.5) { () -> Void in
            let normalStyle = Constant.TextStyle.Cell.Title.Black
            let activeStyle = Constant.TextStyle.Cell.Title.Blue
            Helper.UI.setLabel(self.leftButton.titleLabel!, forStyle: self.selectedIndex == 0 ? activeStyle : normalStyle )
            Helper.UI.setLabel(self.centerButton.titleLabel!, forStyle: self.selectedIndex == 1 ? activeStyle : normalStyle)
            Helper.UI.setLabel(self.rightButton.titleLabel!, forStyle: self.selectedIndex == 2 ? activeStyle : normalStyle)
        }
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            
            switch self.selectedIndex {
            case 0:
                self.highlightView.frame.origin.x = self.leftButton.frame.origin.x
            case 1:
                self.highlightView.frame.origin.x = self.centerButton.frame.origin.x
            default:
                self.highlightView.frame.origin.x = self.rightButton.frame.origin.x
            }
            
            self.setNeedsDisplay()
            
            }, completion: nil)
    }
}
