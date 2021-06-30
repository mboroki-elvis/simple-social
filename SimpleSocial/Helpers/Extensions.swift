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
            return UIFont(name: "ProximaNovaBold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .light:
            return UIFont(name: "ProximaNovaCondensedLight", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        case .regular:
            return UIFont(name: "ProximaNovaRegular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        default:
            return UIFont(name: "ProximaNovaRegular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        }
    }
}
