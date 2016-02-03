//
//  AlbumListTableViewCell.swift
//  NCPhotoViewer
//
//  Created by huchunbo on 16/1/21.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import Photos

class AlbumListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewImageView2: UIImageView!
    @IBOutlet weak var previewImageView1: UIImageView!
    @IBOutlet weak var previewImageView0: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var selectedCountLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
    
    var assetCollection: PHAssetCollection?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        previewImageView0.clipsToBounds = true
        previewImageView1.clipsToBounds = true
        previewImageView2.clipsToBounds = true
        
        extension_setDefaultSelectedColor()
        separatorLineView.backgroundColor = Constant.Color.TableViewSeparator
        
        selectedCountLabel.layer.cornerRadius = 10.0
        selectedCountLabel.clipsToBounds = true
        Helper.UI.setLabel(selectedCountLabel, forStyle: Constant.TextStyle.Cell.Small.White)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var title: String = String() {
        didSet {
            titleLabel.text = title
        }
    }
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
        }
    }
    
    var previewImage0: UIImage = UIImage() {
        didSet {
            previewImageView0.image = previewImage0
        }
    }
    
    var previewImage1: UIImage = UIImage() {
        didSet {
            previewImageView1.image = previewImage1
        }
    }
    
    var previewImage2: UIImage = UIImage() {
        didSet {
            previewImageView2.image = previewImage2
        }
    }
    
    var selectedCount: Int = 0 {
        didSet {
            selectedCountLabel.text = "\(selectedCount)"
            
            if selectedCount == 0 {
                selectedCountLabel.hidden = true
            } else {
                selectedCountLabel.hidden = false
            }
        }
    }

}
