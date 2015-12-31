//
//  CatArchiveListTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON
import FServiceManager

class CatArchiveListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        _initViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.prompt = "loading..."
        _loadCatData {
            self.navigationItem.prompt = nil
        }
    }
    
    private func _initViews() {
        clearsSelectionOnViewWillAppear = true
        
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        tableView.sendSubviewToBack(refreshControl)
    }
    
    func refresh(sender: UIRefreshControl) {
        _loadCatData {
            sender.endRefreshing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("catItem", forIndexPath: indexPath)
        let currentData = cats[indexPath.row]
        cell.textLabel?.text = currentData["name"].stringValue
        cell.tag = currentData["id"].intValue // as cell's cat id
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (rowAction, indexPath) -> Void in
            guard let cell = self.tableView.cellForRowAtIndexPath(indexPath) else {return}
            Action.cats.destroy(id: "\(cell.tag)") // TODO: - change Action to FAction
            
            self.cats.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        }
        
        return [deleteButton]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // MARK: - data function
    var cats: [JSON] = [JSON]()
    
    private func _loadCatData(completeHandler: ()->Void = {}) {
        Action.cats.mine { (success, data, description) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completeHandler()
            })

            if !success {
                let errorObject: [String: String] = ["title": "读取数据失败", "message": description]
                NSNotificationCenter.defaultCenter().postNotificationName(Constant.Notification.Alert.showError, object: errorObject)
            } else {
                
                self.cats = data.arrayValue
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
    }

    // MARK: - segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let segueIdentifier = segue.identifier else {return}
        switch segueIdentifier {
        case "showDetail":
            if
            let targetCatArchiveDetailController = segue.destinationViewController as? CatArchiveDetailTableViewController,
            let senderCell = sender as? UITableViewCell
            {
                targetCatArchiveDetailController.catId = senderCell.tag
            }
        case "createNewCat":
            if let targetCatArchiveEditController = segue.destinationViewController as? CatArchiveEditTableViewController {
                targetCatArchiveEditController.editMode = CatArchiveEditMode.Create
            }
        default:
            break
        }
    }
}
