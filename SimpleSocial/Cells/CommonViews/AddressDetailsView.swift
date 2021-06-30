//
//  AddressDetailsView.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import CoreLocation
import MapKit
import UIKit

class AddressDetailsView: UIView {
    var dataSourceItem: DataAddress? {
        didSet {
            guard let source = dataSourceItem else {
                return
            }
            debugPrint(source)
        }
    }

    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsCompass = true
        map.showsScale = true
        map.showsUserLocation = true
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.showsCompass = true
        map.showsScale = true
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        mapView.showsUserLocation = true
        mapView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
