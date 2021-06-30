//
//  DataComments+CoreDataClass.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//
//

import CoreData
import Foundation

@objc(DataComments)
public class DataComments: NSManagedObject, CoreDataDelegate {
    typealias Item = Comment

    typealias DataType = DataComments

    static func saveData(items: [Comment]) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        guard let id = items.first?.postID else { return }
        let post = DataPosts.getSingle(id: id)
        for item in items {
            let comment = DataComments(context: context)
            comment.body = item.body
            comment.email = item.email
            comment.id = item.id
            comment.name = item.name
            comment.postId = item.postID
            post?.addToComments(comment)
        }
        CoreDataStack.shared.saveContext()
    }

    static func getData() -> [DataComments] {
        return []
    }

    static func getSingle(id: Int64) -> DataComments? {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DataComments", in: moc)
        let predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        let request: NSFetchRequest<DataComments> = DataComments.fetchRequest()
        request.predicate = predicate
        request.entity = entityDescription
        request.fetchLimit = 1
        do {
            let results = try moc.fetch(request)
            return results.last
        } catch {
            print(error)
        }
        return nil
    }

    static func getController(postId: Int64) -> NSFetchedResultsController<DataComments>? {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DataComments", in: moc)
        let predicate = NSPredicate(format: "postId = %@", argumentArray: [postId])
        let request: NSFetchRequest<DataComments> = DataComments.fetchRequest()
        request.predicate = predicate
        request.entity = entityDescription
        request.fetchBatchSize = 10
        let systemTimeSort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [systemTimeSort]
        let controller = NSFetchedResultsController<DataComments>(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: "DataComments")
        return controller
    }
}
