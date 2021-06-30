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
    typealias DataType = DataPosts

    static func saveData(items: [Post]) {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        for item in items {
            let user = DataPosts(context: moc)
            user.body = item.body
            user.title = item.title
            user.id = Int64(item.id)
            user.userId = Int64(item.userID)
        }
        CoreDataStack.shared.saveContext()
    }

    static func getData() -> [DataPosts] {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DataPosts", in: moc)
        let request: NSFetchRequest<DataPosts> = DataPosts.fetchRequest()
        request.entity = entityDescription
        let systemTimeSort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [systemTimeSort]
        do {
            return try moc.fetch(request)
        } catch {
            Logger.shared.log(error)
        }
        return []
    }

    static func getSingle(id: Int64) -> DataPosts? {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DataPosts", in: moc)
        let predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        let request: NSFetchRequest<DataPosts> = DataPosts.fetchRequest()
        request.predicate = predicate
        request.entity = entityDescription
        request.fetchLimit = 1
        do {
            let results = try moc.fetch(request)
            return results.last
        } catch {
            Logger.shared.log(error)
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

    static func search(term: String) -> NSFetchedResultsController<DataPosts>? {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DataPosts", in: moc)
        let request: NSFetchRequest<DataPosts> = DataPosts.fetchRequest()
        request.entity = entityDescription
        request.fetchBatchSize = 10
        let systemTimeSort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [systemTimeSort]
        request.predicate = NSPredicate(format: "(title contains[cd] %@) || (body contains[cd] %@)", term, term)
        let controller = NSFetchedResultsController<DataPosts>(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }
}
