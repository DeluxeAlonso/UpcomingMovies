//
//  CoreDataStack.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import CoreData

public class CoreDataStack {
    
    public static let shared = CoreDataStack()
    
    private var todayExtensionStoreDescription: NSPersistentStoreDescription {
        let storeURL = URL.storeURL(for: "group.movies.extension", databaseName: Constants.containerName)
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        return storeDescription
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle(for: CoreDataStack.self)
        guard let url = bundle.url(forResource: Constants.containerName, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError()
        }
        
        let container = NSPersistentContainer(name: Constants.containerName, managedObjectModel: model)
        container.persistentStoreDescriptions = [todayExtensionStoreDescription]
        
        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError() }
        }
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        let container = isTesting() ? mockPersistantContainer : persistentContainer
        let context = container.viewContext
        context.mergePolicy = NSMergePolicy.overwrite
        return context
    }
    
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
        return NSClassFromString("XCTest") != nil
    }
    
}

// MARK: - Constants

extension CoreDataStack {
    
    struct Constants {
        static let containerName = "Model"
    }
    
}
