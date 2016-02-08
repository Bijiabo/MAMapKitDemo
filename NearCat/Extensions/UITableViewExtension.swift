//
//  UITableViewExtension.swift
//  NearCat
//
//  Created by huchunbo on 16/1/17.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//
import UIKit
import Foundation

extension UITableView {
    func scrollToBottom() {
        if numberOfSections == 0 {return}
        let lastSectionIndex = numberOfSections - 1
        
        let numberOfRowsForLastSection = numberOfRowsInSection(lastSectionIndex)
        if numberOfRowsForLastSection == 0 {return}
        let lastRowIndex = numberOfRowsForLastSection - 1
        let lastIndexPath = NSIndexPath(forRow: lastRowIndex, inSection: lastSectionIndex)
        scrollToRowAtIndexPath(lastIndexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
}