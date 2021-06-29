//
//  DataUsers+CoreDataClass.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import CoreData
import Foundation

@objc(DataUsers)
public class DataUsers: NSManagedObject, CoreDataDelegate {
    typealias Item = User
    static func saveData(items: [User]) {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        for item in items {
            let user = DataUsers(context: moc)
            user.name = item.name
            user.id = Int64(item.id)
            user.email = item.email
            user.phone = item.phone
            user.website = item.website
            user.username = item.username
        }
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }

    static func getData() -> [User] {
        return []
    }

    static func getSingle(id: Int64) -> User? {
        return nil
    }
}
