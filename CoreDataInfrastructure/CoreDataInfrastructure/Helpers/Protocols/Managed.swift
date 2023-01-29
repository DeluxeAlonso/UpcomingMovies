//
//  Managed.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 1/7/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import CoreData

protocol Managed: NSFetchRequestResult {

    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }

}

extension Managed {

    static var defaultSortDescriptors: [NSSortDescriptor] {
        []
    }

    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }

}

extension Managed where Self: NSManagedObject {

    static var entityName: String {
        entity().name!
    }

    static func fetch(in context: NSManagedObjectContext,
                      with sortDescriptors: [NSSortDescriptor] = defaultSortDescriptors,
                      fetchLimit: Int? = nil,
                      configurationBlock: (NSFetchRequest<Self>) -> Void = { _ in }) -> [Self] {
        let request = NSFetchRequest<Self>(entityName: Self.entityName)
        request.sortDescriptors = sortDescriptors
        if let fetchLimit = fetchLimit { request.fetchLimit = fetchLimit }
        configurationBlock(request)
        return (try? context.fetch(request)) ?? []
    }

    static func count(in context: NSManagedObjectContext,
                      configurationBlock: (NSFetchRequest<Self>) -> Void = { _ in }) -> Int {
        let request = NSFetchRequest<Self>(entityName: Self.entityName)
        configurationBlock(request)
        return (try? context.count(for: request)) ?? 0
    }

    static func findOrFetch(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        guard let object = materializedObject(in: context, matching: predicate) else {
            return fetch(in: context) { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1
            }.first
        }
        return object
    }

    static func materializedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        for object in context.registeredObjects where !object.isFault {
            guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
            return result
        }
        return nil
    }

}
