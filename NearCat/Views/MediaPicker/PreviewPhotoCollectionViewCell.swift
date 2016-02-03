//
//  PreviewPhotoCollectionViewCell.swift
//  NCPhotoViewer
//
//  Created by huchunbo on 16/1/21.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PreviewPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    
    var indexPath: NSIndexPath?
    var delegate: PreviewCollectionViewController?
    
    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    
    @IBAction func tapSelectButton(sender: AnyObject) {
        guard let indexPath = indexPath else {return}
        delegate?.tapSelectButton(indexPath: indexPath)
    }
    
    var select: Bool = false {
        didSet {
            if select {
                selectButton.setImage(UIImage(named: "icon_check photo_sel"), forState: UIControlState.Normal)
            } else {
                selectButton.setImage(UIImage(named: "icon_check photo_nor"), forState: UIControlState.Normal)
            }
        }
    }
}
