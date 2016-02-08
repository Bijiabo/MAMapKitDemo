//
//  MainNavigationController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/26.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        _setupViews()
        _addNotificationObservers()
    }
    
    private func _setupViews() {
        
        navigationBar.tintColor = Constant.Color.Theme
        navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: Constant.Color.Theme ]
        
        setNavigationBarHidden(true, animated: false)
    }
    
    private func _addNotificationObservers() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(self, selector: Selector("pushViewController:"), name: Constant.Notification.Helper.Controller.pushViewController, object: nil)
    }
    
    func pushViewController(notification: NSNotification) {
        if let vc = notification.object as? UIViewController {
            pushViewController(vc, animated: true)
        }
    }

}
