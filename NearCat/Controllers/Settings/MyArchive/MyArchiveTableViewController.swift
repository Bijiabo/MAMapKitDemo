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
            
            Helper.setRemoteImageForImageView(cell.avatarImageView, avatarURLString: "\(FConfiguration.sharedInstance.host)\(userData["avatar"].stringValue)")
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("userArchiveCell", forIndexPath: indexPath) as! MyArchiveSettingItemTableViewCell
            let currentData = listViewData[indexPath.section][indexPath.row]
            let identifier = currentData["identifier"]!
            
            cell.headerTitle = currentData["title"]!
            
            if indexPath.row + 1 == self.tableView(tableView, numberOfRowsInSection: indexPath.section) {
                cell.displaySeparatorLine = false
            } else {
                cell.displaySeparatorLine = true
            }
            
            cell.title = currentData["title"]!
            
            let value = userData[identifier].stringValue
            switch identifier {
            case "gender":
                cell.value = Int(value) == 1 ? "男" : "女"
            case "region":
                cell.value = "\(userData["province"].stringValue) \(userData["city"].stringValue)"
            default:
                cell.value = value
            }
            
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
            selectionVC.title = cell.headerTitle
            
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
    
    func tapAvatar() {
        let actionSheet = KKActionSheet(title: "修改头像", cancelTitle:"取消", cancelAction: { () -> Void in
        })
        
        actionSheet.addButton("拍照", isDestructive: false) { () -> Void in
            let shootVC = Helper.Controller.Shoot
            shootVC.mediaPickerDelegate = self
            self.presentViewController(shootVC, animated: true, completion: nil)
        }
        actionSheet.addButton("从相册中选取", isDestructive: false) { () -> Void in
            if Helper.Ability.Photo.hasAuthorization {
                let mediaPickerNavigationVC = Helper.Controller.MediaPicker
                mediaPickerNavigationVC.mediaPickerDelegate = self
                self.presentViewController(mediaPickerNavigationVC, animated: true, completion: nil)
            } else {
                Helper.Ability.Photo.requestAuthorization(block: { (success) -> Void in
                    if success {
                        let mediaPickerNavigationVC = Helper.Controller.MediaPicker
                        self.presentViewController(mediaPickerNavigationVC, animated: true, completion: nil)
                    } else {
                        Helper.Alert.show(title: "未开启照片访问权限", message: "请打开［设置］-> ［猫邻］-> ［照片］选择开启", animated: true)
                    }
                })
            }
        }
        
        actionSheet.show()
    }
    

    // MARK: - data functions
    
    private func _loadData() {
        Action.users.selfInformation { (success, data, description) -> Void in
            if success {
                self.userData = data
                
                self.extension_reloadTableView()
                
                // load province and city data for the first time
                if self._provinceAndCityData.count == 0 {
                    self._loadProvinceAndCityData()
                }
                
                self._updateDefaultProvinceAndCityData()
            }
        }
    }
    
    private func _loadProvinceAndCityData() {
        let fileURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("Data/ProvinceAndCity.json")
        if let fileData = NSData(contentsOfURL: fileURL) {
            _provinceAndCityData = JSON(data: fileData)
        }
    }
    
    private func _updateDefaultProvinceAndCityData() {
        let defaultProvince = userData["province"].stringValue
        let defaultCity = userData["city"].stringValue
        
        for (key, provinceData): (String, JSON) in _provinceAndCityData {
            if provinceData["value"].stringValue == defaultProvince {
                _provinceAndCityData[Int(key)!]["default"].bool = true
                
                for (key1, cityData): (String,JSON) in provinceData["data"] {
                    if cityData["value"].stringValue == defaultCity {
                        _provinceAndCityData[Int(key)!]["data"][Int(key1)!]["default"].bool = true
                    } else {
                        _provinceAndCityData[Int(key)!]["data"][Int(key1)!]["default"].bool = false
                    }
                }
            } else {
                _provinceAndCityData[Int(key)!]["default"].bool = false
                for (key1, _): (String,JSON) in provinceData["data"] {
                    _provinceAndCityData[Int(key)!]["data"][Int(key1)!]["default"].bool = false
                }
            }
        }
    }
}

// MARK: - extension: SelectionControllerDelegate

extension MyArchiveTableViewController: SelectionControllerDelegate {
    
    func updateSelectionDataForIdentifier(identifier: String, var data: [String : AnyObject]) {
        switch identifier {
        case "region":
            data = [
                "province": data["catalogue"]!,
                "city": data["singleItem"]!
            ]
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
                
                self.extension_reloadTableView()
                
                self._updateDefaultProvinceAndCityData()
            }
        })
    }
}

// MARK: - extension: MediaPickerDelegate

extension MyArchiveTableViewController: MediaPickerDelegate {
    
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
