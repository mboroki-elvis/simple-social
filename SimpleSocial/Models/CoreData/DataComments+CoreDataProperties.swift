//
//  DataComments+CoreDataProperties.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import CoreData
import Foundation

public extension DataComments {
    @nonobjc class func fetchRequest() -> NSFetchRequest<DataComments> {
        return NSFetchRequest<DataComments>(entityName: "DataComments")
    }

    @NSManaged var body: String?
    @NSManaged var email: String?
    @NSManaged var id: Int64
    @NSManaged var name: String?
    @NSManaged var postId: Int64
    @NSManaged var post: DataPosts?
}

extension DataComments: Identifiable {}
