//
//  LoginRequesterProtocol.swift
//  NearCat
//
//  Created by huchunbo on 15/12/26.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation

protocol LoginRequesterProtocol: class {
    func didLoginSuccess()
    func didLoginCancel()
}