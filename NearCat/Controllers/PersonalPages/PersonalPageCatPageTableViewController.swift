//
//  PersonalPageCatPageTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/2/5.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalPageCatPageTableViewController: PersonalPageSubPageTableViewController {

    var catData: [JSON] = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extension_registerCellForNibName("PersonalPageCatArchiveCell", cellReuseIdentifier: "PersonalPageCatArchiveTableViewCell")
        extension_setupFooterView()
        
        tableView.backgroundColor = Constant.Color.TableViewBackground
        tableView.separatorStyle = .None
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        _loadData()
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catData.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 312.0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonalPageCatArchiveTableViewCell", forIndexPath: indexPath) as! PersonalPageCatArchiveTableViewCell
        
        cell.catData = catData[indexPath.row]
        
        return cell
        
    }
    
    // MARK: = data function
    
    private func _loadData() {
        
        guard let userId = parentTVCDelegate?.userId else {return}
        
        Action.cats.byUserId(userId) { (success, data, description) -> Void in
            if success {
                self.catData = data.arrayValue
                
                self.extension_reloadTableView()
            }
        }
        
    }
    
}
