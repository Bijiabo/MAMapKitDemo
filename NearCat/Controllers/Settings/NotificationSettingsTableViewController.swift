//
//  NotificationSettingsTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/2/2.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class NotificationSettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "消息通知"

        extension_setupFooterView()
        clearsSelectionOnViewWillAppear = true
        
        extension_registerCellForNibName("SettingCatalogueCell", cellReuseIdentifier: "settingsCatalogueCell")
        extension_registerCellForNibName("SettingSwitchCell", cellReuseIdentifier: "settingSwitchCell")
        extension_registerCellForNibName("SettingNormalCell", cellReuseIdentifier: "settingNormalCell")
        extension_registerCellForNibName("ExplainTableViewCell", cellReuseIdentifier: "explainTableViewCell")
        
        tableView.backgroundColor = Constant.Color.TableViewBackground
        tableView.separatorStyle = .None
        
        tableView.estimatedRowHeight = 48.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        
        return view
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12.0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("titleWithValueCell", forIndexPath: indexPath) as! SettingTitleWithValueTableViewCell
                cell.title = "接收消息通知"
                cell.value = "已开启"
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("explainTableViewCell", forIndexPath: indexPath) as! ExplainTableViewCell
                cell.content = "如果你要关闭或开启猫邻的新消息通知，请打开 iPhone 的 \"设置\" > \"通知\" 功能， 找到应用程序 \"猫邻\" 进行修改。"
                
                return cell
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("settingSwitchCell", forIndexPath: indexPath) as! SettingSwitchCell
                cell.title = "声效"
                cell.on = true
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("settingSwitchCell", forIndexPath: indexPath) as! SettingSwitchCell
                cell.title = "震动"
                cell.on = true
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("explainTableViewCell", forIndexPath: indexPath) as! ExplainTableViewCell
                cell.content = "选择收到通知时是否开启声音和震动提醒。"
                
                return cell
            default:
                break
            }
            
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("settingSwitchCell", forIndexPath: indexPath) as! SettingSwitchCell
                cell.title = "圈子照片更新提示"
                cell.on = true
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("explainTableViewCell", forIndexPath: indexPath) as! ExplainTableViewCell
                cell.content = "关闭后，当圈子照片更新是，界面下方的按钮将不会出现红点提示。"
                
                return cell
            default:
                break
            }
            
        default:
            break
        }
        
        return UITableViewCell()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
