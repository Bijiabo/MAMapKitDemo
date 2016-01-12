//
//  FluxesListTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/9.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class FluxesListTableViewController: UITableViewController {
    
    var listType: String = "follow"
    var hideNavigationBar: Bool = true
    private var _fluxes: JSON = JSON([])

    override func viewDidLoad() {
        super.viewDidLoad()

        _initViews()
        _loadData()
    }
    
    private func _initViews() {
        clearsSelectionOnViewWillAppear = true
        tableView.estimatedRowHeight = 280.0
        tableView.rowHeight = UITableViewAutomaticDimension
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


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fluxesListCell", forIndexPath: indexPath) as! FluxesListTableViewCell

        let currentData = _fluxes[indexPath.row]
        cell.content = currentData["flux"]["content"].stringValue
        cell.userName = currentData["user"]["name"].stringValue
        cell.id = currentData["flux"]["id"].intValue
        
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
