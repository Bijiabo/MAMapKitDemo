//
//  UITableViewControllerExtension.swift
//  NearCat
//
//  Created by huchunbo on 16/1/20.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewController {
    func extension_setupFooterView() {
        
        // setup tableview footer view
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
    }
    
    func extension_setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "松开刷新喵")
        refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
        tableView.sendSubviewToBack(refreshControl!)
    }
    
    func extension_reloadTableView() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    func extension_registerLoadingCellNib() {
        let nib: UINib = UINib(nibName: "LoadMoreCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "loadMoreCell")
    }
}