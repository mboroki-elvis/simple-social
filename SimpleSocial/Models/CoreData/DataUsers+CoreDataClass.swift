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
    typealias DataType = DataUsers
    static func saveData(items: [User]) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        for item in items {
            let user = DataUsers(context: context)
            user.name = item.name
            user.id = Int64(item.id)
            user.email = item.email
            user.phone = item.phone
            user.website = item.website
            user.username = item.username

            let address = item.address
            let model = DataAddress(context: context)
            model.city = address.city
            model.street = address.street
            model.zipcode = address.zipcode
            model.suite = address.suite
            model.lat = address.geo.lat
            model.lng = address.geo.lng

            let company = DataCompany(context: context)
            company.bs = item.company.bs
            company.catchPhrase = item.company.catchPhrase
            company.name = item.company.name

            user.address = model
            user.company = company
        }
        CoreDataStack.shared.saveContext()
    }

    static func getData() -> [DataType] {
        return []
    }

    static func getSingle(id: Int64) -> DataType? {
        let moc = CoreDataStack.shared.persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DataUsers", in: moc)
        let predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        let request: NSFetchRequest<DataUsers> = DataUsers.fetchRequest()
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
}
