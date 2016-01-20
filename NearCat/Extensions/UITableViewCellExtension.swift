//
//  UITableViewCellExtension.swift
//  NearCat
//
//  Created by huchunbo on 16/1/20.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func extension_setDefaultSelectedColor() {
        selectedBackgroundView = UIView(frame: bounds)
        selectedBackgroundView!.backgroundColor = Constant.Color.CellSelected
    }
}