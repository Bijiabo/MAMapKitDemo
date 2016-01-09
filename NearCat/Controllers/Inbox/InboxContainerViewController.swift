//
//  InboxContainerViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class InboxContainerViewController: UIViewController {

    @IBOutlet weak var headerSegmentedControl: SegmentedControl!
    @IBOutlet weak var contentContainerView: UIView!
    
    var currentChildViewController: UIViewController?
    var storyboardIdentifiers: [String] = ["NotificationViewController", "TrendsViewController", "privateMessageViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupSegmentedControl()
        _setupContentContainerView()
        
        _updateChildViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func _setupSegmentedControl() {
        headerSegmentedControl.items = ["通知", "动态", "私信"]
        headerSegmentedControl.delegate = self
    }
    
    private func _setupContentContainerView() {
        contentContainerView.layoutMargins = UIEdgeInsetsZero
    }
    
    private func _updateChildViewController() {
        // remove old child view controller
        if currentChildViewController != nil {
            contentContainerView.removeConstraints(contentContainerView.constraints)
            currentChildViewController?.view.removeFromSuperview()
            currentChildViewController?.removeFromParentViewController()
            currentChildViewController = nil
        }
        
        // add child view controller
        currentChildViewController = storyboard?.instantiateViewControllerWithIdentifier(storyboardIdentifiers[headerSegmentedControl.selectedIndex])
        currentChildViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(currentChildViewController!)
        contentContainerView.addSubview(currentChildViewController!.view)
        
        let viewDict: [String: AnyObject] = ["currentChildViewController": currentChildViewController!.view]
        let formatComponent: String = "|-[currentChildViewController]-|"
        contentContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:\(formatComponent)", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        contentContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:\(formatComponent)", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}

extension InboxContainerViewController: SegmentedControlDelegate {
    func segementedControlSelectedIndexUpdated(index index: Int) {
        _updateChildViewController()
    }
    
}