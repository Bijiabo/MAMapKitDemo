//
//  FluxDetailTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class FluxDetailTableViewController: InputInterfaceTableViewController {

    var id: Int = 0
    private var _flux: JSON = JSON([])
    var comments: JSON = JSON([])
    var containerDelegate: InputContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupViews()
        _loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        default: // 1
            return comments.count
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // is for flux detail cell
            let cell = tableView.dequeueReusableCellWithIdentifier("fluxItemCell", forIndexPath: indexPath) as! FluxesListTableViewCell
            cell.navigationController = navigationController
            
            let fluxData = _flux["flux"]
            let userData = _flux["user"]
            cell.userName = userData["name"].stringValue
            cell.content = fluxData["content"].stringValue
            cell.date = fluxData["created_at"].stringValue
            
            // set content picture
            let pictures = fluxData["picture"]
            if pictures.count > 0 {
                let currentPicture = pictures[0]
                if currentPicture["height"].floatValue != 0 {
                    let imageHeight = Int( Float(view.frame.width - 16.0) / currentPicture["width"].floatValue * currentPicture["height"].floatValue )
                    cell.contentImageViewHeight.constant = CGFloat(imageHeight)
                }
                let picturePath: String = currentPicture["path"].stringValue
                Helper.setRemoteImageForImageView(cell.contentImageView, avatarURLString: "\(FConfiguration.sharedInstance.host)\(picturePath)")
                
            } else {
                cell.contentImageViewHeight.constant = 0
                cell.contentImageView.image = nil
            }
            
            // TODO: - update counts
            cell.commentCount = fluxData["comment_count"].intValue
            cell.likeCount = fluxData["like_count"].intValue
            cell.distance = 0
            
            cell.following = userData["following"].boolValue
            
            let avatarPath: String = userData["avatar"].stringValue
            Helper.setRemoteImageForImageView(cell.avatarImageView, avatarURLString: "\(FConfiguration.sharedInstance.host)\(avatarPath)")
            
            cell.selectionStyle = .None
            
            return cell
            
        default: // section == 1, is for comments
            let cell = tableView.dequeueReusableCellWithIdentifier("fluxCommentCell", forIndexPath: indexPath) as! FluxCommentTableViewCell
            
            let currentCommentData = comments[indexPath.row]
            let commentData = currentCommentData["comment"]
            let userData = currentCommentData["user"]
            let parentCommentData = currentCommentData["parent_comment"]["comment"]
            let parentCommentUserData = currentCommentData["parent_comment"]["user"]
            
            let userName = userData["name"].stringValue
            let commentContent = commentData["content"].stringValue
            
            cell.thumbsCount = 0 // TODO: complete this function
            if parentCommentData.isExists() && parentCommentUserData.isExists() {
                cell.content = "\(userName) 回复 \(parentCommentUserData["name"].stringValue): \(commentContent)"
            } else {
                cell.content = "\(userName): \(commentContent)"
            }
            
            cell.date = commentData["created_at"].stringValue
            cell.id = commentData["id"].intValue
            Helper.setRemoteImageForImageView(cell.avatarImageView, avatarURLString: "\(FConfiguration.sharedInstance.host)\(userData["avatar"].stringValue)")
            
            return cell
            
        }
    }
    
    // MARK: - table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            guard let containerVC = containerDelegate as? FluxDetailViewController else {return}
            guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? FluxCommentTableViewCell else {return}
            containerVC.parementCommentId = cell.id
        }
    }
    
    // MARK: - setup views
    
    private func _setupViews() {
        clearsSelectionOnViewWillAppear = true
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib: UINib = UINib(nibName: "FluxItem", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "fluxItemCell")
    }


    // MARK: - data functions
    
    private func _loadData() {
        _loadFluxData()
        _loadCommentData()
    }
    
    private func _loadFluxData() {
        Action.fluxes.detail(id: String(id) ) { (success, data, description) -> Void in
            if success {
                self._flux = data
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            } else {
                self._showErrorAlert(title: "数据获取失败")
            }
        }
    }
    
    private func _loadCommentData() {
        Action.fluxes.comments(id: String(id) ) { (success, data, description) -> Void in
            if success {
                self.comments = data
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            } else {
                self._showErrorAlert(title: "评论获取失败")
            }
        }
    }
    
    private func _showErrorAlert(title title: String = "数据获取失败") {
        let errorMessage: [String: AnyObject] = [
        "title": title,
        "message": "请下拉刷新重试",
        "animated": true
        ]
        NSNotificationCenter.defaultCenter().postNotificationName(Constant.Notification.Alert.showError, object: errorMessage)
    }
    
    // MARK: - scroll view delegate
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        containerDelegate?.didBeginScroll()
    }

}
