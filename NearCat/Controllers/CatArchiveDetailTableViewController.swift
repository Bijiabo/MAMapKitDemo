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
    var listViewData = [
        [
            [
                "title": "头像",
                "value": "",
                "identifier": "avatar"
            ]
        ],
        [
            [
                "title": "名字",
                "value": "",
                "identifier": "name"
            ],
            [
                "title": "年龄",
                "value": "",
                "identifier": "age"
            ],
            [
                "title": "性别",
                "value": "",
                "identifier": "gender"
            ],
            [
                "title": "品种",
                "value": "",
                "identifier": "breed"
            ]
        ],
        [
            [
                "title": "地区",
                "value": "",
                "identifier": "region"
            ]
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
        
        extension_registerCellForNibName("ArchiveListEditableCell", cellReuseIdentifier: "ArchiveListEditableCell")
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
        
        tableView.separatorStyle = .None
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return listViewData.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listViewData.count > section {
            return listViewData[section].count
        } else {
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
            let currentListData = listViewData[indexPath.section][indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("ArchiveListEditableCell", forIndexPath: indexPath) as! ArchiveListEditableTableViewCell
            let currentData = catInformation["archive"][indexPath.row]
            cell.title = currentListData["title"]!
            cell.value = currentData["key"].stringValue == "age" ? "\(currentData["value"].intValue)" : currentData["value"].stringValue
            cell.headerTitle = currentListData["title"]!
            cell.identifier = currentListData["identifier"]!
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
    
    // MARK: - tableView delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 1:
            guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? ArchiveListEditableTableViewCell else {return}
            
            let selectionVC = Helper.Controller.Selection
            selectionVC.delegate = self
            selectionVC.originViewController = self
            selectionVC.identifier = cell.identifier
            selectionVC.title = cell.headerTitle
            selectionVC.type = .input
            
            switch cell.identifier {
            case "name":
                selectionVC.type = .input
                selectionVC.data = JSON([
                    "placeholder": "猫猫名字",
                    "value": cell.value
                    ])
            case "age":
                selectionVC.type = .singleItem
                var index: Int = -1
                let ageLessThanValue: Int = 25
                let ageArray = [Int](count: ageLessThanValue, repeatedValue: 0).map({ (i) -> [String: AnyObject] in
                    index += 1
                    return [
                        "title": "\(index)",
                        "value": "\(index)",
                        "default": cell.value == "\(index)"
                    ]
                })
                
                selectionVC.data = JSON(ageArray)
            case "gender":
                selectionVC.type = .singleItem
                selectionVC.data = JSON([
                    [
                        "title": "女",
                        "value": "0",
                        "default": cell.value == "女"
                    ],
                    [
                        "title": "男",
                        "value": "1",
                        "default": cell.value == "男"
                    ]
                    ])
            case "breed":
                selectionVC.type = .input
                selectionVC.data = JSON([
                    "placeholder": "猫猫品种",
                    "value": cell.value
                    ])
            default:
                break
            }
            
            navigationController?.pushViewController(selectionVC, animated: true)
        default:
            break
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
        case "linkToSelectionVC":
            guard let selectionVC = segue.destinationViewController as? SelectionTableViewController else {return}
            guard let cell = sender as? MyArchiveSettingItemTableViewCell else {return}
            
            selectionVC.delegate = self
            selectionVC.originViewController = self
            selectionVC.identifier = cell.identifier
            selectionVC.title = cell.headerTitle
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

// MARK: - extension: MediaPickerDelegate

extension CatArchiveDetailTableViewController: MediaPickerDelegate {
    
    func newImage(image: UIImage, fromMediaPicker: UIViewController) {
        
        fromMediaPicker.dismissViewControllerAnimated(true) { () -> Void in
            Action.users.updateAvatar(image: image) { (success, description) -> Void in
                if success {
                    self._loadData()
                } else {
                    Helper.Alert.show(title: "修改头像失败", message: "有可能是网络问题，请稍后重试。", animated: true)
                }
            }
        }
        
    }
    
}

extension CatArchiveDetailTableViewController: SelectionControllerDelegate {
    func updateSelectionDataForIdentifier(identifier: String, data: [String : AnyObject]) {
        
    }
}