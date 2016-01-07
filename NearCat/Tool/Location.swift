//
//  Location.swift
//  NearCat
//
//  Created by huchunbo on 15/12/29.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation
import CoreLocation

private let _LocationSharedInstance = Location()

public class Location: NSObject, CLLocationManagerDelegate {
    
    private let _locationManager: CLLocationManager = CLLocationManager()
    private var _locationCache: CLLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    public var autoRequestAuthorization: Bool = true
    public var defaultAuthorization: CLAuthorizationStatus = .AuthorizedWhenInUse {
        didSet {
            requestDefaultAuthorization()
        }
    }
    public var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyHundredMeters {
        didSet {
            _locationManager.desiredAccuracy = desiredAccuracy
        }
    }
    
    override init() {
        super.init()
        
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    public class var sharedInstance: Location {
        return _LocationSharedInstance
    }
    
    public var currentLocation: CLLocation {
        requestDefaultAuthorization()
        
        return _locationCache
    }
    
    // MARK: - request authorizaion
    
    public func requestWhenInUseAuthorization() {
        _locationManager.requestWhenInUseAuthorization()
    }
    
    public func requestAlwaysAuthorization() {
        _locationManager.requestAlwaysAuthorization()
    }
    
    public var alwaysAuthorization: Bool {
        return CLLocationManager.authorizationStatus() == .AuthorizedAlways
    }
    
    public var whenInUseAuthorization: Bool {
        return CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse
    }
    
    func requestDefaultAuthorization() {
        if !alwaysAuthorization && !whenInUseAuthorization && autoRequestAuthorization {
            switch defaultAuthorization {
            case .AuthorizedAlways:
                requestAlwaysAuthorization()
            default:
                requestWhenInUseAuthorization()
            }
        }
    }
    
    public func update() {
        if !alwaysAuthorization && !whenInUseAuthorization {return}
        
        if #available(iOS 9.0, *) {
            _locationManager.requestLocation()
        } else {
            // Fallback on earlier versions
            _locationManager.startUpdatingLocation()
        }
    }
    
    public func startUpdating() {
        if !alwaysAuthorization && !whenInUseAuthorization {return}
        
        _locationManager.startUpdatingLocation()
    }
    
    public func endUpdating() {
        if !alwaysAuthorization && !whenInUseAuthorization {return}
        
        _locationManager.stopUpdatingHeading()
    }

    // MARK: - CLLocationManagerDelegate
    
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            _locationCache = currentLocation
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(Constant.Notification.Location.didUpdate, object: locations)
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }
}