//
//  PersonalPageMianPageTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/2/5.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalPageMianPageTableViewController: PersonalPageSubPageTableViewController {

    var userData: JSON = JSON([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 48.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        tableView.backgroundColor = Constant.Color.TableViewBackground
        
        extension_setupFooterView()
        
    }
    
    private var _hasBeenAppear: Bool = false
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !_hasBeenAppear {
            _loadData()
            _hasBeenAppear = true
        }
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
            let intro: String = userData["introduction"].stringValue.characters.count == 0 ? "这家伙有点懒喵，还没有写简介..." : userData["introduction"].stringValue
            cell.content = "简介： \(intro)"
            cell.address = "\(userData["province"].stringValue) \(userData["city"].stringValue)"
            cell.distance = "距离 2.6km"
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("PersonalPageMainPageTitleWithValueTableViewCell", forIndexPath: indexPath) as! PersonalPageMainPageTitleWithValueTableViewCell
            
            switch indexPath.row {
            case 0:
                cell.title = "性别"
                cell.value = userData["gender"].intValue == 0 ? "女" : "男"
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
    
    // MARK: - data functions
    
    private func _loadData() {
        
        guard let userId = parentTVCDelegate?.userId else {return}
        
        Action.users.informationFor(userId: userId) { (success, data, description) -> Void in
            if success {
                self.userData = data
                
                self.extension_reloadTableView()
            }
        }
        
    }
    
}
