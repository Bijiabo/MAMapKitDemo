//
//  MainRootViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/26.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit
import FServiceManager

class MainRootViewController: UIViewController {

    private var loadingAlertController: UIAlertController?
    private var hideLoadingAlertCompleteHandlerCache: ()->Void = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotiicationObservers()
    }
    
    func addNotiicationObservers() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        for (key, notificationName): (String, String) in Constant.Notification.Alert.Dictionary {
            notificationCenter.addObserver(self, selector: Selector("\(key):"), name: notificationName, object: nil)
        }
    }

}

// MARK: - NotificationAlertObserverProtocol
extension MainRootViewController: NotificationAlertObserverProtocol {
    
    func showLoginTextField(notification: NSNotification) {
        if let requester = notification.object as? LoginRequesterProtocol {
            showLoginAlert(
                successHandler: { () -> Void in
                    requester.didLoginSuccess()
                },
                cancelHandler: { () -> Void in
                    requester.didLoginCancel()
                }
            )
        } else {
            showLoginAlert(successHandler: nil, cancelHandler: nil)
        }
        
    }
    
    func showLoading(notification: NSNotification) {
        var title: String = "Loading"
        var message: String? = nil
        var animated: Bool = false
        if let object = notification.object as? [String: AnyObject] {
            if let objectTitle = object["title"] as? String { title = objectTitle }
            if let objectMessage = object["message"] as? String {message = objectMessage }
            if let objectAnimated = object["animated"] as? Bool { animated = objectAnimated}
        }
        showLoadingAlert(title: title, message: message, animated: animated)
    }
    
    func hideLoading(notification: NSNotification) {
        hideLoadingAlert()
    }
    
    func showError(notification: NSNotification) {
        guard let object = notification.object as? [String: String] else {return}
        if let title = object["title"] {
            showErrorAlert(title: title, message: object["message"])
        } else {
            showErrorAlert(message: object["message"])
        }
    }
    
    /**
     private show alert functions
     */
    
    private func showLoginAlert(successHandler successHandler: (()->Void)?, cancelHandler: (()->Void)? ) {
        let alert = UIAlertController(title: "登陆", message: "部分功能登陆后启用", preferredStyle: UIAlertControllerStyle.Alert)
        
        addTextFieldToAlertController(alert, tag: 0, placeholder: "email", secureTextEntry: false)
        addTextFieldToAlertController(alert, tag: 1, placeholder: "password", secureTextEntry: true)
        
        // define cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            cancelHandler?()
        })
        
        // define login button
        let loginActionHandler: ((UIAlertAction) -> Void) = { (action: UIAlertAction) -> Void in
            // show loading alert
            self.showLoadingAlert(title: "Login...", message: nil)
            
            // get email and password
            var email: String = String()
            var password: String = String()
            for textField in alert.textFields! {
                switch textField.tag {
                case 0:
                    email = self.valueForTextField(textField)
                default: // 1
                    password = self.valueForTextField(textField)
                }
            }
            
            // send login request to server
            FAction.login(email, password: password, completeHandler: { (success, description) -> Void in
                if !success {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.hideLoadingAlert()
                        self.showErrorAlert(title: "Login Error", message: description, closeHandler: { () -> Void in
                            for textField in alert.textFields! {
                                if textField.tag == 1 { textField.text = String() }
                            }
                            // TODO: - need to be simplified and picked up
                            self.presentViewController(alert, animated: true, completion: { () -> Void in
                                for textField in alert.textFields! {
                                    if textField.tag == 1 && !email.isEmpty { textField.becomeFirstResponder() }
                                }
                            })
                        })
                    })
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.hideLoadingAlert()
                        successHandler?()
                    })
                }
            })
        }
        let loginAction = UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: loginActionHandler)
        
        // define show register alert button
        let switchToRegisterAlertActionHandler: ((UIAlertAction) -> Void) = { (action: UIAlertAction) -> Void in
            self.showRegisterAlert(successHandler: successHandler, cancelHandler: cancelHandler)
        }
        let switchToRegisterAlertAction: UIAlertAction = UIAlertAction(title: "Register", style: UIAlertActionStyle.Default, handler: switchToRegisterAlertActionHandler)
        
        // add action buttons
        alert.addAction(loginAction)
        alert.addAction(switchToRegisterAlertAction)
        alert.addAction(cancelAction)
        
        switchPresentViewControllerTo(alert)
    }
    
    private func showRegisterAlert(successHandler successHandler: (()->Void)?, cancelHandler: (()->Void)? ) {
        // TODO: - show register alert
        let alert = UIAlertController(title: "Register", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        addTextFieldToAlertController(alert, tag: 0, placeholder: "email", secureTextEntry: false)
        addTextFieldToAlertController(alert, tag: 1, placeholder: "name", secureTextEntry: false)
        addTextFieldToAlertController(alert, tag: 2, placeholder: "password", secureTextEntry: true)
        
        // define cancel action
        let cancelActionHandler: ((UIAlertAction) -> Void) = { (action: UIAlertAction) -> Void in
            cancelHandler?()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: cancelActionHandler)
        
        // define register action
        let registerActionHandler: ((UIAlertAction) -> Void) = { (action: UIAlertAction) -> Void in
            // TODO: - add register statements
            var email: String = String()
            var name: String = String()
            var password: String = String()
            for textField in alert.textFields! {
                switch textField.tag {
                case 0:
                    email = self.valueForTextField(textField)
                case 1:
                    name = self.valueForTextField(textField)
                default: // 2
                    password = self.valueForTextField(textField)
                }
            }
            
            FAction.register(email, name: name, password: password, completeHandler: { (success, description) -> Void in
                if success {
                    successHandler?()
                } else {
                    // TODO: - need to show error alert, and re-display regisnter alert (again...)
                    alert.message = "description: \(description)" // does not display
                    self.switchPresentViewControllerTo(alert)
                }
                
            })

        }
        let registerAction: UIAlertAction = UIAlertAction(title: "Register", style: UIAlertActionStyle.Default, handler: registerActionHandler)
        
        // define switch to login action
        let switchToLoginActionHandler: ((UIAlertAction) -> Void) = { (action: UIAlertAction) -> Void in
            self.showLoginAlert(successHandler: successHandler, cancelHandler: cancelHandler)
        }
        let switchToLoginAction: UIAlertAction = UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: switchToLoginActionHandler)
        
        // add actions
        alert.addAction(registerAction)
        alert.addAction(switchToLoginAction)
        alert.addAction(cancelAction)
        
        switchPresentViewControllerTo(alert)
    }
    
    private func showErrorAlert(title title: String = "Error", message: String?, closeHandler: ()->Void = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        // add close action
        let closeAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            closeHandler()
        }
        alert.addAction(closeAction)
        
        switchPresentViewControllerTo(alert)
    }
    
    // MARK: - loading alert
    private func showLoadingAlert(title title: String = "Loading", message: String?, animated: Bool = false) {
        loadingAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        presentViewController(loadingAlertController!, animated: animated, completion: nil)
    }
    
    private func hideLoadingAlert() {
        loadingAlertController?.dismissViewControllerAnimated(false, completion: { () -> Void in
            self.loadingAlertController = nil
            self.hideLoadingAlertCompleteHandlerCache()
            self.hideLoadingAlertCompleteHandlerCache = {}
        })
    }
    
    // MARK: - tool functions
    private func valueForTextField(textField: UITextField) -> String {
        return textField.text == nil ? "" : textField.text!
    }
    
    private func switchPresentViewControllerTo(vc: UIViewController) {
        if loadingAlertController != nil {
            hideLoadingAlertCompleteHandlerCache = { () -> Void in
                self.presentViewController(vc, animated: true, completion: nil)
            }
        } else {
            presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    private func addTextFieldToAlertController(alert: UIAlertController, tag: Int = 0, placeholder: String = "", secureTextEntry: Bool = false) {
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.tag = tag
            textField.placeholder = placeholder
            textField.secureTextEntry = secureTextEntry
        })
    }
}
