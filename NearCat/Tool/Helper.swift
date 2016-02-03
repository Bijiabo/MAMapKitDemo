//
//  Helper.swift
//  NearCat
//
//  Created by huchunbo on 16/1/12.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

private let _imageDownloader = ImageDownloader(
    configuration: ImageDownloader.defaultURLSessionConfiguration(),
    downloadPrioritization: .FIFO,
    maximumActiveDownloads: 4,
    imageCache: AutoPurgingImageCache()
)

public class Helper {
    public class func setRemoteImageForImageView(imageView: UIImageView, avatarURLString: String) {
        
        let avatarURL = NSURL(string: avatarURLString)!
        let avatarURLRequest = NSURLRequest(URL: avatarURL)
        _imageDownloader.downloadImage(URLRequest: avatarURLRequest) { (response) -> Void in
            if let image = response.result.value {
                imageView.image = image
            }
        }
    }
    
    public class func setRemoteImageForImageView(imageView: UIImageView, imagePath: String) {
        var _imagePathCharaters = imagePath.characters
        _imagePathCharaters.removeFirst()
        let avatarURLString = "\(FConfiguration.sharedInstance.host)\(String(_imagePathCharaters))"
        let avatarURL = NSURL(string: avatarURLString)!
        let avatarURLRequest = NSURLRequest(URL: avatarURL)
        _imageDownloader.downloadImage(URLRequest: avatarURLRequest) { (response) -> Void in
            if let image = response.result.value {
                imageView.image = image
            }
        }
    }
}