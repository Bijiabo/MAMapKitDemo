//
//  FluxesListTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class FluxesListTableViewController: UITableViewController {
    
    var listType: String = "follow"
    var hideNavigationBar: Bool = true
    private var _fluxes: [JSON] = [JSON]()
    let downloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .FIFO,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache()
    )
    var page: Int = 1
    var currentPage: Int = 1
    var maxPage: Int = Int.max

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .None
        
        extension_registerLoadingCellNib()
        extension_setupFooterView()
        extension_setupRefreshControl()
        _initViews()
        _loadData(refresh: true)
        
    }
    
    private func _initViews() {
        clearsSelectionOnViewWillAppear = true
        tableView.estimatedRowHeight = 280.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        extension_registerCellForNibName("FluxItem", cellReuseIdentifier: "fluxItemCell")
        
        tableView.tableHeaderView = UIView(frame: CGRectZero)
    }
    
    func refresh(sender: AnyObject) {
        _loadData(refresh: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(hideNavigationBar, animated: true)
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
            return _fluxes.count
        default: // 1
            return 1
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("fluxItemCell", forIndexPath: indexPath) as! FluxesListTableViewCell
            cell.navigationController = navigationController
            
            let currentData = _fluxes[indexPath.row]
            let fluxData = currentData["flux"]
            let userData = currentData["user"]
            
            cell.content = fluxData["content"].stringValue
            cell.userName = userData["name"].stringValue
            cell.date = fluxData["created_at"].stringValue
            cell.id = fluxData["id"].intValue
            cell.liked = fluxData["like"].boolValue
            
            // set user's avatar
            let avatarPath: String = userData["avatar"].stringValue
            Helper.setRemoteImageForImageView(cell.avatarImageView, avatarURLString: "\(FConfiguration.sharedInstance.host)\(avatarPath)")
            
            // set content picture
            let pictures = fluxData["picture"]
            if pictures.count > 0 {
                let currentPicture = pictures[0]
                if currentPicture["height"].floatValue != 0 && currentPicture["width"].floatValue != 0 {
                    let imageHeight = Int( Float(view.frame.width - 48.0) / currentPicture["width"].floatValue * currentPicture["height"].floatValue )
                    cell.contentImageViewHeight.constant = CGFloat(imageHeight)
                }
                let picturePath: String = currentPicture["path"].stringValue
                Helper.setRemoteImageForImageView(cell.contentImageView, avatarURLString: "\(FConfiguration.sharedInstance.host)\(picturePath)")
                
            } else {
                cell.contentImageViewHeight.constant = 0
                cell.contentImageView.image = nil
            }
            
            cell.commentCount = fluxData["comment_count"].intValue
            cell.likeCount = fluxData["like_count"].intValue
            cell.distance = 0
            
            cell.userId = userData["id"].intValue
            cell.following = userData["following"].boolValue
            cell.followActionController = self
            
            return cell

        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("loadMoreCell", forIndexPath: indexPath) as! LoadingTableViewCell
            
            if page < maxPage {
                cell.loading = true
                if currentPage == page {
                    page += 1
                }
                _loadData()
            } else {
                cell.loading = false
            }
            
            return cell
        }
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? FluxesListTableViewCell else {return}
        
        let detailViewController = storyboard?.instantiateViewControllerWithIdentifier("fluxDetail") as! FluxDetailViewController
        detailViewController.id = cell.id
        
        if let tabBarController = tabBarController {
            tabBarController.navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            navigationController?.pushViewController(detailViewController, animated: true)
        }
        
    }
    
    // MARK: - data functions
    
    private func _loadData(refresh refresh: Bool = false) {
        if page >= maxPage {
            self.refreshControl?.endRefreshing()
            return
        }
        Action.fluxes.list(page: refresh ? 1 : page) { (success, data, description) -> Void in
            self.refreshControl?.endRefreshing()
            if success {
                self.currentPage = self.page
                
                if data.count == 0 {
                    self.maxPage = self.page
                    self._setLoadingCellStatus(loading: false)
                    return
                }
                
                if refresh {
                    self._fluxes.removeAll(keepCapacity: false)
                }
                
                self._fluxes += data.arrayValue
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            } else {
                let errorMessage: [String: AnyObject] = [
                    "title": "数据获取失败",
                    "message": "请下拉刷新重试",
                    "animated": true
                ]
                NSNotificationCenter.defaultCenter().postNotificationName(Constant.Notification.Alert.showError, object: errorMessage)
            }
        }
    }
    
    private func _setLoadingCellStatus(loading loading: Bool) {
        guard let loadingCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as? LoadingTableViewCell else {return}
        loadingCell.loading = loading
    }
}

extension FluxesListTableViewController: FollowActionControllerProtocol {
    func follow(userId userId: Int) {
        Action.follow.follow(userId: userId) { (success, description) -> Void in
            if success {
                for (index, value) in self._fluxes.enumerate() {
                    if value["user"]["id"].intValue == userId {
                        self._fluxes[index]["user"]["following"] = true
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func unfollow(userId userId: Int) {
        Action.follow.unfollow(userId: userId)
    }
}
