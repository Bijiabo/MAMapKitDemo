//
//  NotificationAlertObserverProtocol.swift
//  NearCat
//
//  Created by huchunbo on 15/12/26.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation

protocol NotificationAlertObserverProtocol {
    func showLoginTextField(notification: NSNotification)
    func showLoading(notification: NSNotification)
    func hideLoading(notification: NSNotification)
    func showError(notification: NSNotification)
}

extension NotificationAlertObserverProtocol {
    func showLoginTextField(notification: NSNotification) {}
    func showLoading(notification: NSNotification) {}
    func hideLoading(notification: NSNotification) {}
    func showError(notification: NSNotification) {}
}