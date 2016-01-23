//
//  MyArchiveTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/12.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class MyArchiveTableViewController: SettingSecondaryTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的资料"
        
        tableView.separatorStyle = .None
        tableView.backgroundColor = Constant.Color.TableViewBackground
        clearsSelectionOnViewWillAppear = true
        
        extension_setupFooterView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 148.0
        default:
            return 48.0
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 36.0
        }
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Constant.Color.TableViewBackground
        return view
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("myArchiveSettingAvatarCell", forIndexPath: indexPath) as! MyArchiveSettingAvatarTableViewCell
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("userArchiveCell", forIndexPath: indexPath) as! MyArchiveSettingItemTableViewCell
            
            if indexPath.row + 1 == self.tableView(tableView, numberOfRowsInSection: indexPath.section) {
                cell.displaySeparatorLine = false
            } else {
                cell.displaySeparatorLine = true
            }
            
            return cell
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
