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
    private var chatTableVC: PrivateMessageChatTableViewController?
    
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
                chatTableVC = targetVC
                targetVC.toUserId = toUserId
                targetVC.containerDelegate = self
                inputInterfaceTableVC = targetVC
            }
        }
    }
    
    // MARK: - user actions
    
    @IBAction func tapSendButton(sender: AnyObject) {
        var content: String = String()
        if let chatContent = chatTextField.text {content = chatContent}
        
        Action.privateMessages.send(toUser: toUserId, content: content, image: nil) { (success, data, description) -> Void in
            if success {
                guard let chatTableVC = self.chatTableVC else {return}
                self.chatTextField.text = nil
                var arrayCache = chatTableVC.chatData.arrayValue
                arrayCache.append(data["data"])
                chatTableVC.chatData = JSON(arrayCache)
                let indexPath = NSIndexPath(forRow: chatTableVC.chatData.count-1, inSection: 0)
                chatTableVC.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                chatTableVC.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            }
        }
    }
    

}
