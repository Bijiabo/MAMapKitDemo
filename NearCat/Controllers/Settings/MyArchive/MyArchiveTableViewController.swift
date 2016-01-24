//
//  MyArchiveTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/12.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyArchiveTableViewController: SettingSecondaryTableViewController {
    
    var userData: JSON = JSON([])
    private var _provinceAndCityData: JSON = JSON([])
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
                "title": "登录邮箱",
                "value": "",
                "identifier": "email"
            ],
            [
                "title": "昵称",
                "value": "",
                "identifier": "name"
            ],
            [
                "title": "性别",
                "value": "",
                "identifier": "gender"
            ]
        ],
        [
            [
                "title": "地区",
                "value": "",
                "identifier": "region"
            ],
            [
                "title": "说明",
                "value": "",
                "identifier": "introduction"
            ]
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的资料"
        
        tableView.separatorStyle = .None
        tableView.backgroundColor = Constant.Color.TableViewBackground
        clearsSelectionOnViewWillAppear = true
        
        extension_setupFooterView()
        
        _loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        _loadProvinceAndCityData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return listViewData.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listViewData.count > section {
            return listViewData[section].count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 148.0
        default:
            return 48.0
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 36.0
        }
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Constant.Color.TableViewBackground
        return view
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("myArchiveSettingAvatarCell", forIndexPath: indexPath) as! MyArchiveSettingAvatarTableViewCell
            cell.delegate = self
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("userArchiveCell", forIndexPath: indexPath) as! MyArchiveSettingItemTableViewCell
            let currentData = listViewData[indexPath.section][indexPath.row]
            let identifier = currentData["identifier"]!
            
            if indexPath.row + 1 == self.tableView(tableView, numberOfRowsInSection: indexPath.section) {
                cell.displaySeparatorLine = false
            } else {
                cell.displaySeparatorLine = true
            }
            
            cell.title = currentData["title"]!
            let value = userData[identifier].stringValue
            cell.value = identifier == "gender" ? (Int(value) == 1 ? "男" : "女") : value
            cell.identifier = identifier
            
            return cell
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let segueIdentifier = segue.identifier else {return}
        
        switch segueIdentifier {
        case "linkToSelectionVC":
            guard let selectionVC = segue.destinationViewController as? SelectionTableViewController else {return}
            guard let cell = sender as? MyArchiveSettingItemTableViewCell else {return}
            
            selectionVC.delegate = self
            selectionVC.originViewController = self
            selectionVC.identifier = cell.identifier
            
            switch cell.identifier {
            case "email":
                selectionVC.type = .input
                selectionVC.data = JSON([
                    "placeholder": "您的电子邮件地址",
                    "value": cell.value
                    ])
            case "name":
                selectionVC.type = .input
                selectionVC.data = JSON([
                    "placeholder": "昵称",
                    "value": cell.value
                    ])
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
            case "region":
                selectionVC.type = .catalogue
                selectionVC.data = _provinceAndCityData
            case "introduction":
                selectionVC.type = .input
                selectionVC.data = JSON([
                    "placeholder": "一句话简介",
                    "value": cell.value
                    ])
            default:
                break
            }
            
        default:
            break
        }
    }
    
    private func _reloadTableView() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    func tapAvatar() {
        let actionSheet = KKActionSheet(title: "修改头像", cancelTitle:"取消", cancelAction: { () -> Void in
        })
        
        actionSheet.addButton("拍照", isDestructive: false) { () -> Void in
            let shootVC = Helper.Controller.Shoot
            self.presentViewController(shootVC, animated: true, completion: nil)
        }
        actionSheet.addButton("从相册中选取", isDestructive: false) { () -> Void in
            let mediaPickerNavigationVC = Helper.Controller.MediaPicker
            self.presentViewController(mediaPickerNavigationVC, animated: true, completion: nil)
        }
        
        actionSheet.show()
    }
    

    // MARK: - data functions
    
    private func _loadData() {
        Action.users.selfInformation { (success, data, description) -> Void in
            if success {
                self.userData = data
                
                self._reloadTableView()
            }
        }
    }
    
    private func _loadProvinceAndCityData() {
        let fileURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("Data/ProvinceAndCity.json")
        if let fileData = NSData(contentsOfURL: fileURL) {
            _provinceAndCityData = JSON(data: fileData)
        }
    }
}

extension MyArchiveTableViewController: SelectionControllerDelegate {
    
    func updateSelectionDataForIdentifier(identifier: String, var data: [String : AnyObject]) {
        switch identifier {
        case "region":
            print(data)
        default:
            if data.count == 1 {
                let dataFirstItem: (key: String, value: AnyObject) = data.first!
                if dataFirstItem.key == "singleItem" {
                    data = [identifier: dataFirstItem.value]
                }
            }
        }
        
        
        Action.users.updateSelfInformation(data: data, completeHandler: { (success, data, description) -> Void in
            if success {
                self.userData = data
                
                self._reloadTableView()
            }
        })
    }
    
}
