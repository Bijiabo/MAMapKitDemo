//
//  InputContainerViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/16.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class InputContainerViewController: UIViewController {
    
    private var _defalutKeyboardHeight: CGFloat = 258.0
    
    var inputViewContainer: UIView = UIView()
    var inputTextField: UITextField = UITextField()
    var _bottomForCommentInputContainerView: NSLayoutConstraint = NSLayoutConstraint()
    
    var inputInterfaceTableVC: InputInterfaceTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        _addNotificationObservers()
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        _removeNotificationObservers()
    }
    
    // MARK: - add notification observers
    
    private func _addNotificationObservers() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: Selector("keyboardDidShow:"), name: UIKeyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: Selector("keyboardWillChangeFrame:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification , object: nil)
    }
    
    private func _removeNotificationObservers() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        _updateViewOirginY(_defalutKeyboardHeight)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        _updateViewOirginY(keyboardSize.height)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        let keyboardSize = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        _updateViewOirginY(keyboardSize.height)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        _hideKeyboard()
    }
    
    private func _updateViewOirginY(keyboardHeight: CGFloat) {
        if inputInterfaceTableVC?.shoudTransformView == true {
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                self.view.frame.origin.y = 0 - keyboardHeight
                }, completion: nil)
        } else {
            UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.OverrideInheritedOptions, animations: { () -> Void in
                self._bottomForCommentInputContainerView.constant = keyboardHeight
                self.inputViewContainer.layoutIfNeeded()
                }, completion: nil)
        }
    }

    // MARK: - container delegate
    
    func didBeginScroll() {
        _hideKeyboard()
    }
    
    private func _hideKeyboard() {
        inputTextField.resignFirstResponder()
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.view.frame.origin.y = 0
            self._bottomForCommentInputContainerView.constant = 0
            }, completion: nil)
    }
}
