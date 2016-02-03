//
//  MainRootViewControllerExtension.swift
//  NearCat
//
//  Created by huchunbo on 16/1/23.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation

extension MainRootViewController {
    
    func extension_showActionSheet() {
        let actionSheet = KKActionSheet(title: "退出后不会删除任何历史数据，下次登录依然可以使用本账号。", cancelTitle:"取消", cancelAction: { () -> Void in
            print("取消")
        })
        actionSheet.addButton("退出登录", isDestructive: true) { () -> Void in
            print("退出登录")
        }
        actionSheet.show()
    }
}