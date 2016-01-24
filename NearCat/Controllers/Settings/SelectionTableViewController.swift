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
    
    var identifier: String = String()
    var type: SelectionVCType = .singleItem
    var data: JSON = JSON([])
    var delegate: SelectionControllerDelegate?
    var selectedData: [String: AnyObject] = [String: AnyObject]()
    var originViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        tableView.separatorStyle = .None
        tableView.backgroundColor = Constant.Color.TableViewBackground
        
        extension_setupFooterView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if type == .input {
            _saveData()
        }
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
            cell.placeholder = data["placeholder"].stringValue
            cell.value = data["value"].stringValue
            
            _autoHideSeparatorForCell(cell, indexPath: indexPath)
            return cell
        case .singleItem:
            let cell = tableView.dequeueReusableCellWithIdentifier("selectionSingleItemCell", forIndexPath: indexPath) as! SelectionSingleItemTableViewCell
            let currentData = data[indexPath.row]
            
            cell.title = currentData["title"].stringValue
            cell.rawValue = currentData["value"].stringValue
            cell.check = currentData["default"].boolValue
            cell.displayUnselectMark = false
            
            _autoHideSeparatorForCell(cell, indexPath: indexPath)
            return cell
        case .catalogue:
            let cell = tableView.dequeueReusableCellWithIdentifier("selectionCatalogueCell", forIndexPath: indexPath) as! SelectionCatalogueTableViewCell
            let currentData = data[indexPath.row]
            
            cell.title = currentData["title"].stringValue
            cell.rawValue = currentData["value"].stringValue
            
            _autoHideSeparatorForCell(cell, indexPath: indexPath)
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch type {
        case .input:
            return
        case .singleItem:
            guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? SelectionSingleItemTableViewCell else {return}
            selectedData["singleItem"] = cell.rawValue
            _saveData()
            if let originViewController = originViewController {
                navigationController?.popToViewController(originViewController, animated: true)
            }
        case .catalogue:
            guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? SelectionCatalogueTableViewCell else {return}
            selectedData["catalogue"] = cell.rawValue
            
            let subSelectionTableVC = Helper.Controller.Selection
            subSelectionTableVC.delegate = self.delegate
            subSelectionTableVC.type = .singleItem
            subSelectionTableVC.originViewController = self.originViewController
            subSelectionTableVC.selectedData = self.selectedData
            subSelectionTableVC.identifier = self.identifier
            subSelectionTableVC.data = data[indexPath.row]["data"]
            
            navigationController?.pushViewController(subSelectionTableVC, animated: true)
            
        }

    }

    private func _autoHideSeparatorForCell(var cell: CustomSeparatorCell, indexPath: NSIndexPath) {
        if indexPath.row + 1 == self.tableView(tableView, numberOfRowsInSection: indexPath.section) {
            cell.displaySeparatorLine = false
        } else {
            cell.displaySeparatorLine = true
        }
    }

    private func _saveData() {
        var updateData: [String: AnyObject] = [String: AnyObject]()
        
        switch type {
        case .input:
            guard let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? SelectionInputTableViewCell else {return}
            updateData = [identifier: cell.textInput.text == nil ? "" : cell.textInput.text!]
        default:
            updateData = selectedData
        }
        
        delegate?.updateSelectionDataForIdentifier(identifier, data: updateData)
    }

}
