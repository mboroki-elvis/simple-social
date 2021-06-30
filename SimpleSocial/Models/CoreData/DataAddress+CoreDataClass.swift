//
//  DataAddress+CoreDataClass.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import CoreData
import Foundation
import MapKit

@objc(DataAddress)
public class DataAddress: NSManagedObject {
    var location: CLLocation? {
        guard let lat = lat, let lng = lng, let doubleLat = Double(lat), let doubleLng = Double(lng) else {
            return nil
        }
        return CLLocation(latitude: doubleLat, longitude: doubleLng)
    }
}
