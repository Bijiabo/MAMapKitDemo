//
//  FStatus.swift
//  F
//
//  Created by huchunbo on 15/11/10.
//  Copyright © 2015年 TIDELAB. All rights reserved.
//

import Foundation

public class FStatus: NSObject {
    
    var observers: [String: [FStatusObserver]] = [String: [FStatusObserver]]()
    
    public override init() {
        super.init()
        
        _addObservers()
        _setupLoginStatus()
    }
    
    deinit {
        _removeObservers()
    }
    
    // MARK: - add observers
    
    private func _addObservers () {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("addObserver:"), name: FConstant.Notification.FStatus.addObserver, object: nil)
        notificationCenter.addObserver(self, selector: Selector("removeObserver:"), name: FConstant.Notification.FStatus.removeObserver, object: nil)

        notificationCenter.addObserver(self, selector: Selector("didLogin:"), name: FConstant.Notification.FStatus.didLogin, object: nil)
        notificationCenter.addObserver(self, selector: Selector("didLogout:"), name: FConstant.Notification.FStatus.didLogout, object: nil)
    }
    
    private func _removeObservers () {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: FConstant.Notification.FStatus.addObserver, object: nil)
        notificationCenter.removeObserver(self, name: FConstant.Notification.FStatus.removeObserver, object: nil)
        notificationCenter.removeObserver(self, name: FConstant.Notification.FStatus.didLogin, object: nil)
        notificationCenter.removeObserver(self, name: FConstant.Notification.FStatus.didLogout, object: nil)
    }
    
    func addObserver (notification: NSNotification) {
        guard let object = _convertNotificationObject(notificationObject: notification.object) else {return}
        
        if let targetObserverGroup = observers[object.name]{
            for (_,item) in targetObserverGroup.enumerate() {
                if item === object.observer {return}
            }
            observers[object.name]?.append(object.observer)
        } else {
            observers[object.name] = [object.observer]
        }
        _afterActionForAddObservers(object)
    }
    
    func removeObserver (notification: NSNotification) {
        guard let object = _convertNotificationObject(notificationObject: notification.object) else {return}
        guard let targetObserverGroup = observers[object.name] else {return}
        for (index,item) in targetObserverGroup.enumerate() {
            if item === object.observer {
                observers[object.name]?.removeAtIndex(index)
                return
            }
        }
    }

    func didLogin(notification: NSNotification) {
        _saveLoggedInStatus(loggedIn: true)
        
        Action.remoteNotificationTokens.create(token: FHelper.deviceToken)
    }

    func didLogout(notification: NSNotification) {
        _saveLoggedInStatus(loggedIn: false)
        
        Action.remoteNotificationTokens.removeRelationship(token: FHelper.deviceToken)
    }
    
    private func _convertNotificationObject(notificationObject notificationObject: AnyObject?) -> (name: String, observer: FStatusObserver)? {
        guard let n_object = notificationObject else {return nil}
        guard let object = n_object as? [String: AnyObject] else {return nil}
        
        if
        let name = object["name"] as? String,
        let observer = object["observer"] as? FStatusObserver
        {
            return (name: name, observer: observer)
        }
        
        return nil
    }
    
    func runStatementForTargetObservers(observerGroupName observerGroupName: String, statement : (observer : FStatusObserver) -> Void ) {
        guard let targetObserverGroup = observers[observerGroupName] else {return}
        for (_,observer) in targetObserverGroup.enumerate() {
            statement(observer: observer)
        }
    }
    
    private func _afterActionForAddObservers (object: (name: String, observer: FStatusObserver)) {
        //do things after add observers each time
    }
    
    // MARK: - class functions
    
    class func addFStatusObserver(name name: String, observer: FStatusObserver) {
        NSNotificationCenter.defaultCenter().postNotificationName(FConstant.Notification.FStatus.addObserver, object: ["name": name, "observer": observer] as NSDictionary)
    }
    
    class func removeFStatusObserver(name name: String, observer: FStatusObserver) {
        NSNotificationCenter.defaultCenter().postNotificationName(FConstant.Notification.FStatus.removeObserver, object: ["name": name, "observer": observer] as NSDictionary)
    }
    
    // MARK: - login status
    private func _setupLoginStatus () {
        _checkLoginStatus()
    }

    private func _saveLoggedInStatus (loggedIn loggedIn: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(loggedIn, forKey: FConstant.UserDefaults.FStatus.logged_in)
        userDefaults.synchronize()
    }
    
    private func _checkLoginStatus () {
        //TODO: check logged in status
        var logged_in: Bool = false
        
        FAction.checkLogin { (success, description) -> Void in
            logged_in = success

            self._saveLoggedInStatus(loggedIn: logged_in)
            
            self.runStatementForTargetObservers(observerGroupName: FConstant.String.FStatus.loginStatus) { (observer) -> Void in
                if let observer = observer as? FStatus_LoginObserver {
                    if logged_in {
                        observer.FStatus_didLogIn?()
                    } else {
                        observer.FStatus_didLogOut?()
                    }
                }
            }
        }
    }
    
    
}