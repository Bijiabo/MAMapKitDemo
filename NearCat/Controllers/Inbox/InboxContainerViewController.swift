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
    @IBOutlet weak var contentContainerView: UIScrollView!
    
    var currentChildViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupSegmentedControl()
    }
    
    private var _hasBeenSetup: Bool = false
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !_hasBeenSetup {
            _setupContentContainerView()
            _updateChildViewController()
            _hasBeenSetup = true
        }
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
        
        contentContainerView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width*3.0, height: 0)
        contentContainerView.directionalLockEnabled = true
        contentContainerView.bounces = false
        contentContainerView.alwaysBounceVertical = false
        contentContainerView.alwaysBounceHorizontal = false
        contentContainerView.pagingEnabled = true
        contentContainerView.showsVerticalScrollIndicator = false
        contentContainerView.showsHorizontalScrollIndicator = false
        contentContainerView.delegate = self
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
        for i in 0..<3 {
            var vc: UITableViewController
            switch i {
            case 0:
                vc = Helper.Controller.NotificationList
            case 1:
                vc = Helper.Controller.TrendsList
            default:
                vc = Helper.Controller.PrivateMessageList
            }
            
            vc.tableView.contentInset = UIEdgeInsets(top: 54.0, left: 0, bottom: 60.0, right: 0)
            vc.view.frame = UIScreen.mainScreen().bounds
            vc.view.frame.origin.x = UIScreen.mainScreen().bounds.size.width * CGFloat(i)
            addChildViewController(vc)
            contentContainerView.addSubview(vc.view)
        }
        
    }
}

extension InboxContainerViewController: SegmentedControlDelegate {
    
    func segementedControlSelectedIndexUpdated(index index: Int) {
        UIView.animateWithDuration(0.2) { () -> Void in
            self.contentContainerView.contentOffset.x = CGFloat(index) * self.contentContainerView.frame.width
        }
    }
    
}

extension InboxContainerViewController: UIScrollViewDelegate {
    
    var currentPage: Int {
        get {
            return Int(contentContainerView.contentOffset.x / contentContainerView.frame.size.width + 0.5)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        headerSegmentedControl.percent = contentContainerView.contentOffset.x / contentContainerView.contentSize.width
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        headerSegmentedControl.selectedIndex = currentPage
    }
    
}