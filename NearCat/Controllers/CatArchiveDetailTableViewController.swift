//
//  CatArchiveDetailTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class CatArchiveDetailTableViewController: UITableViewController {

    var catInformation: JSON = JSON([])
    var catId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        _loadData()
    }
    
    private func _initViews() {
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
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
            return catInformation["archive"].count
        case 2:
            return 1
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
        case 2:
            return 300
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
            let currentData = catInformation["archive"][indexPath.row]
            cell.titleLabel.text = currentData["title"].string
            cell.contentLabel.text = currentData["key"].string == "age" ? "\(currentData["value"].intValue)" : currentData["value"].string
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("map", forIndexPath: indexPath) as! CatArchiveDetailMapTableViewCell
            cell.delegate = self
            
            let currentData = catInformation["catData"]
            cell.catName = currentData["name"].stringValue
            cell.catAge = currentData["age"].intValue
            if
            let _ = catInformation["catData"]["latitude"].string,
            let _ = catInformation["catData"]["longitude"].string,
            let latitude = Double(catInformation["catData"]["latitude"].stringValue),
            let longitude = Double(catInformation["catData"]["longitude"].stringValue)
            {
                cell.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let segueIdentifier = segue.identifier else {return}
        switch segueIdentifier {
        case "editCat":
            if let targetCatArchiveEditController = segue.destinationViewController as? CatArchiveEditTableViewController {
                targetCatArchiveEditController.editMode = CatArchiveEditMode.Update
                targetCatArchiveEditController.catId = catId
            }
        default:
            break
        }
    }
    
    // MARK: - data functions
    private func _loadData() {
        _showLoading()
        Action.cats.getById(catId) { (success, data, description) -> Void in
            self._hideLoading()
            if success {
                self.catInformation = data
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            } else {
                let errorMessage: [String: AnyObject] = [
                    "title": "Error",
                    "message": description,
                    "animated": true
                ]
                NSNotificationCenter.defaultCenter().postNotificationName(Constant.Notification.Alert.showError, object: errorMessage)
            }
        }
    }
    
    private func _showLoading() {
        navigationItem.prompt = "loading..."
    }
    
    private func _hideLoading() {
        navigationItem.prompt = nil
    }
}
