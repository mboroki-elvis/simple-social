//
//  DataUsers+CoreDataProperties.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import CoreData
import Foundation

public extension DataUsers {
    @nonobjc class func fetchRequest() -> NSFetchRequest<DataUsers> {
        return NSFetchRequest<DataUsers>(entityName: "DataUsers")
    }

    @NSManaged var email: String?
    @NSManaged var id: Int64
    @NSManaged var name: String?
    @NSManaged var username: String?
    @NSManaged var address: DataAddress?
    @NSManaged var company: DataCompany?
    @NSManaged var posts: NSSet?
}

// MARK: Generated accessors for posts

public extension DataUsers {
    @objc(addPostsObject:)
    @NSManaged func addToPosts(_ value: DataPosts)

    @objc(removePostsObject:)
    @NSManaged func removeFromPosts(_ value: DataPosts)

    @objc(addPosts:)
    @NSManaged func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged func removeFromPosts(_ values: NSSet)
}

extension DataUsers: Identifiable {}
