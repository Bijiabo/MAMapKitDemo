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
    }
    
    private func _initViews() {
        clearsSelectionOnViewWillAppear = false
        tableView.separatorStyle = .None
        
        // setup tableview footer view
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        tableView.backgroundColor = Constant.Color.TableViewBackground
    }
    
    private var _hasBeenAppeared: Bool = false
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !_hasBeenAppeared {
            _loadData()
            _hasBeenAppeared = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return _listData.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130.0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24.0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("privateMessageListCell", forIndexPath: indexPath) as! PrivateMessageListTableViewCell
        // TODO: load user's avatar
        let currentData = _listData[indexPath.section]
        let currentUser = currentData["user"]
        cell.userId = currentUser["id"].intValue
        cell.userName = currentUser["name"].stringValue
        cell.content = currentData["latestMessage"]["content"].stringValue
        Helper.setRemoteImageForImageView(cell.avatarImageView, imagePath: currentUser["avatar"].stringValue)

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
