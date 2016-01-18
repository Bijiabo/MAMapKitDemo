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

    private var headerBackgroundImageViewOriginalHeight: CGFloat = 0
    private var headerBackgroundImageView: UIImageView? = nil {
        didSet {
            guard let headerBackgroundImageView = headerBackgroundImageView else {return}
            headerBackgroundImageViewOriginalHeight = headerBackgroundImageView.frame.height
        }
    }
    private var headerCell: PersonalSettingHeaderTableViewCell? = nil
    private var _userInformation: JSON = JSON([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
        _loadUserInformation()
    }
    
    private func _initViews() {
        
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
        return 50
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 280.0
            }
            
            return 44.0
        }
        return 44.0
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
            let cell = UITableViewCell()
            return cell
        }
        
        
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
