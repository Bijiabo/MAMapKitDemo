//
//  PersonalPageTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/18.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalPageTableViewController: UITableViewController {
    
    var user_id: Int = 0
    var segmentedControlVC: PersonalPageSegmentedControlViewController!

    private var headerBackgroundImageViewOriginalHeight: CGFloat = 0
    private var headerBackgroundImageView: UIImageView? = nil {
        didSet {
            guard let headerBackgroundImageView = headerBackgroundImageView else {return}
            headerBackgroundImageViewOriginalHeight = headerBackgroundImageView.frame.height
        }
    }
    private var headerCell: PersonalSettingHeaderTableViewCell? = nil
    private var _userInformation: JSON = JSON([])
    private var _navigationBarShadowImageViewCache: UIImageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
        _loadUserInformation()
        
        _setupSegmentedControlVC()
    }
    
    private func _initViews() {
        tableView.clipsToBounds = false
        clearsSelectionOnViewWillAppear = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
        
        let nib: UINib = UINib(nibName: "PersonalPage", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "personalPageHeaderCell")
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.backItem?.title = ""
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.leftBarButtonItem?.title = ""
        
    }
    
    private func _setupSegmentedControlVC() {
        segmentedControlVC = Helper.Controller.PersonalPageSegemntedControl
        segmentedControlVC.titles = ["主页", "动态", "猫咪"]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        _updateNavigationBarDisplay(backgroundTransparent: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        _updateNavigationBarDisplay(backgroundTransparent: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 4
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 331.0
            }
            
            return 44.0
            
        case 1:
        return UIScreen.mainScreen().bounds.size.height - self.tableView(tableView, heightForHeaderInSection: 1) - 64.0
        
        default:
        return 44.0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("personalPageHeaderCell", forIndexPath: indexPath) as! PersonalSettingHeaderTableViewCell
                headerBackgroundImageView = cell.backgroundImageView
                headerCell = cell
                
                _clearUserInformation()
                _updateHeaderCellContent()
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("personalPageTagCell", forIndexPath: indexPath) as! PersonalPageTagTableViewCell
                
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("personalPageIntroCell", forIndexPath: indexPath) as! PersonalPageIntroTableViewCell
                return cell
            default: // indexPath.row == 3
                let cell = tableView.dequeueReusableCellWithIdentifier("personalPageLocationCell", forIndexPath: indexPath) as! PersonalPageLocationTableViewCell
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("personalPageScrollContainerCell", forIndexPath: indexPath) as! PersonalPageScrollContainerTableViewCell
            cell.personalPageTVCDelegate = self
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return segmentedControlVC.view
            
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 44.0
        default:
            return 0
        }
    }

    // MARK: - scrollView delegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let headerBackgroundImageOriginY: CGFloat = 700.0
        
        if scrollView.contentOffset.y < 0 {
            //headerBackgroundImageView?.alpha = 1.0
            guard let headerBackgroundImageView = headerBackgroundImageView else {return}
            headerBackgroundImageView.layer.frame.size.height = headerBackgroundImageViewOriginalHeight - scrollView.contentOffset.y
            headerBackgroundImageView.layer.frame.origin.y = scrollView.contentOffset.y + headerBackgroundImageOriginY - 64.0
        } else {
            headerBackgroundImageView?.layer.frame.origin.y = scrollView.contentOffset.y/2 + headerBackgroundImageOriginY - 64.0
            //headerBackgroundImageView?.alpha = 1.0 - scrollView.contentOffset.y/headerBackgroundImageViewOriginalHeight
        }
        
        // update navigation bar display
        
        if scrollView.contentOffset.y <= 200.0 {
            _updateNavigationBarDisplay(backgroundTransparent: true)
        } else {
            _updateNavigationBarDisplay(backgroundTransparent: false)
        }
        
        // segmentedControlView
        
        if
        let segmentedControlView = tableView(tableView, viewForHeaderInSection: 1),
        let containerCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as? PersonalPageScrollContainerTableViewCell
        {
            let segmentedControlViewPosition = segmentedControlView.convertRect(segmentedControlView.bounds, toView: navigationController?.navigationBar)
            
            if segmentedControlViewPosition.origin.y < 45.0 {
                containerCell.verticalScrollEnabled = true
            } else {
                containerCell.verticalScrollEnabled = false
            }
        }
    }
    
    private var _navigationBarBackgroundTransparent: Bool = false
    private func _updateNavigationBarDisplay(backgroundTransparent backgroundTransparent: Bool) {
        if backgroundTransparent == _navigationBarBackgroundTransparent {return}
        guard let navigationBar = navigationController?.navigationBar else {return}
        
        _navigationBarBackgroundTransparent = backgroundTransparent
        
        if backgroundTransparent {
            navigationBar.barTintColor = UIColor.clearColor()
            navigationBar.backgroundColor = UIColor.clearColor()
            navigationBar.setBackgroundImage(UIImage(named: "transparent"), forBarMetrics: UIBarMetrics.Default)
            navigationBar.hideBottomHairline()
            navigationBar.tintColor = UIColor.whiteColor()
            title = ""
        } else {
            guard let navigationBar = navigationController?.navigationBar else {return}
            navigationBar.barTintColor = nil
            navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
            navigationBar.showBottomHairline()
            navigationBar.tintColor = Constant.Color.Theme
            title = _userInformation["name"].stringValue
        }
    }
    
    // MARK: - data functions
    
    private func _loadUserInformation() {
        Action.users.informationFor(userId: user_id) { (success, data, description) -> Void in
            if success {
                self._userInformation = data
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self._updateHeaderCellContent()
                })
            }
        }
    }
    
    private func _updateHeaderCellContent() {
        guard let headerCell = headerCell else {return}
        if FHelper.logged_in {
            let avatarURLString = "\(FConfiguration.sharedInstance.host)\(_userInformation["avatar"].stringValue)"
            Helper.setRemoteImageForImageView(headerCell.avatarImageView, avatarURLString: avatarURLString)
            headerCell.userName = _userInformation["name"].stringValue
            headerCell.thumbCount = _userInformation["thumb_count"].intValue
            headerCell.followingCount = _userInformation["followers_count"].intValue
            headerCell.cats = _userInformation["cats"].arrayValue
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
