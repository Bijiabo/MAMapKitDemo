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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupViews()
    }

    // MARK: - setup views
    
    private func _setupViews() {
        inputTextField = commentTextField
        inputViewContainer = commentInputViewContainer
        
        _setupNavigationBar()
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
    
    @IBAction func tapSubmitCommentButton(sender: AnyObject) {
        _hideKeyboard()
        
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
    
    private func _hideKeyboard() {
        commentTextField.resignFirstResponder()
        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.view.frame.origin.y = self._defaultViewOriginY
            }, completion: nil)
    }
    

}
