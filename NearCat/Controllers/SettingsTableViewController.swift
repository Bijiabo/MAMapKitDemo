//
//  SettingsTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit
import FServiceManager

class SettingsTableViewController: UITableViewController, LoginRequesterProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
        
        _addNotificationObserver()
    }
    
    private func _initViews() {
        
        title = "Settings"
        clearsSelectionOnViewWillAppear = true
        
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
        
        // tableView.contentInset.top = 44.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func _addNotificationObserver() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("logStatusChanged:"), name: FConstant.Notification.FStatus.didLogin , object: nil)
        notificationCenter.addObserver(self, selector: Selector("logStatusChanged:"), name: FConstant.Notification.FStatus.didLogout , object: nil)
    }

    func logStatusChanged(notification: NSNotification) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 280.0
        }
        
        return 44.0
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // TODO: - split logged in or did not logged in
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return FHelper.logged_in ? 3 : 2
        default:
            return 0
        }
    }
    
    private var _cellData = [
        [["id": "settingHeaderCell"]],
        [
            [
                "id": "myArchive",
                "title": "我的资料",
                "icon": ""
            ],
            [
                "id": "catArchive",
                "title": "猫咪资料",
                "icon": ""
            ],
            [
                "id": "myFollow",
                "title": "我关注的",
                "icon": ""
            ],
            [
                "id": "myThumbs",
                "title": "我赞过的",
                "icon": ""
            ]
        ],
        [
            [
                "id": "setting",
                "title": "设置",
                "icon": ""
            ],
            [
                "id": "feedback",
                "title": "反馈",
                "icon": ""
            ],
            [
                "id": "quit",
                "title": "退出",
                "icon": ""
            ]
        ]
    ]

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("settingHeaderCell", forIndexPath: indexPath) as! Settings_Header_TableViewCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("settingCell", forIndexPath: indexPath) as! SettingListTableViewCell
            let currentData = _cellData[indexPath.section][indexPath.row]
            
            cell.title = currentData["title"]
            
            if let iconName = currentData["icon"] {
                if !iconName.isEmpty {
                    cell.iconImageView.image = UIImage(named: iconName)
                }
            }
            
            return cell
        }
        
    }


    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < 2 {return 0}
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44.0))
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }

    // MARK: - table view delegate
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 {
            return
        } else {
            guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? SettingListTableViewCell else {return}
            switch cell.identifier {
            case "quit":
                FAction.logout()
            default:
                break
            }
        }
        
    }
    
    private func _showLoginAlert() {
        NSNotificationCenter.defaultCenter().postNotificationName(Constant.Notification.Alert.showLoginTextField, object: self)
    }
    
    // MARK: - LoginRequesterProtocol
    func didLoginSuccess() {
        
    }
    
    func didLoginCancel() {
        
    }
}