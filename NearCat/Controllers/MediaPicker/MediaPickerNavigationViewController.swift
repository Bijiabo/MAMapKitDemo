//
//  MediaPickerNavigationViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/24.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class MediaPickerNavigationViewController: UINavigationController {

    var mediaPickerDelegate: MediaPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let albumListTVC = topViewController as? AlbumListTableViewController {
            albumListTVC.mediaPickerDelegate = self.mediaPickerDelegate
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
