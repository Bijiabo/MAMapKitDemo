//
//  LoadingTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/1/17.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingContainerView: UIView!
    var indicatorView: NVActivityIndicatorView!
    @IBOutlet weak var noMoreDataTipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .None
        
        indicatorView = NVActivityIndicatorView(frame: loadingContainerView.bounds, type: NVActivityIndicatorType.BallScaleMultiple, color: Constant.Color.Theme )
        loadingContainerView.addSubview(indicatorView)
        indicatorView.startAnimation()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var loading: Bool = true {
        didSet {
            if loading {
                indicatorView.startAnimation()
                noMoreDataTipLabel.hidden = true
            } else {
                indicatorView.stopAnimation()
                noMoreDataTipLabel.hidden = false
            }
        }
    }

}
