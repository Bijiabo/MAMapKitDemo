//
//  SettingsTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/25.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit
import FServiceManager

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
        
        FAction.checkLogin { (success, description) -> Void in
            print(success)
        }
    }
    
    private func _initViews() {
        
        title = "Settings"
        clearsSelectionOnViewWillAppear = true
        
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
        
        tableView.contentInset.top = 44.0
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("pleaseLogin", forIndexPath: indexPath)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("catArchives", forIndexPath: indexPath) as! Settings_CatArchives_TableViewCell
                return cell
            default:
                break
            }
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("findMe", forIndexPath: indexPath) as! Settings_FindMe_TableViewCell
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("feedback", forIndexPath: indexPath)
            return cell
            
        default:
            break
        }

        return UITableViewCell()
    }


    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return " "
        case 1:
            return " "
        case 2:
            return " "
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44.0))
        footerView.backgroundColor = UIColor.clearColor()
        return footerView
    }

    // MARK: - table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // user tap login cell
        if tableView.cellForRowAtIndexPath(indexPath)?.reuseIdentifier == "pleaseLogin" {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            showLoginAlert()
        }
    }
    
    func showLoginAlert() {
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
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(cancelAction)
        
        // add login button
        let loginActionHandler: ((UIAlertAction) -> Void) = { (action: UIAlertAction) -> Void in
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
                    
                }
                print(description)
            })
        }
        let loginAction = UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: loginActionHandler)
        alert.addAction(loginAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(title title: String = "Error", message: String?, closeHandler: ()->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        // add close action
        let closeAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            closeHandler()
        }
        alert.addAction(closeAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}
