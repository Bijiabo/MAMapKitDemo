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
        let lastSectionIndex = numberOfSections > 0 ? numberOfSections - 1 : 0
        let numberOfRowsForLastSection = numberOfRowsInSection(lastSectionIndex)
        let lastRowIndex = numberOfRowsForLastSection > 0 ? numberOfRowsForLastSection - 1 : 0
        let lastIndexPath = NSIndexPath(forRow: lastRowIndex, inSection: lastSectionIndex)
        scrollToRowAtIndexPath(lastIndexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
}