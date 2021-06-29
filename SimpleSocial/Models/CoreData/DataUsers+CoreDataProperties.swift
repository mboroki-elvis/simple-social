//
//  DataUsers+CoreDataProperties.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import Foundation
import CoreData


extension DataUsers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataUsers> {
        return NSFetchRequest<DataUsers>(entityName: "DataUsers")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var address: DataAddress?
    @NSManaged public var company: DataCompany?
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for posts
extension DataUsers {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: DataPosts)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: DataPosts)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}

extension DataUsers : Identifiable {

}
