//
//  SettingSecondaryTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/12.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class SettingSecondaryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
