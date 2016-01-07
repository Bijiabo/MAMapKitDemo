//
//  FNetwork.swift
//  F
//
//  Created by huchunbo on 15/11/16.
//  Copyright © 2015年 TIDELAB. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let _FNetManagerSharedInstance = FNetManager()

public class FNetManager {
    
    init() {}
    
    public class var sharedInstance : FNetManager {
        return _FNetManagerSharedInstance
    }
    
    public func POST (path path: String, parameters: [String : AnyObject]? = nil, host: String = FConfiguration.sharedInstance.host, encoding: ParameterEncoding = ParameterEncoding.JSON , completionHandler: (request: NSURLRequest, response: NSHTTPURLResponse?, json: JSON, error:ErrorType?) -> Void)
    {
        Alamofire
            .request(.POST, "\(host)\(path)", parameters: parameters, encoding: ParameterEncoding.JSON)
            .responseSwiftyJSON({ (request, response, json, error) in
                completionHandler(request: request, response: response, json: json, error: error)
            })
    }
    
    public func GET (path path: String, parameters: [String : AnyObject]? = nil, host: String = FConfiguration.sharedInstance.host, encoding: ParameterEncoding = ParameterEncoding.JSON , completionHandler: (request: NSURLRequest, response: NSHTTPURLResponse?, json: JSON, error:ErrorType?) -> Void)
    {
        Alamofire
            .request(.GET, "\(host)\(path)", parameters: parameters, encoding: ParameterEncoding.JSON)
            .responseSwiftyJSON({ (request, response, json, error) in
                completionHandler(request: request, response: response, json: json, error: error)
            })
    }
    
    public func DELETE (path path: String, parameters: [String : AnyObject]? = nil, host: String = FConfiguration.sharedInstance.host, encoding: ParameterEncoding = ParameterEncoding.JSON , completionHandler: (request: NSURLRequest, response: NSHTTPURLResponse?, json: JSON, error:ErrorType?) -> Void)
    {
        Alamofire
            .request(.DELETE, "\(host)\(path)", parameters: parameters, encoding: ParameterEncoding.JSON)
            .responseSwiftyJSON({
                (request, response, json, error) in
                completionHandler(request: request, response: response, json: json, error: error)
            })
    }
    
    public func UPLOAD (path path: String, multipartFormData: MultipartFormData -> Void, host: String = FConfiguration.sharedInstance.host, encoding: ParameterEncoding = ParameterEncoding.JSON , completionHandler: (request: NSURLRequest, response: NSHTTPURLResponse?, json: JSON, error:ErrorType?) -> Void, failedHandler: (success: Bool, description: String)->Void)
    {
        Alamofire.upload(
            .POST,
            "\(host)\(path)",
            multipartFormData: multipartFormData,
            encodingCompletion: { encodingResult in
                var result = (success: false, description: "")
                
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseSwiftyJSON({ (request, response, json, error) in
                        completionHandler(request: request, response: response, json: json, error: error)
                    })
                case .Failure(_):
                    result.description = "upload failure."
                    failedHandler(success: result.success, description: result.description)
                }
                
            }
        )
    }
    
    public func PATCH (path path: String, parameters: [String : AnyObject]? = nil, host: String = FConfiguration.sharedInstance.host, encoding: ParameterEncoding = ParameterEncoding.JSON , completionHandler: (request: NSURLRequest, response: NSHTTPURLResponse?, json: JSON, error:ErrorType?) -> Void)
    {
        Alamofire
            .request(.PATCH, "\(host)\(path)", parameters: parameters, encoding: ParameterEncoding.JSON)
            .responseSwiftyJSON({ (request, response, json, error) in
                completionHandler(request: request, response: response, json: json, error: error)
            })
    }
    
}