//
//  PersonalPageCatPageTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/2/5.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PersonalPageCatPageTableViewController: PersonalPageSubPageTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        extension_registerCellForNibName("PersonalPageCatArchiveCell", cellReuseIdentifier: "PersonalPageCatArchiveTableViewCell")
        extension_setupFooterView()
        
        tableView.backgroundColor = Constant.Color.TableViewBackground
        tableView.separatorStyle = .None
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 10
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 48.0
        default:
            return 312.0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return UITableViewCell()
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("PersonalPageCatArchiveTableViewCell", forIndexPath: indexPath) as! PersonalPageCatArchiveTableViewCell
            return cell
        }
        
    }
    
}
