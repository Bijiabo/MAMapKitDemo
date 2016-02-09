//
//  NotificationListTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON
import SafariServices

class NotificationListTableViewController: UITableViewController {

    var data: [JSON] = [JSON]()
    var page: Int = 1
    var currentPage: Int = 1
    var maxPage: Int = Int.max
    
    override func viewDidLoad() {
        super.viewDidLoad()

        extension_registerLoadingCellNib()
        extension_setupRefreshControl()
        extension_setupFooterView()
        
        _initViews()
        _loadData(refresh: true)
    }
    
    private func _initViews() {
        clearsSelectionOnViewWillAppear = true
        
        // setup tableview footer view
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsets(top: 64.0, left: 0, bottom: 50.0, right: 0)
    }
    
    func refresh(sender: AnyObject) {
        _loadData(refresh: true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count + 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 272.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section < data.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("notificationListCell", forIndexPath: indexPath) as! NotificationListTableViewCell
            let currentData = data[indexPath.section]
            cell.title = currentData["title"].stringValue
            
            var content: NSString = NSString(string: currentData["markdown"].stringValue)
            if content.length > 50 {
                content = content.substringWithRange(NSMakeRange(0, 44))
                content = content.stringByAppendingString("......")
            }
            cell.content = content as String
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.dateFromString(currentData["published_at"].stringValue) {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                cell.date = dateFormatter.stringFromDate(date)
            }
            
            
            if let imagePath = currentData["image"].string {
                Helper.setRemoteImageForImageView(cell.headerImageView, avatarURLString: "\(GhostAPI.sharedInstance.host)/\(imagePath)")
            } else {
                cell.headerImageView.image = nil
            }
            
            return cell
        } else {
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
            
            cell.backgroundColor = Constant.Color.TableViewBackground
            cell.loadingContainerView.backgroundColor = Constant.Color.TableViewBackground
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == data.count {return}
        
        let urlString = "\(GhostAPI.sharedInstance.host)/\(data[indexPath.section]["url"].stringValue)"
        
        if #available(iOS 9.0, *) {
            let url: NSURL = NSURL(string: urlString)!
            let svc = SFSafariViewController(URL: url)
            self.presentViewController(svc, animated: true, completion: nil)
        } else {
            let webVC = storyboard?.instantiateViewControllerWithIdentifier("webVC") as! WebBrowserViewController
            webVC.uri = urlString
            self.presentViewController(webVC, animated: true, completion: nil)
        }
        
    }
    
    private func _setLoadingCellStatus(loading loading: Bool) {
        guard let loadingCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: data.count, inSection: 0)) as? LoadingTableViewCell else {return}
        loadingCell.loading = loading
    }

    // MARK: - data function
    
    private func _loadData(refresh refresh: Bool = false) {
        
        GhostAPI.sharedInstance.posts(page: page) { (success, data) -> Void in
            if success {
                
                self.currentPage = self.page
                
                if data["posts"].count == 0 {
                    self.maxPage = self.page
                    self._setLoadingCellStatus(loading: false)
                    return
                }
                
                if refresh {
                    self.data.removeAll(keepCapacity: false)
                }
                
                self.data += data["posts"].arrayValue
                self.extension_reloadTableView()
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
