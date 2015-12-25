//
//  CatArchiveEditTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit

class CatArchiveEditTableViewController: UITableViewController {

    let dataItemConfig = [
        [
            "title": "name",
            "placeHolder": "enter cat name",
            "key": "name"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
    }

    private func _initViews() {
        
        title = "Edit Cat"
        
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return dataItemConfig.count
        default:
            return 0
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("avatar", forIndexPath: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("inputItem", forIndexPath: indexPath) as! CatArchiveItemTableViewCell
            let currentData = dataItemConfig[indexPath.row]
            cell.titleLabel.text = currentData["title"]
            cell.textField.placeholder = currentData["placeHolder"]
            return cell
        default:
            break
        }

        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100.0
        case 1:
            return 44.0
        default:
            return 44.0
        }
    }

}
