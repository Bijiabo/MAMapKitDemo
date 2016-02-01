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
    private var _followingData: [JSON] = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .None
        tableView.sectionIndexColor = Constant.Color.G3
        tableView.sectionIndexBackgroundColor = UIColor.whiteColor()
        tableView.sectionIndexMinimumDisplayRowCount = 15
        
        title = "我关注的"
        
        _loadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 72.0
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return _followingData.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return _followingData[section]["data"].arrayValue.count
        
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("followingCell", forIndexPath: indexPath) as! FollowingTableViewCell
        let currentData = _followingData[indexPath.section]["data"].arrayValue[indexPath.row]
        
        cell.userName = currentData["name"].stringValue
        cell.id = currentData["id"].intValue
        let avatarURLString: String = FConfiguration.sharedInstance.host+currentData["avatar"].stringValue
        Helper.setRemoteImageForImageView(cell.avatarImageView, avatarURLString: avatarURLString)
        
        _autoHideSeparatorForCell(cell, indexPath: indexPath)
        
        return cell
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
            
            var _cache = self._followingData[indexPath.section]["data"].arrayValue
            _cache.removeAtIndex(indexPath.row)
            self._followingData[indexPath.section]["data"] = JSON(_cache)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        }
        
        deleteButton.backgroundColor = Constant.Color.Pink
        
        return [deleteButton]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 36))
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-24-[label(100)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label": label]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[label]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label": label]))
        
        view.backgroundColor = UIColor.whiteColor()
        label.text = _followingData[section]["key"].stringValue
        Helper.UI.setLabel(label, forStyle: Constant.TextStyle.ABC.Blue)
        
        return view
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        var titles: [String] = [String]()
        
        for item in _followingData {
            titles.append(item["key"].stringValue)
        }
        
        return titles
    }
    
    private func _autoHideSeparatorForCell(var cell: CustomSeparatorCell, indexPath: NSIndexPath) {
        if indexPath.row + 1 == self.tableView(tableView, numberOfRowsInSection: indexPath.section) {
            cell.displaySeparatorLine = false
        } else {
            cell.displaySeparatorLine = true
        }
    }
    
    // MARK: - data function
    
    private func _loadData() {
        Action.follow.selfFollowing { (success, data, description) -> Void in
            if success {
                self._following = data.arrayValue
                self._processData()
//                self.extension_reloadTableView()
            } else {
                print(description)
            }
        }
    }
    
    private func _setLoadingCellStatus(loading loading: Bool) {
        guard let loadingCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as? LoadingTableViewCell else {return}
        loadingCell.loading = loading
    }
    
    private func _processData() {
        var previousFirstLetter: Character?
        var followingDataCache: [JSON] = [JSON]()
        
        for value in _following {
            let _firstLetter = value["name_spelling"].stringValue.characters.first
            
            if previousFirstLetter == _firstLetter && _firstLetter != nil {
                var _cache = followingDataCache[followingDataCache.count-1]["data"].arrayValue
                _cache.append(value)
                followingDataCache[followingDataCache.count-1]["data"] = JSON(_cache)
            } else if let firstLetter = _firstLetter{
                let key = String(firstLetter).uppercaseString
                previousFirstLetter = firstLetter
                
                let data: [String: JSON] = [
                    "key": JSON(key),
                    "data": JSON([value])
                ]
                followingDataCache.append(JSON(data))
            }
        }
        
        _followingData = followingDataCache
        
        extension_reloadTableView()
    }
    
    // MARK: - navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "followToPersonalPage" {
            guard let targetVC = segue.destinationViewController as? PersonalPageTableViewController else {return}
            guard let cell = sender as? FollowingTableViewCell else {return}
            targetVC.user_id = cell.id
        }
    }

}
