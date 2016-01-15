//
//  InputInterfaceTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/16.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class InputInterfaceTableViewController: UITableViewController {
    var shoudTransformView: Bool {
        /*
        * if tableView's content is too short, don't move the whole view up. Just move up the inputContainer view.
        */
        
        get {
            let numberOfSections = numberOfSectionsInTableView(tableView)
            if numberOfSections == 0 {return false}
            var lastSectionIndex = numberOfSections - 1
            
            var numberOfRowsInLastSection = tableView(tableView, numberOfRowsInSection: lastSectionIndex)
            if numberOfRowsInLastSection == 0 {
                if lastSectionIndex == 0 {
                    return false
                } else if tableView(tableView, numberOfRowsInSection: lastSectionIndex-1) == 0 {
                    return false
                } else {
                    lastSectionIndex -= 1
                    numberOfRowsInLastSection = tableView(tableView, numberOfRowsInSection: lastSectionIndex)
                }
            }
            let lastRowIndex = numberOfRowsInLastSection - 1
            let indexPathForLastCellInTableView = NSIndexPath(forRow: lastRowIndex, inSection: lastSectionIndex)
            let lastCellInTableView = tableView.cellForRowAtIndexPath(indexPathForLastCellInTableView)
            let lastCellInVisible = tableView.visibleCells.last
            
            if let lastCellInTableView = lastCellInTableView  {
                if lastCellInTableView != lastCellInVisible {
                    return true
                }
                
                let rectForLastCell = tableView.rectForRowAtIndexPath(indexPathForLastCellInTableView)
                let distanceForLastCellToBottom = tableView.frame.height - ( rectForLastCell.origin.y - tableView.contentOffset.y + rectForLastCell.height )
                if distanceForLastCellToBottom > 150 { return false }
            }
            
            return true
        }
    }
}
