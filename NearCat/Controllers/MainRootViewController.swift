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
        if let object = notification.object as? [String: String] {
            if let objectTitle = object["title"] { title = objectTitle }
            if let objectMessage = object["message"] {message = objectMessage }
        }
        showLoadingAlert(title: title, message: message)
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
        let alert = UIAlertController(title: "登陆", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        // add user email text field
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.tag = 0
            textField.placeholder = "email"
            textField.secureTextEntry = false
        })
        
        // add user password text field
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.tag = 1
            textField.placeholder = "password"
            textField.secureTextEntry = true
        })
        
        // add cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            cancelHandler?()
        })
        alert.addAction(cancelAction)
        
        // add login button
        let loginActionHandler: ((UIAlertAction) -> Void) = { (action: UIAlertAction) -> Void in
            // show loading alert
            self.showLoadingAlert(title: "Login...", message: nil)
            
            // get email and password
            var email: String = String()
            var password: String = String()
            for textField in alert.textFields! {
                switch textField.tag {
                case 0:
                    email = textField.text == nil ? "" : textField.text!
                case 1:
                    password = textField.text == nil ? "" : textField.text!
                default:
                    break
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
        alert.addAction(loginAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func showErrorAlert(title title: String = "Error", message: String?, closeHandler: ()->Void = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        // add close action
        let closeAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            closeHandler()
        }
        alert.addAction(closeAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func showLoadingAlert(title title: String = "Loading", message: String?) {
        loadingAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        presentViewController(loadingAlertController!, animated: false, completion: nil)
    }
    
    private func hideLoadingAlert() {
        loadingAlertController?.dismissViewControllerAnimated(false, completion: { () -> Void in
            self.loadingAlertController = nil
        })
    }
}
