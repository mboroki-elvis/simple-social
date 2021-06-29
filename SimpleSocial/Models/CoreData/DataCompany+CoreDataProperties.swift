//
//  DataCompany+CoreDataProperties.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import Foundation
import CoreData


extension DataCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataCompany> {
        return NSFetchRequest<DataCompany>(entityName: "DataCompany")
    }

    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var name: String?
    @NSManaged public var user: DataUsers?

}

extension DataCompany : Identifiable {

}
