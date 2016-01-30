//
//  MediaPickerNavigationViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/24.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

enum MediaPickerSelectMode {
    case single
    case multiple
}

class MediaPickerNavigationViewController: UINavigationController {

    var mediaPickerDelegate: MediaPickerDelegate?
    var selectedImages: [UIImage] = [UIImage]()
    var selectMaximum: Int = 9
    var selectMode: MediaPickerSelectMode = .single
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let albumListTVC = topViewController as? AlbumListTableViewController {
            albumListTVC.mediaPickerDelegate = self.mediaPickerDelegate
            albumListTVC.selectMaximum = selectMaximum
            albumListTVC.selectMode = selectMode
        }
    }

    func addSelectedImage(image: UIImage) -> Bool {
        if !selectedImages.contains(image) {
            selectedImages.append(image)
            return true
        }
        return false
    }
    
    func removeSelectedImage(image: UIImage) -> Bool {
        if let index = selectedImages.indexOf(image) {
            selectedImages.removeAtIndex(index)
            return true
        }
        return false
    }

}
