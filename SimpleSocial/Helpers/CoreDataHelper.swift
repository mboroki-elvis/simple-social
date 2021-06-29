//
//  CoreDataHelper.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import UIKit
import CoreData

class CoreDataHelper: NSObject {
    static var shared = CoreDataHelper()
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Simple_Social")
        container.loadPersistentStores(completionHandler: { _, error in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                #if DEBUG
                fatalError("Unresolved error \(error), \(error.userInfo)")
                #else
                print(error) // we should log this to sentry, crashlytics or something
                #endif
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                #if DEBUG
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                #else
                print(error) // we should log this to sentry, crashlytics or something
                #endif
            }
        }
    }

    func savePosts(posts: [Post]) {
        let context = self.persistentContainer.viewContext
        let user = DataPosts(context: context)
        let request = NSFetchRequest<DataPosts>()
    }
}
