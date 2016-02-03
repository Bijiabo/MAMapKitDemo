//
//  FluxDetailViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/10.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

class FluxDetailViewController: InputContainerViewController {

    var id: Int = 0
    private var _defalutKeyboardHeight: CGFloat = 258.0
    private var _defaultViewOriginY: CGFloat = 0
    
    @IBOutlet weak var commentInputViewContainer: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var bottomForCommentInputContainerView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupViews()
    }

    
    // MARK: - setup views
    
    private func _setupViews() {
        inputTextField = commentTextField
        inputViewContainer = commentInputViewContainer
        _bottomForCommentInputContainerView = bottomForCommentInputContainerView
        
        _setupNavigationBar()
        
        commentInputViewContainer.backgroundColor = Constant.Color.G6
        commentInputViewContainer.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        commentInputViewContainer.layer.shadowColor = Constant.Color.G5.CGColor
        commentInputViewContainer.layer.shadowOpacity = 1.0
        commentInputViewContainer.layer.shadowRadius = 0
        
        commentTextField.clipsToBounds = true
        commentTextField.layer.cornerRadius = 18.0
        commentTextField.borderStyle = .None
        commentTextField.backgroundColor = UIColor.whiteColor()
        commentTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 6))
        commentTextField.leftViewMode = .Always
        commentTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 6))
        commentTextField.rightViewMode = .Always
        commentTextField.returnKeyType = .Send
        commentTextField.delegate = self
        commentTextField.addTarget(self, action: Selector("tapTextFieldSendButton:"), forControlEvents: UIControlEvents.EditingDidEndOnExit)
    }
    
    private func _setupNavigationBar() {
        title = ""
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "nav_icon_share_nor"), style: UIBarButtonItemStyle.Done, target: self, action: Selector("tapNavigationBarShareButton:")),
            UIBarButtonItem(image: UIImage(named: "nav_icon_like_nor"), style: UIBarButtonItemStyle.Done, target: self, action: Selector("tapNavigaionBarLikeButton:"))
        ]
        
        // custom back button text
        self.navigationController!.navigationBar.topItem!.title = ""
    }
    
    // MARK: - user actions
    
    func tapNavigaionBarLikeButton(sender: UIBarButtonItem) {
        // TODO: complete function
    }
    
    func tapNavigationBarShareButton(sender: UIBarButtonItem) {
        // TODO: complete function
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailContainerSegue" {
            if let detailTableViewController = segue.destinationViewController as? FluxDetailTableViewController {
                detailTableViewController.id = id
                detailTableViewController.containerDelegate = self
                inputInterfaceTableVC = detailTableViewController
            }
        }
    }
    
    // MARK: - user actions
    
    var parementCommentId: Int? = nil {
        didSet {
            guard let _ = parementCommentId else {return}
            commentTextField.becomeFirstResponder()
        }
    }
    
    private func _hideKeyboard() {
        commentTextField.resignFirstResponder()
        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.view.frame.origin.y = self._defaultViewOriginY
            }, completion: nil)
    }
    

}

// MARK: - textField delegate

extension FluxDetailViewController: UITextFieldDelegate {
    
    func tapTextFieldSendButton(sedner: UITextField) {
        guard let commentContent = commentTextField.text else {return}
        
        Action.fluxes.createComment(content: commentContent, fluxId: id, parentCommentId: parementCommentId) { (success, data, description) -> Void in
            if success {
                guard let fluxDetailVC = self.inputInterfaceTableVC as? FluxDetailTableViewController else {return}
                self.commentTextField.text = nil
                var arrayCache = fluxDetailVC.comments.arrayValue
                arrayCache.append(data)
                fluxDetailVC.comments = JSON(arrayCache)
                let indexPath = NSIndexPath(forRow: fluxDetailVC.comments.count-1, inSection: 1)
                fluxDetailVC.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                fluxDetailVC.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            }
        }
    }
    
}