//
//  AboutTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/2/2.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "关于猫邻"

        clearsSelectionOnViewWillAppear = true
        extension_setupFooterView()
        tableView.backgroundColor = Constant.Color.TableViewBackground
        tableView.separatorStyle = .None
        
        extension_registerCellForNibName("SettingCatalogueCell", cellReuseIdentifier: "settingsCatalogueCell")
        extension_registerCellForNibName("SettingSwitchCell", cellReuseIdentifier: "settingSwitchCell")
        extension_registerCellForNibName("SettingNormalCell", cellReuseIdentifier: "settingNormalCell")
        extension_registerCellForNibName("ExplainTableViewCell", cellReuseIdentifier: "explainTableViewCell")
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
            return 1
        case 1:
            return 1
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 172.0
        default:
            return 48.0
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
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 36.0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("aboutHeaderCell", forIndexPath: indexPath) as! AboutHeaderTableViewCell
            let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
            let dict = NSDictionary(contentsOfFile: path!)
            if let version = dict?.valueForKey("CFBundleShortVersionString") as? String {
                cell.version = version
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("settingsCatalogueCell", forIndexPath: indexPath) as! SettingCatalogueTableViewCell
            cell.title = "评分"
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("settingsCatalogueCell", forIndexPath: indexPath) as! SettingCatalogueTableViewCell
            switch indexPath.row {
            case 0:
                cell.title = "欢迎页面"
            case 1:
                cell.title = "功能介绍"
            case 2:
                cell.title = "猫邻官方网站"
            default:
                break
            }
            
            return cell
            
        default:
            break
        }
        
        return UITableViewCell()
    }

}
