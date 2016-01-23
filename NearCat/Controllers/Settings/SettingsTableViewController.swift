//
//  SettingsTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class SettingsTableViewController: UITableViewController, LoginRequesterProtocol {

    private var headerBackgroundImageViewOriginalHeight: CGFloat = 0
    private var headerBackgroundImageView: UIImageView? = nil {
        didSet {
            guard let headerBackgroundImageView = headerBackgroundImageView else {return}
            headerBackgroundImageViewOriginalHeight = headerBackgroundImageView.frame.height
        }
    }
    private var headerCell: PersonalSettingHeaderTableViewCell? = nil
    private var _userInformation: JSON = JSON([])
    private var _alertSheetActive: Bool = false // for background long press action
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
        
        _addNotificationObserver()
        
        _loadUserInformation()
    }
    
    private func _initViews() {
        
        title = "我"
        clearsSelectionOnViewWillAppear = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
        
        // tableView.contentInset.top = 44.0
        
        let nib: UINib = UINib(nibName: "PersonalPage", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "personalPageHeaderCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func _addNotificationObserver() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("logStatusChanged:"), name: FConstant.Notification.FStatus.didLogin , object: nil)
        notificationCenter.addObserver(self, selector: Selector("logStatusChanged:"), name: FConstant.Notification.FStatus.didLogout , object: nil)
    }

    func logStatusChanged(notification: NSNotification) {
        tableView.reloadData()
        
        if FHelper.logged_in {
            _loadUserInformation()
        } else {
            _clearUserInformation()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 280.0
        }
        
        return 44.0
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // TODO: - split logged in or did not logged in
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return FHelper.logged_in ? 3 : 2
        default:
            return 0
        }
    }
    
    private var _cellData = [
        [["id": "settingHeaderCell"]],
        [
            [
                "id": "myArchiveList",
                "title": "我的资料",
                "icon": "set_icon_my_profile",
                
            ],
            [
                "id": "catArchiveList",
                "title": "猫咪资料",
                "icon": "set_icon_cat_archive"
            ],
            [
                "id": "myFollowList",
                "title": "我关注的",
                "icon": "set_icon_following"
            ],
            [
                "id": "myShare",
                "title": "我的分享",
                "icon": "set_icon_my_share"
            ]
        ],
        [
            [
                "id": "settingsList",
                "title": "设置",
                "icon": "set_icon_setting"
            ],
            [
                "id": "feedback",
                "title": "反馈",
                "icon": "set_icon_feedback"
            ],
            [
                "id": "quit",
                "title": "退出",
                "icon": "set_icon_my_share"
            ]
        ]
    ]

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("personalPageHeaderCell", forIndexPath: indexPath) as! PersonalSettingHeaderTableViewCell
            headerBackgroundImageView = cell.backgroundImageView
            headerCell = cell
            cell.delegate = self
            
            _clearUserInformation()
            _updateHeaderCellContent()
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("settingCell", forIndexPath: indexPath) as! SettingListTableViewCell
            let currentData = _cellData[indexPath.section][indexPath.row]
            
            cell.title = currentData["title"]
            
            if let iconName = currentData["icon"] {
                if !iconName.isEmpty {
                    cell.iconImageView.image = UIImage(named: iconName)
                }
            }
            
            if let id = currentData["id"] {
                cell.identifier = id
            }
            
            return cell
        }
        
    }


    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < 2 {return 0}
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44.0))
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }

    // MARK: - table view delegate
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if !FHelper.logged_in {
            _displayNeedLoginAccess()
            return
        }
        
        if indexPath.section == 0 {
            return
        } else {
            guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? SettingListTableViewCell else {return}
            switch cell.identifier {
            case "quit":
                _displayLogoutConfirm()
            case "myShare":
                let vc = storyboard?.instantiateViewControllerWithIdentifier("fluxesList") as! FluxesListTableViewController
                vc.title = "我的分享"
                vc.hideNavigationBar = false
                navigationController?.pushViewController(vc, animated: true)
            default:
                let vc = Helper.Controller.getByStoryboardIdentifier(cell.identifier)
                vc.title = cell.title
                navigationController?.pushViewController(vc, animated: true)
                break
            }
        }
        
    }
    
    private func _displayNeedLoginAccess() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let actionSheet = KKActionSheet(title: "操作需要登录后进行", cancelTitle:"取消", cancelAction: { () -> Void in
            print("取消")
        })
        
        actionSheet.addButton("已有账号", isDestructive: false) { () -> Void in
            notificationCenter.postNotificationName(Constant.Notification.Alert.showLoginTextField, object: self)
        }
        actionSheet.addButton("注册新账号", isDestructive: false) { () -> Void in
            notificationCenter.postNotificationName(Constant.Notification.Alert.showRegisterTextField, object: self)
        }
        
        actionSheet.show()
    }
    
    private func _displayLogoutConfirm() {
        let actionSheet = KKActionSheet(title: "退出后将无法收取该账号的私信和动态通知", cancelTitle:"取消", cancelAction: { () -> Void in
            print("取消")
        })
        
        actionSheet.addButton("确认退出", isDestructive: true) { () -> Void in
            FAction.logout()
        }
        
        actionSheet.show()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            headerBackgroundImageView?.alpha = 1.0
            guard let headerBackgroundImageView = headerBackgroundImageView else {return}
            headerBackgroundImageView.layer.frame.size.height = headerBackgroundImageViewOriginalHeight - scrollView.contentOffset.y
            headerBackgroundImageView.layer.frame.origin.y = scrollView.contentOffset.y
        } else {
            headerBackgroundImageView?.layer.frame.origin.y = scrollView.contentOffset.y/2
            headerBackgroundImageView?.alpha = 1.0 - scrollView.contentOffset.y/headerBackgroundImageViewOriginalHeight
        }

    
    }
    
    // MARK: - LoginRequesterProtocol
    func didLoginSuccess() {
        
    }
    
    func didLoginCancel() {
        
    }
    
    private func _updateHeaderCellContent() {
        guard let headerCell = headerCell else {return}
        if FHelper.logged_in {
            let avatarURLString = "\(FConfiguration.sharedInstance.host)\(FHelper.current_user.avatar)"
            Helper.setRemoteImageForImageView(headerCell.avatarImageView, avatarURLString: avatarURLString)
            headerCell.userName = FHelper.current_user.name
            headerCell.thumbCount = _userInformation["thumb_count"].intValue
            headerCell.followingCount = _userInformation["followers_count"].intValue
            headerCell.cats = _userInformation["cats"].arrayValue
        }
    }
    
    // MARK: - data functions
    
    private func _loadUserInformation() {
        guard FHelper.logged_in else {return}
        Action.users.informationFor(userId: FHelper.current_user.id) { (success, data, description) -> Void in
            if success {
                self._userInformation = data
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self._updateHeaderCellContent()
                })
            }
        }
    }
    
    private func _clearUserInformation() {
        guard let headerCell = headerCell else {return}
        headerCell.userName = "未登录"
        headerCell.thumbCount = 0
        headerCell.followingCount = 0
        headerCell.cats = [JSON(["name":"请登录喵喵喵"])]
        headerCell.avatarImageView.image = nil
    }
}

extension SettingsTableViewController: PersonalSettingHeaderDelegate {
    func tapAvatar() {
        let actionSheet = KKActionSheet(title: "更换头像", cancelTitle:"取消", cancelAction: { () -> Void in
        })
        
        actionSheet.addButton("拍照", isDestructive: false) { () -> Void in
            
        }
        actionSheet.addButton("从相册中选取", isDestructive: false) { () -> Void in
            
        }
        
        actionSheet.show()
    }
    
    func longPressBackgroundImage() {
        let actionSheet = KKActionSheet(title: "更换背景图片", cancelTitle:"取消", cancelAction: { () -> Void in
            self._alertSheetActive = false
        })
        
        actionSheet.dismissBlock = {() in self._alertSheetActive = false}
        
        actionSheet.addButton("拍照", isDestructive: false) { () -> Void in
            
        }
        actionSheet.addButton("从相册中选取", isDestructive: false) { () -> Void in
            
        }
        
        if !_alertSheetActive {
            actionSheet.show()
            _alertSheetActive = true
        }
        
    }
}