//
//  CatArchiveEditTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit
import FServiceManager

enum CatArchiveEditMode {
    case Create
    case Update
}

class CatArchiveEditTableViewController: UITableViewController {

    var editMode: CatArchiveEditMode = .Create
    
    private let dataItemConfig = [
        [
            "title": "name",
            "placeHolder": "enter cat name",
            "key": "name"
        ],
        [
            "title": "age",
            "placeHolder": "1-25",
            "key": "age"
        ],
        [
            "title": "breed",
            "placeHolder": "enter cat breed",
            "key": "breed"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
    }

    private func _initViews() {
        
        title = "Edit Cat"
        
        // table view
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
            cell.key = currentData["key"]!
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
    
    // MARK: - user actions
    @IBAction func tapDoneButton(sender: AnyObject) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        // show loading alert
        let loadingMessage = [
            "title": "创建中",
            "message": "正在通讯",
            "animated": true
        ]
        notificationCenter.postNotificationName(Constant.Notification.Alert.showLoading, object: loadingMessage)
        
        // prepare cat's data
        var catInformation = getCatInformation()
        let age: Int = Int(catInformation["age"]!) == nil ? 0 : Int(catInformation["age"]!)!
        
        let editCompleteHandler: (success: Bool, description: String) -> Void = {
            (success, description) -> Void in
            // hide loading alert
            notificationCenter.postNotificationName(Constant.Notification.Alert.hideLoading, object: nil)
            
            if success {
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    // TODO: - need to reload next view controller (which need to display next)
                    self.navigationController?.popViewControllerAnimated(true)
                })
            } else {
                let errorMessageObject = [
                    "title": "Error",
                    "message": description,
                    "animated": true
                ]
                notificationCenter.postNotificationName(Constant.Notification.Alert.showError, object: errorMessageObject)
            }
        }
        
        // TODO: - need to update FServicemanager to fix request path bug
        switch editMode {
        case .Create:
            FAction.cats.create(catInformation["name"]!, age: age, breed: catInformation["breed"]!, completeHandler: editCompleteHandler)
        default: // -> .Update
            // TODO: - need add update cat archive function to FServceManager framework
            print("")
        }
    }
    
    // MARK: - data functions
    private func getCatInformation() -> [String: String] {
        var catInformation: [String: String] = [String: String]()
        for i in 0..<dataItemConfig.count {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 1)) as? CatArchiveItemTableViewCell {
                catInformation[cell.key] = cell.textField.text!
            }
            
        }
        
        return catInformation
    }

}
