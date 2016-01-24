//
//  SelectionControllerDelegate.swift
//  NearCat
//
//  Created by huchunbo on 16/1/24.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation

protocol SelectionControllerDelegate {
    func updateSelectionDataForIdentifier(identifier: String, data: [String: AnyObject])
}