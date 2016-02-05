//
//  PersonalPageSubPageTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/2/5.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PersonalPageSubPageTableViewController: UITableViewController {

    var parentTVCDelegate: PersonalPageTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if targetContentOffset.memory.y <= 0 {
            tableView.scrollEnabled = false
        }
    }
    
    private var _originalParentTVC_offset_y: CGFloat = 0
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if let offsetY = parentTVCDelegate?.tableView.contentOffset.y {
            _originalParentTVC_offset_y = offsetY
        }
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            tableView.scrollEnabled = false
        }
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < 0 {
            tableView.scrollEnabled = false
        }
    }
    
}
