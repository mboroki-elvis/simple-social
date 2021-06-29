//
//  DataPosts+CoreDataProperties.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import Foundation
import CoreData


extension DataPosts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataPosts> {
        return NSFetchRequest<DataPosts>(entityName: "DataPosts")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var userId: Int64
    @NSManaged public var comments: NSSet?
    @NSManaged public var user: DataUsers?

}

// MARK: Generated accessors for comments
extension DataPosts {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: DataComments)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: DataComments)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

extension DataPosts : Identifiable {

}
