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
    public var defaultAuthorization: CLAuthorizationStatus = .AuthorizedWhenInUse
    
    override init() {
        super.init()
        
        _locationManager.delegate = self
    }
    
    public class var sharedInstance: Location {
        return _LocationSharedInstance
    }
    
    public var currentLocation: CLLocation {
        if !alwaysAuthorization && !whenInUseAuthorization && autoRequestAuthorization {
            switch defaultAuthorization {
            case .AuthorizedAlways:
                requestAlwaysAuthorization()
            default:
                requestWhenInUseAuthorization()
            }
        }
        
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

    // MARK: - CLLocationManagerDelegate
    
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            _locationCache = currentLocation
        }
        
    }
}