//
//  LocationHelper.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, CLLocationManagerDelegate {
    // MARK: Lifecycle

    override init() {
        super.init()
    }

    // MARK: Internal

    static var shared = LocationManager()

    func setupManager() {
        // Locations get
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        checkPermission()
    }

    func locationManager(_: CLLocationManager, didChangeAuthorization _: CLAuthorizationStatus) {}

    func locationManager(_: CLLocationManager, didUpdateLocations _: [CLLocation]) {}

    func locationManager(_: CLLocationManager, didFailWithError _: Error) {}

    // MARK: Private

    private var manager = CLLocationManager()

    private func checkPermission() {
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14, *) {
                switch CLLocationManager().authorizationStatus {
                case .denied:
                    manager.requestAlwaysAuthorization()
                    manager.requestWhenInUseAuthorization()
                case .notDetermined, .restricted:
                    break
                case .authorizedAlways, .authorizedWhenInUse:
                    break
                @unknown default:
                    break
                }
            } else {
                switch CLLocationManager.authorizationStatus() {
                case .denied:
                    manager.requestAlwaysAuthorization()
                    manager.requestWhenInUseAuthorization()
                case .notDetermined, .restricted:
                    break
                case .authorizedAlways, .authorizedWhenInUse:
                    break
                @unknown default:
                    break
                }
            }
        }
    }
}
