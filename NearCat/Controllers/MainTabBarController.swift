//
//  MainTabBarController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/26.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewWillLayoutSubviews() {
        // custom tabbar height
        /*
        var tabFrame = self.tabBar.frame
        // - 40 is editable , I think the default value is around 50 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = 40
        tabFrame.origin.y = self.view.frame.size.height - 40
        self.tabBar.frame = tabFrame
        */
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        _setupTabbarStyle()
    }
    
    private func _setupTabbarStyle() {
        for item in tabBar.items! {
            // hide tabbar titles
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 50.0)
            // setup tabbar image offset
            let offset: CGFloat = 6.0
            item.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: uitabbar delegate
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        if let _ = viewController as? TabbarShootViewController {
            print("user tap shoot button")
            let shootVC = storyboard?.instantiateViewControllerWithIdentifier("shootViewController") as! ShootViewController
            presentViewController(shootVC, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
    }
    
}
