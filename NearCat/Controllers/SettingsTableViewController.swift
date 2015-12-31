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
        
        tableView.contentInset.top = 44.0
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // TODO: - split logged in or did not logged in
        return FHelper.logged_in ? 3 : 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return FHelper.logged_in ? 2 : 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if FHelper.logged_in {
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCellWithIdentifier("catArchives", forIndexPath: indexPath) as! Settings_CatArchives_TableViewCell
                    return cell
                default: // indexPath.row == 1
                    let cell = tableView.dequeueReusableCellWithIdentifier("findMe", forIndexPath: indexPath) as! Settings_FindMe_TableViewCell
                    return cell
                }
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("pleaseLogin", forIndexPath: indexPath)
                return cell
            }
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("feedback", forIndexPath: indexPath)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("quit", forIndexPath: indexPath)
            return cell
            
        default:
            break
        }

        return UITableViewCell()
    }


    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return " "
        case 1:
            return " "
        case 2:
            return " "
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44.0))
        footerView.backgroundColor = UIColor.clearColor()
        return footerView
    }

    // MARK: - table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else {return}
        guard let cellReuseIdentifier = cell.reuseIdentifier else {return}
        
        // user tap login cell
        switch cellReuseIdentifier {
        case "pleaseLogin":
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            NSNotificationCenter.defaultCenter().postNotificationName(Constant.Notification.Alert.showLoginTextField, object: self)
        case "quit":
            FAction.logout()
            // TODO: - refresh views
        default:
            break
        }
    }
    
    // MARK: - LoginRequesterProtocol
    func didLoginSuccess() {
        
    }
    
    func didLoginCancel() {
        
    }
}