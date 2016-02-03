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
    }
    
    private func _setupViews() {
        
        navigationBar.tintColor = Constant.Color.Theme
        navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: Constant.Color.Theme ]
        
        setNavigationBarHidden(true, animated: false)
    }

}
