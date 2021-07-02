//
//  Extensions.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import MapKit
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension MKAnnotationView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        setRegion(coordinateRegion, animated: true)
    }
}

extension UIFont {
    class func font(weight: Weight = .regular, ofSize: CGFloat = 14) -> UIFont {
        switch weight {
        case .bold:
            return UIFont(name: "ProximaNova-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .light:
            return UIFont(name: "ProximaNovaCond-Light", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .regular:
            return UIFont(name: "ProximaNova-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        default:
            return UIFont(name: "ProximaNova-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        }
    }
}

extension String {
    var condensed: String {
        return replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }
}
