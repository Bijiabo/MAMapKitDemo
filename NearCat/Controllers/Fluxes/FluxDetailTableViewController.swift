//
//  FluxDetailTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class FluxDetailTableViewController: UITableViewController {

    var id: Int = 0
    private var _flux: JSON = JSON([])
    private var _comments: JSON = JSON([])
    var containerDelegate: FluxDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        
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
            return _comments.count
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // is for flux detail cell
            let cell = tableView.dequeueReusableCellWithIdentifier("fluxDetailCell", forIndexPath: indexPath) as! FluxDetailTableViewCell
            
            let fluxData = _flux["flux"]
            let userData = _flux["user"]
            cell.userName = userData["name"].stringValue
            cell.content = fluxData["content"].stringValue
            cell.date = fluxData["created_at"].stringValue
            
            // TODO: - update counts
            cell.commentCount = 0
            cell.likeCount = 0
            cell.distance = 0
            
            return cell
            
        default: // section == 1, is for comments
            let cell = tableView.dequeueReusableCellWithIdentifier("fluxCommentCell", forIndexPath: indexPath) as! FluxCommentTableViewCell
            
            let currentCommentData = _comments[indexPath.row]
            let commentData = currentCommentData["comment"]
            let userData = currentCommentData["user"]
            
            let userName = userData["name"].stringValue
            let commentContent = commentData["content"].stringValue
            
            cell.thumbsCount = 0 // TODO: complete this function
            cell.content = "\(userName): \(commentContent)"
            cell.date = commentData["created_at"].stringValue
            
            return cell
            
        }
    }
    
    // MARK: - setup views
    
    private func _setupViews() {
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
                self._comments = data
                
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
