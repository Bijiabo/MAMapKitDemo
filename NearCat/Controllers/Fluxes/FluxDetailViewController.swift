//
//  FluxDetailViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/10.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class FluxDetailViewController: UIViewController {

    var id: Int = 0
    private var _defalutKeyboardHeight: CGFloat = 258.0
    private var _defaultViewOriginY: CGFloat = 0
    
    @IBOutlet weak var commentInputViewContainer: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupViews()
        _addNotificationObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - setup views
    
    private func _setupViews() {
        _setupNavigationBar()
        
        _defaultViewOriginY = view.frame.origin.y
    }
    
    private func _setupNavigationBar() {
        title = ""
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: Selector("tapNavigationBarShareButton:")),
            UIBarButtonItem(title: "like", style: UIBarButtonItemStyle.Done, target: self, action: Selector("tapNavigaionBarLikeButton:"))
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
            }
        }
    }
    
    // MARK: - add notification observers
    
    private func _addNotificationObservers() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: Selector("keyboardDidShow:"), name: UIKeyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: Selector("keyboardWillChangeFrame:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.view.frame.origin.y = self._defaultViewOriginY - self._defalutKeyboardHeight
            }, completion: nil)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        
        UIView.animateWithDuration(0.01, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.view.frame.origin.y = self._defaultViewOriginY - keyboardSize.height
            }, completion: nil)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        let keyboardSize = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        
        UIView.animateWithDuration(0.05, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.view.frame.origin.y = self._defaultViewOriginY - keyboardSize.height
            }, completion: nil)
    }
    
    // MARK: - flux detail tableview controller's container delegate
    
    func didBeginScroll() {
        _hideKeyboard()
    }
    
    // MARK: - user actions
    
    @IBAction func tapSubmitCommentButton(sender: AnyObject) {
        _hideKeyboard()
        
        let commentContent = commentTextField.text
        
        // TODO: submit comment data
    }
    
    private func _hideKeyboard() {
        commentTextField.resignFirstResponder()
        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.view.frame.origin.y = self._defaultViewOriginY
            }, completion: nil)
    }
    

}
