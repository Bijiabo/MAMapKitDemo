//
//  PrivateMessageChatTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/15.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PrivateMessageChatTableViewController: InputInterfaceTableViewController {
    
    var toUserId: Int = 0
    var chatData: JSON = JSON([])
    var containerDelegate: InputContainerViewController?

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
        return chatData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath)
        let currentData = chatData[indexPath.row]
        let send: Bool = currentData["fromUser_id"].intValue == FHelper.current_user.id
        cell.textLabel?.text = currentData["content"].stringValue
        if send {
            cell.textLabel?.textAlignment = .Right
        } else {
            cell.textLabel?.textAlignment = .Left
        }
        return cell
    }
    
    // MARK: - scroll view delegate
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        containerDelegate?.didBeginScroll()
    }
    
    // MARK: - data functions
    
    private func _loadData() {
        Action.privateMessages.withUser(userId: toUserId) { (success, data, description) -> Void in
            if success {
                self.chatData = data
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.tableView.scrollToBottom()
                })
            }
        }
    }
    
}

