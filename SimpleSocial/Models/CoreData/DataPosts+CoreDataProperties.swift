//
//  DataPosts+CoreDataProperties.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import CoreData
import Foundation

public extension DataPosts {
    @nonobjc class func fetchRequest() -> NSFetchRequest<DataPosts> {
        return NSFetchRequest<DataPosts>(entityName: "DataPosts")
    }

    @NSManaged var body: String?
    @NSManaged var id: Int64
    @NSManaged var title: String?
    @NSManaged var userId: Int64
    @NSManaged var comments: NSSet?
    @NSManaged var user: DataUsers?
}

// MARK: Generated accessors for comments

public extension DataPosts {
    @objc(addCommentsObject:)
    @NSManaged func addToComments(_ value: DataComments)

    @objc(removeCommentsObject:)
    @NSManaged func removeFromComments(_ value: DataComments)

    @objc(addComments:)
    @NSManaged func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged func removeFromComments(_ values: NSSet)
}

extension DataPosts: Identifiable {}
