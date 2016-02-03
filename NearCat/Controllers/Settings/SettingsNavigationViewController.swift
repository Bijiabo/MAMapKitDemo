//
//  SettingsNavigationViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/12.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SettingsNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = Constant.Color.Theme
        navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: Constant.Color.Theme ]
    }
}
