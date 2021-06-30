//
//  DataAddress+CoreDataProperties.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import CoreData
import Foundation

public extension DataAddress {
    @nonobjc class func fetchRequest() -> NSFetchRequest<DataAddress> {
        return NSFetchRequest<DataAddress>(entityName: "DataAddress")
    }

    @NSManaged var city: String?
    @NSManaged var lat: String?
    @NSManaged var lng: String?
    @NSManaged var street: String?
    @NSManaged var suite: String?
    @NSManaged var zipcode: String?
    @NSManaged var user: DataUsers?
}

extension DataAddress: Identifiable {}
