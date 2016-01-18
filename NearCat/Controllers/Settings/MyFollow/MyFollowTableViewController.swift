//
//  MyFollowTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/12.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyFollowTableViewController: SettingSecondaryTableViewController {
    
    private var _following: [JSON] = [JSON]()
    private var _followingPage: Int = 1
    private var _followingMaxPageCount: Int = Int.max

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _loadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return _following.count
        default:
            return 1
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("followingCell", forIndexPath: indexPath) as! FollowingTableViewCell
            let currentData = _following[indexPath.row]
            
            cell.userName = currentData["name"].stringValue
            cell.id = currentData["id"].intValue
            let avatarURLString: String = FConfiguration.sharedInstance.host+currentData["avatar"].stringValue
            Helper.setRemoteImageForImageView(cell.avatarImageView, avatarURLString: avatarURLString)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("loadmore", forIndexPath: indexPath) as! LoadingTableViewCell
            
            if _followingPage < _followingMaxPageCount {
                cell.loading = true
                _followingPage += 1
                _loadData()
            } else {
                cell.loading = false
            }
            
            return cell
        }
        
    }
    
    // MARK: - cancel following
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "取消关注") { (rowAction, indexPath) -> Void in
            guard let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? FollowingTableViewCell else {return}
            let userId = cell.id
            Action.follow.unfollow(userId: userId, completeHandler: { (success, description) -> Void in
                print(success)
                print(description)
            })
            
            self._following.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        }
        
        deleteButton.backgroundColor = Constant.Color.Theme
        
        return [deleteButton]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 {return true}
        return false
    }
    
    // MARK: - data function
    
    private func _loadData() {
        if _followingPage >= _followingMaxPageCount {return}
        Action.follow.following(userId: FHelper.current_user.id, page: _followingPage) { (success, data, description) -> Void in
            if success {
                if data.count == 0 {
                    self._followingMaxPageCount = self._followingPage
                    self._setLoadingCellStatus(loading: false)
                    return
                }
                
                self._following += data.arrayValue
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
                
            } else {
                print(description)
            }
        }
    }
    
    private func _setLoadingCellStatus(loading loading: Bool) {
        guard let loadingCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as? LoadingTableViewCell else {return}
        loadingCell.loading = loading
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "followToPersonalPage" {
            guard let targetVC = segue.destinationViewController as? PersonalPageTableViewController else {return}
            guard let cell = sender as? FollowingTableViewCell else {return}
            targetVC.user_id = cell.id
            
        }
    }

}
