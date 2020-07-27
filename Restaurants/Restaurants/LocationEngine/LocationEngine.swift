//
//  LocationEngine.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationCompletion = (CLLocationCoordinate2D?) -> Void

protocol LocationProtocol: class {
    var isLocationEnabled: Bool { get }
    var coordinates: CLLocationCoordinate2D? { get }
}

class LocationEngine: NSObject {
    
    private let locationManager = CLLocationManager()
    private var locationCompletion: LocationCompletion?
    private var coords: CLLocationCoordinate2D?
    
    override init() {
        super.init()
    }
    
    convenience init(completion: LocationCompletion?) {
        self.init()
        locationCompletion = completion
        configure()
    }
}

extension LocationEngine {
    
    func configure() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .restricted, .denied, .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            fatalError()
        }
    }
}

extension LocationEngine: LocationProtocol {
    
    var isLocationEnabled: Bool {
        switch CLLocationManager.authorizationStatus() {
        case .restricted, .denied, .notDetermined:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        @unknown default:
            fatalError()
        }
    }
    
    var coordinates: CLLocationCoordinate2D? {
        return coords
    }
}

extension LocationEngine: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            print(Constants.Error.locationDisabled.rawValue)
            self.locationCompletion?(nil)
        case .notDetermined:
            locationManager.startUpdatingLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            break
        default:
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geoCoder = CLGeocoder()
        locationManager.stopUpdatingLocation()
        guard let currentLocation = locations.first else { fatalError(Constants.Error.currentLocation.rawValue) }
        geoCoder.reverseGeocodeLocation(currentLocation) { [weak self] (placeMarks, error) in
            guard let self = self else { return }
            guard let placeMark = placeMarks?.first else { return }
            guard let coords = placeMark.location?.coordinate else { fatalError(Constants.Error.coordinateData.rawValue) }
            self.coords = coords
            self.locationCompletion?(coords)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
}
