//
//  DataPosts+CoreDataClass.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import CoreData
import Foundation

@objc(DataPosts)
public class DataPosts: NSManagedObject, CoreDataDelegate {
    typealias Item = Post
    static func saveData(items: [Post]) {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        for item in items {
            let user = DataPosts(context: moc)
            user.body = item.body
            user.title = item.title
            user.id = Int64(item.id)
            user.userId = Int64(item.userID)
        }
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }

    static func getData() -> [Post] {
        return []
    }

    static func getSingle(id: Int64) -> Post? {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DataPosts", in: moc)
        let predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        let request: NSFetchRequest<DataPosts> = DataPosts.fetchRequest()
        request.predicate = predicate
        request.entity = entityDescription
        request.fetchLimit = 1
        do {
            let results = try moc.fetch(request)
            if let message = results.last, let title = message.title, let body = message.body {
                return Post(userID: Int(message.userId), id: Int(message.id), title: title, body: body)
            }
        } catch {
            print(error)
        }
        return nil
    }

    static func getController() -> NSFetchedResultsController<DataPosts>? {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DataPosts", in: moc)
        let request: NSFetchRequest<DataPosts> = DataPosts.fetchRequest()
        request.entity = entityDescription
        request.fetchBatchSize = 10
        let systemTimeSort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [systemTimeSort]
        let controller = NSFetchedResultsController<DataPosts>(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: "DataPosts")
        return controller
    }
}
