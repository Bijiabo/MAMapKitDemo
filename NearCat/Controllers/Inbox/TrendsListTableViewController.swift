//
//  TrendsListTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON
import Regex

class TrendsListTableViewController: UITableViewController {

    private var _trends: [JSON] = [JSON]()
    
    var page: Int = 1
    var currentPage: Int = 1
    var maxPage: Int = Int.max
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extension_registerLoadingCellNib()
        extension_setupRefreshControl()
        _initViews()
        _loadData()
    }
    
    private func _initViews() {
        clearsSelectionOnViewWillAppear = true
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .None
        
        // setup tableview footer view
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        
        tableView.backgroundColor = Constant.Color.TableViewBackground
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _trends.count + 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section < _trends.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("trendsListCell", forIndexPath: indexPath) as! TrendsListTableViewCell
            let currentData = _trends[indexPath.section]
            
            cell.userName = currentData["from_user"]["name"].stringValue
            cell.date = currentData["created_at"].stringValue
            
            Helper.setRemoteImageForImageView(cell.avatarImageView, imagePath: currentData["from_user"]["avatar"].stringValue)
            
            switch currentData["trends_type"].stringValue {
            case "flux_comment_reply":
                if let picturePath = currentData["flux"]["picture"][0]["path"].string {
                    Helper.setRemoteImageForImageView(cell.previewImageView, imagePath: picturePath)
                } else {
                    cell.previewImageView.image = nil
                }
                cell.action = currentData["flux_comment"]["parentComment_id"].int == nil ? "给你留言: " : "回复你的留言: "
                cell.content = currentData["flux_comment"]["content"].stringValue
                cell.id = currentData["flux"]["id"].intValue
                
            case "flux_comment_thumbs":
                cell.action = currentData["flux"]["picture"].count > 0 ? "赞了你的照片。" : "赞了你的状态。"
                cell.id = currentData["flux"]["id"].intValue
                
            default:
                cell.content = currentData["content"].stringValue
            }
            
            cell.type = currentData["trends_type"].stringValue
            
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
            
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? TrendsListTableViewCell else {return}
        
        switch cell.type {
        case Regex("^flux"):
            let fluxDetailVC = Helper.Controller.FluxDetail
            fluxDetailVC.id = cell.id
            navigationController?.pushViewController(fluxDetailVC, animated: true)
        default:
            break
        }
    }
    
    private func _setLoadingCellStatus(loading loading: Bool) {
        guard let loadingCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as? LoadingTableViewCell else {return}
        loadingCell.loading = loading
    }

    // MARK: - Data functions
    
    func refresh(sender: AnyObject) {
        _loadData(refresh: true)
    }
    
    private func _loadData(refresh refresh: Bool = false) {
        if page >= maxPage {
            self.refreshControl?.endRefreshing()
            return
        }
        
        Action.trends.list(page: page) { (success, data, description) -> Void in
            if success {
                self.refreshControl?.endRefreshing()
                
                self.currentPage = self.page
                
                if data.count == 0 {
                    self.maxPage = self.page
                    self._setLoadingCellStatus(loading: false)
                    return
                }
                
                if refresh {
                    self._trends.removeAll(keepCapacity: false)
                }
                
                self._trends += data.arrayValue
                
                self.extension_reloadTableView()
            } else {
                print(description)
            }
        }
    }
}
