//
//  LikeButton.swift
//  NearCat
//
//  Created by huchunbo on 16/2/2.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class LikeButton: UIButton {
    
    var fluxId: Int?
    var fluxCommentId: Int?
    var count: Int = 0 {
        didSet {
            if count < 0 {
                self.setTitle("0", forState: UIControlState.Normal)
                return
            }
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.setTitle("\(self.count)", forState: UIControlState.Normal)
            }
            
        }
    }
    
    var liked: Bool = false {
        didSet {
            let image: UIImage = (liked ? UIImage(named: "home_content_icon_like_sel") : UIImage(named: "home_content_icon_like_nor"))!
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.setImage(image, forState: UIControlState.Normal)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTarget(self, action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: - user action
    
    func tapped(sender: UIButton) {
        guard let fluxId = fluxId else {return}
        
        if liked {
            Action.fluxes.cancelLike(fluxId: fluxId, commentId: fluxCommentId, completeHandler: { (success, description) -> Void in
                if success {
                    self.count -= 1
                } else {
                    self.liked = true
                }
            })
        } else {
            Action.fluxes.like(fluxId: fluxId, commentId: fluxCommentId) { (success, description) -> Void in
                if success {
                    self.count += 1
                } else {
                    self.liked = false
                }
            }
        }
        
        liked = !liked
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
