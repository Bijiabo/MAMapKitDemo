//
//  CatArchiveDetailTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit

class CatArchiveDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
            return 3
        default:
            return 0
        }
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

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("avatar", forIndexPath: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("detailItem", forIndexPath: indexPath) as! CatArchiveDetailItemTableViewCell
            cell.titleLabel.text = "title"
            cell.contentLabel.text = "content"
            return cell
        default:
            return UITableViewCell()
        }
    }
}
