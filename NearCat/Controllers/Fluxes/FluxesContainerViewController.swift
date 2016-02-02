//
//  FluxesContainerViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class FluxesContainerViewController: UIViewController {
    
    @IBOutlet weak var headerSegmentedControl: SegmentedControl!
    @IBOutlet weak var contentContainerView: UIScrollView!
    
    var currentChildViewController: UIViewController?
    var fluxesTypes: [String] = ["follow", "recommend", "all"]

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
        headerSegmentedControl.items = ["关注", "热门", "最新"]
        headerSegmentedControl.delegate = self
    }
    
    private func _setupContentContainerView() {
        contentContainerView.layoutMargins = UIEdgeInsetsZero
        
        contentContainerView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width*3.0, height: 0)
        contentContainerView.directionalLockEnabled = true
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
            let fluxListVC = Helper.Controller.FluxList
            fluxListVC.listType = fluxesTypes[i]
            fluxListVC.tableView.contentInset = UIEdgeInsets(top: 64.0, left: 0, bottom: 50.0, right: 0)
            fluxListVC.view.frame = UIScreen.mainScreen().bounds
            fluxListVC.view.frame.origin.x = UIScreen.mainScreen().bounds.size.width * CGFloat(i)
            addChildViewController(fluxListVC)
            contentContainerView.addSubview(fluxListVC.view)
        }
    }
    
}


extension FluxesContainerViewController: SegmentedControlDelegate {
    func segementedControlSelectedIndexUpdated(index index: Int) {
//        _updateChildViewController()
    }
    
}

extension FluxesContainerViewController: UIScrollViewDelegate {
    
    var currentPage: Int {
        get {
            return Int(contentContainerView.contentOffset.x / contentContainerView.frame.size.width + 0.5)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        headerSegmentedControl.percent = contentContainerView.contentOffset.x / contentContainerView.contentSize.width
    }
    
}