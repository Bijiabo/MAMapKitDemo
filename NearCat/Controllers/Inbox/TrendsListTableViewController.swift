//
//  TrendsListTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class TrendsListTableViewController: UITableViewController {

    private var _trends: JSON = JSON([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
        _loadData()
    }
    
    private func _initViews() {
        clearsSelectionOnViewWillAppear = false
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // setup tableview footer view
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return _trends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("trendsListCell", forIndexPath: indexPath) as! TrendsListTableViewCell
        let currentData = _trends[indexPath.row]
        
        cell.content = currentData["content"].stringValue
        cell.date = currentData["created_at"].stringValue

        return cell
    }

    // MARK: - Data functions
    
    private func _loadData() {
        Action.trends.list { (success, data, description) -> Void in
            if success {
                self._trends = data
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            } else {
                print(description)
            }
        }
    }
}
