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
    private var _defaultViewOriginY: CGFloat = 0
    private var _inputContainerViewOriginY: CGFloat = 0
    
    var inputViewContainer: UIView = UIView()
    var inputTextField: UITextField = UITextField()
    
    var inputInterfaceTableVC: InputInterfaceTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        _defaultViewOriginY = view.frame.origin.y
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        _inputContainerViewOriginY = inputViewContainer.frame.origin.y
        
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
    }
    
    private func _removeNotificationObservers() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
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
    
    private func _updateViewOirginY(keyboardHeight: CGFloat) {
        if inputInterfaceTableVC?.shoudTransformView == true {
            UIView.animateWithDuration(0.05, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.view.frame.origin.y = self._defaultViewOriginY - keyboardHeight
                }, completion: nil)
        } else {
            UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.inputViewContainer.frame.origin.y = self._inputContainerViewOriginY - keyboardHeight
                }, completion: nil)
        }
    }

    // MARK: - container delegate
    
    func didBeginScroll() {
        _hideKeyboard()
    }
    
    private func _hideKeyboard() {
        inputTextField.resignFirstResponder()
        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.view.frame.origin.y = self._defaultViewOriginY
            self.inputViewContainer.frame.origin.y = self._inputContainerViewOriginY
            }, completion: nil)
    }
}
