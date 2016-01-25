//
//  MediaPickerDelegate.swift
//  NearCat
//
//  Created by huchunbo on 16/1/25.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit

protocol MediaPickerDelegate {
    func newImage(image: UIImage, fromMediaPicker: UIViewController)
}
