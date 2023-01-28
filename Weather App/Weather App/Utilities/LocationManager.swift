//
//  LocationManager.swift
//  Weather App
//
//  Created by Dusan Brkic on 11.8.22..
//

import Foundation
import CoreLocation
import MapKit

protocol LocationsDelegate: AnyObject {
    func didGetCurrentLocation(lon: String, lat: String)
}

class LocationInstanceManager: NSObject {
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    weak var locationDelegate: LocationsDelegate?

    func requestLocationAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }

    func startUpdating() {
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationInstanceManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLat = locationManager.location?.coordinate.latitude,
              let newLon = locationManager.location?.coordinate.longitude
        else {
            return
        }
        let currLat = currentLocation?.coordinate.latitude
        let currLon = currentLocation?.coordinate.longitude
        if (currLat, currLon) != (newLat, newLon) {
            locationDelegate?.didGetCurrentLocation(lon: String(newLon),
                                                    lat: String(newLat))
            self.locationManager.stopUpdatingLocation()
        }
        self.currentLocation = manager.location
    }
}
