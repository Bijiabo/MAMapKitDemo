//
//  PrivateMessageChatContainerViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/16.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PrivateMessageChatContainerViewController: InputContainerViewController {

    var toUserId: Int = 0
    
    private var _defalutKeyboardHeight: CGFloat = 258.0
    private var _defaultViewOriginY: CGFloat = 0
    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var chatSendButton: UIButton!
    @IBOutlet weak var chatInputContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupViews()
    }
    
    private func _setupViews() {
        inputTextField = chatTextField
        inputViewContainer = chatInputContainerView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedChatView" {
            if let targetVC = segue.destinationViewController as? PrivateMessageChatTableViewController
            {
                targetVC.toUserId = toUserId
                targetVC.containerDelegate = self
                inputInterfaceTableVC = targetVC
            }
        }
    }

}
