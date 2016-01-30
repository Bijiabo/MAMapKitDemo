//
//  BrowseCollectionViewCell.swift
//  NCPhotoViewer
//
//  Created by huchunbo on 16/1/22.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class BrowseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var footerContainerView: UIView!
    @IBOutlet weak var footerContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectButton: UIButton!
    
    var indexPath: NSIndexPath?
    var browseDelegate: BrowsePhotoDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapCell:")))
    }
    
    func tapCell(sender: UITapGestureRecognizer) {
        browseDelegate?.tapPreviewView()
    }
    
    var width: Int = 0 {
        didSet {
            _updateSizeInformation()
        }
    }
    
    var height: Int = 0 {
        didSet {
            _updateSizeInformation()
        }
    }
    
    private func _updateSizeInformation() {
        // let sizeString: String = "\(width) ✕ \(height)"
        // sizeLabel.text = sizeString
    }
    
    var date: NSDate = NSDate() {
        didSet {
            // let dateFormatter = NSDateFormatter()
            // dateFormatter.dateFormat = "yyyy-dd-MM"
            // dateLabel.text = dateFormatter.stringFromDate(date)
        }
    }
    
    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    
    var displayFooter: Bool = false {
        didSet {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                if self.displayFooter {
                    self.footerContainerView.frame.origin.y = UIScreen.mainScreen().bounds.height - self.footerContainerViewHeight.constant
                    self.footerContainerView.alpha = 1
                } else {
                    self.footerContainerView.frame.origin.y = UIScreen.mainScreen().bounds.height
                    self.footerContainerView.alpha = 0
                }
                
                }) { (finished) -> Void in
                    
            }
        }
    }
    
    @IBAction func tapSelectButton(sender: AnyObject) {
        guard let indexPath = indexPath else {return}
        browseDelegate?.tapSelectButton(indexPath: indexPath)
    }
    
    var select: Bool = false {
        didSet {
            if select {
                selectButton.setImage(UIImage(named: "icon_check photo_50_sel"), forState: UIControlState.Normal)
            } else {
                selectButton.setImage(UIImage(named: "icon_check photo_50_nor"), forState: UIControlState.Normal)
            }
        }
    }
    
}
