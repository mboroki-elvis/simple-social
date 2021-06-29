//
//  DataAddress+CoreDataProperties.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import Foundation
import CoreData


extension DataAddress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataAddress> {
        return NSFetchRequest<DataAddress>(entityName: "DataAddress")
    }

    @NSManaged public var city: String?
    @NSManaged public var lat: String?
    @NSManaged public var lng: String?
    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var user: DataUsers?

}

extension DataAddress : Identifiable {

}
