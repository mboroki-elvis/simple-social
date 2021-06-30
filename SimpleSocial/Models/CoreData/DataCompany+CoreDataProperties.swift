//
//  DataCompany+CoreDataProperties.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import CoreData
import Foundation

public extension DataCompany {
    @nonobjc class func fetchRequest() -> NSFetchRequest<DataCompany> {
        return NSFetchRequest<DataCompany>(entityName: "DataCompany")
    }

    @NSManaged var bs: String?
    @NSManaged var catchPhrase: String?
    @NSManaged var name: String?
    @NSManaged var user: DataUsers?
}

extension DataCompany: Identifiable {}
