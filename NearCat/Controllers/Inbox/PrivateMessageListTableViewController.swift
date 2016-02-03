//
//  PrivateMessageListTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PrivateMessageListTableViewController: UITableViewController {
    
    private var _listData: JSON = JSON([])

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
        return _listData.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("privateMessageListCell", forIndexPath: indexPath) as! PrivateMessageListTableViewCell
        // TODO: load user's avatar
        let currentData = _listData[indexPath.row]
        let currentUser = currentData["user"]
        cell.userId = currentUser["id"].intValue
        cell.userName = currentUser["name"].stringValue
        cell.content = currentData["latestMessage"]["content"].stringValue

        return cell
    }


    // MARK: - data functions
    
    private func _loadData() {
        Action.privateMessages.list { (success, data, description) -> Void in
            if success {
                self._listData = data
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showChatView" {
            if
            let targetVC = segue.destinationViewController as? PrivateMessageChatContainerViewController,
            let cell = sender as? PrivateMessageListTableViewCell
            {
                targetVC.toUserId = cell.userId
                targetVC.title = cell.userName
            }
        }
    }
}
