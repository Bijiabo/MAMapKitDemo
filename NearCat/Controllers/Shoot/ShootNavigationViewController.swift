//
//  ShootNavigationViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/24.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class ShootNavigationViewController: UINavigationController {

    var mediaPickerDelegate: MediaPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let shootVC = topViewController as? ShootViewController {
            shootVC.delegate = mediaPickerDelegate
        }
    }
}
