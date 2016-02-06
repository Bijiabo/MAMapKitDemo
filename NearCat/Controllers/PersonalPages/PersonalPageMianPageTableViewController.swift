//
//  PersonalPageMianPageTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/2/5.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PersonalPageMianPageTableViewController: PersonalPageSubPageTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 48.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        tableView.backgroundColor = Constant.Color.TableViewBackground
        
        extension_setupFooterView()
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 36.0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 3
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("PersonalPageIntroTableViewCell", forIndexPath: indexPath) as! PersonalPageMainPageIntroTableViewCell
            cell.content = "简介： 最近要给喵白找个男盆友，毛色品种相似度高的猫公子优先考虑，周末可以带猫在公园见家长。"
            cell.address = "北京 东城区"
            cell.distance = "距离 2.6km"
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("PersonalPageMainPageTitleWithValueTableViewCell", forIndexPath: indexPath) as! PersonalPageMainPageTitleWithValueTableViewCell
            
            switch indexPath.row {
            case 0:
                cell.title = "性别"
                cell.value = "女"
            case 1:
                cell.title = "职业"
                cell.value = "插画家"
            default:
                cell.title = "养猫经验"
                cell.value = "3年"
            }
            
            cell.displaySepatatorLineView = indexPath.row + 1 != self.tableView(tableView, numberOfRowsInSection: indexPath.section)
            
            return cell
        }
        
    }
    
}
