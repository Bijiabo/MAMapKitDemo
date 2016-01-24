//
//  SelectionTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/24.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

enum SelectionVCType {
    case input
    case singleItem
    case catalogue
}

class SelectionTableViewController: UITableViewController {
    
    var type: SelectionVCType = .singleItem
    var data: JSON = JSON([])

    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = true

    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48.0
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        switch type {
        case .input:
            return 1
        case .singleItem:
            return 1
        case .catalogue:
            return 1
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch type {
        case .input:
            return 1
        case .singleItem:
            return data.count
        case .catalogue:
            return data.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch type {
        case .input:
            let cell = tableView.dequeueReusableCellWithIdentifier("selectionInputCell", forIndexPath: indexPath) as! SelectionInputTableViewCell
            
            
            return cell
        case .singleItem:
            let cell = tableView.dequeueReusableCellWithIdentifier("selectionSingleItemCell", forIndexPath: indexPath) as! SelectionSingleItemTableViewCell
            
            // Configure the cell...
            
            return cell
        case .catalogue:
            let cell = tableView.dequeueReusableCellWithIdentifier("selectionCatalogueCell", forIndexPath: indexPath) as! SelectionCatalogueTableViewCell
            
            // Configure the cell...
            
            return cell
        }
    }



}
