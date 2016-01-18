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
    private var _fluxes: JSON = JSON([])
    let downloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .FIFO,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache()
    )
//    let imageCache = AutoPurgingImageCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        _initViews()
        _loadData()
    }
    
    private func _initViews() {
        clearsSelectionOnViewWillAppear = true
        tableView.estimatedRowHeight = 280.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib: UINib = UINib(nibName: "FluxItem", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "fluxItemCell")
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return _fluxes.count
    }
    /*
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let currentData = _fluxes[indexPath.row]
        let pictures = currentData["flux"]["picture"]
        if pictures.count > 0 {
            print("estimatedHeightForRowAtIndexPath")
            return 400.0
        }
        print("estimatedHeightForRowAtIndexPath 200")
        return 280.0
    }
    */

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fluxItemCell", forIndexPath: indexPath) as! FluxesListTableViewCell
        cell.navigationController = navigationController

        let currentData = _fluxes[indexPath.row]
        let fluxData = currentData["flux"]
        let userData = currentData["user"]
        
        cell.content = fluxData["content"].stringValue
        cell.userName = userData["name"].stringValue
        cell.id = fluxData["id"].intValue
        
        // set user's avatar
        let avatarPath: String = userData["avatar"].stringValue
        Helper.setRemoteImageForImageView(cell.avatarImageView, avatarURLString: "\(FConfiguration.sharedInstance.host)\(avatarPath)")
        
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
        
        cell.commentCount = fluxData["comment_count"].intValue
        cell.likeCount = fluxData["like_count"].intValue
        cell.distance = 0
        
        cell.following = userData["following"].boolValue
        
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? FluxesListTableViewCell else {return}
        
        let detailViewController = storyboard?.instantiateViewControllerWithIdentifier("fluxDetail") as! FluxDetailViewController
        detailViewController.id = cell.id
        
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    // MARK: - data functions
    
    private func _loadData() {
        Action.fluxes.list(page: 0) { (success, data, description) -> Void in
            if success {
                self._fluxes = data
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
}
