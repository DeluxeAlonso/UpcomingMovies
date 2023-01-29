//
//  CoreDataStack.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import CoreData

public class CoreDataStack: CoreDataStackProtocol {

    public static let shared = CoreDataStack()

    private var persistentStoreDescriptions: [NSPersistentStoreDescription] = []

    private init() {}

    // MARK: - CoreDataStackProtocol

    func setExtensionPersistentStoreDescriptions(_ groupExtensionIds: [String]) {
        persistentStoreDescriptions = groupExtensionIds.map({ groupId in
            let storeURL = URL.storeURL(for: groupId, databaseName: Constants.containerName)
            let storeDescription = NSPersistentStoreDescription(url: storeURL)
            return storeDescription
        })
    }

    // MARK: - Private

    lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle(for: CoreDataStack.self)
        guard let url = bundle.url(forResource: Constants.containerName, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError()
        }

        let container = NSPersistentContainer(name: Constants.containerName, managedObjectModel: model)

        if !persistentStoreDescriptions.isEmpty {
            container.persistentStoreDescriptions = persistentStoreDescriptions
        }

        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError() }
        }
        container.viewContext.mergePolicy = NSMergePolicy.overwrite
        return container
    }()

    // MARK: - Test mockups

    lazy var mockPersistantContainer: NSPersistentContainer = {
        let bundle = Bundle(for: CoreDataStack.self)
        guard let url = bundle.url(forResource: Constants.containerName, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError()
        }

        let container = NSPersistentContainer(name: Constants.containerName, managedObjectModel: model)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in

            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("In memory coordinator creation failed \(error)")
            }
        }
        return container
    }()

    private func isTesting() -> Bool {
        NSClassFromString("XCTest") != nil
    }

}

// MARK: - Constants

extension CoreDataStack {

    struct Constants {
        static let containerName = "Model"
    }

}
