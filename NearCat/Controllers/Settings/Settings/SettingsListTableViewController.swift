//
//  SettingsListTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/12.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SettingsListTableViewController: SettingSecondaryTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        extension_setupFooterView()
        tableView.backgroundColor = Constant.Color.TableViewBackground
        tableView.separatorStyle = .None
        
        extension_registerCellForNibName("SettingCatalogueCell", cellReuseIdentifier: "settingsCatalogueCell")
        extension_registerCellForNibName("SettingSwitchCell", cellReuseIdentifier: "settingSwitchCell")
        extension_registerCellForNibName("SettingNormalCell", cellReuseIdentifier: "settingNormalCell")
        extension_registerCellForNibName("ExplainTableViewCell", cellReuseIdentifier: "explainTableViewCell")
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
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48.0
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
                let cell = tableView.dequeueReusableCellWithIdentifier("settingsCatalogueCell", forIndexPath: indexPath) as! SettingCatalogueTableViewCell
                cell.title = "消息通知"
                cell.displaySeparatorLineView = indexPath.row + 1 != self.tableView(tableView, numberOfRowsInSection: indexPath.section)
                
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("settingSwitchCell", forIndexPath: indexPath) as! SettingSwitchCell
                cell.title = "在地图上显示我的位置"
                cell.on = true
                cell.displaySeparatorLineView = indexPath.row + 1 != self.tableView(tableView, numberOfRowsInSection: indexPath.section)
                
                return cell
                
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("settingNormalCell", forIndexPath: indexPath) as! SettingNormalTableViewCell
                cell.title = "退出"
                
                return cell
                
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("settingsCatalogueCell", forIndexPath: indexPath) as! SettingCatalogueTableViewCell
                cell.displaySeparatorLineView = indexPath.row + 1 != self.tableView(tableView, numberOfRowsInSection: indexPath.section)
                
                return cell
            }
            
            
        case 1:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("settingsCatalogueCell", forIndexPath: indexPath) as! SettingCatalogueTableViewCell
            cell.title = "关于猫邻"
            cell.displaySeparatorLineView = indexPath.row + 1 != self.tableView(tableView, numberOfRowsInSection: indexPath.section)
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let vc = Helper.Controller.NotificationSetting
                tabBarController?.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                break
            default:
                break
            }
            
        case 2:
            switch indexPath.row {
            case 0:
                break
            default:
                break
            }
            
        default:
            break
        }
    }

}
