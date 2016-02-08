//
//  PersonalPageFluxPageTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/2/5.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalPageFluxPageTableViewController: PersonalPageSubPageTableViewController {

    private var _fluxes: [JSON] = [JSON]()
    var page: Int = 1
    var currentPage: Int = 1
    var maxPage: Int = Int.max
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 220.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        tableView.backgroundColor = Constant.Color.TableViewBackground
        
        extension_setupFooterView()
        extension_setupRefreshControl()
        extension_registerLoadingCellNib()
        
        extension_registerCellForNibName("PersonalPageFluxCell", cellReuseIdentifier: "personalPageFluxCell")
    }
    
    private var _hasBeenLoadData: Bool = false
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !_hasBeenLoadData {
            _loadData(refresh: true)
            _hasBeenLoadData = true
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return _fluxes.count
        default:
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("personalPageFluxCell", forIndexPath: indexPath) as! PersonalPageFluxTableViewCell
            
            let fluxData = _fluxes[indexPath.row]
            
            cell.content = fluxData["content"].stringValue
            cell.date = fluxData["created_at"].stringValue
            cell.id = fluxData["id"].intValue
            cell.liked = fluxData["like"].boolValue
            
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
            
            cell.displaySeparatorLineView = indexPath.row + 1 != self.tableView(tableView, numberOfRowsInSection: indexPath.section)
            
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard indexPath.section != 1 else {return}
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? PersonalPageFluxTableViewCell else {return}
        
        let vc = Helper.Controller.FluxDetail
        vc.id = cell.id
        
        Helper.Controller.pushViewController(vc)
    }
    
    // MARK: - data functions
    
    func refresh(sender: AnyObject) {
        _loadData(refresh: true)
    }
    
    private func _loadData(refresh refresh: Bool = false) {
        if page >= maxPage {
            self.refreshControl?.endRefreshing()
            return
        }
        
        guard let userId = parentTVCDelegate?.userId else {return}
        
        Action.fluxes.listForUser(userId: userId, page: refresh ? 1 : page) { (success, data, description) -> Void in
            self.refreshControl?.endRefreshing()
            if success {
                self.currentPage = self.page
                
                if data["flux"].count == 0 {
                    self.maxPage = self.page
                    self._setLoadingCellStatus(loading: false)
                    return
                }
                
                if refresh {
                    self._fluxes.removeAll(keepCapacity: false)
                }
                
                self._fluxes += data["flux"].arrayValue
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
