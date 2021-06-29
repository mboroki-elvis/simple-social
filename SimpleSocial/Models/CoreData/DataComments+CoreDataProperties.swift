//
//  DataComments+CoreDataProperties.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import Foundation
import CoreData


extension DataComments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataComments> {
        return NSFetchRequest<DataComments>(entityName: "DataComments")
    }

    @NSManaged public var body: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var postId: Int64
    @NSManaged public var post: DataPosts?

}

extension DataComments : Identifiable {

}
