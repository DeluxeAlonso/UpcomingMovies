//
//  FavoriteStore.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/4/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

protocol PersistenceStoreDelegate: class {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool)
    func persistenceStore(didUpdateEntity update: Bool)
    
}

class PersistenceStore<Entity: Managed>: NSObject, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext: NSManagedObjectContext
    
    private var fetchedResultsController: NSFetchedResultsController<Entity>!
    
    weak var delegate: PersistenceStoreDelegate?
    
    var entities: [Entity] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    // MARK: - Initializers
    
    init(_ managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        super.init()
    }
    
    // MARK: - Public
    
    func configure(batchSize: Int = 5, limit: Int = 0) {
        let request = Entity.sortedFetchRequest
        request.fetchBatchSize = batchSize
        request.fetchLimit = limit
        request.returnsObjectsAsFaults = false
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: managedObjectContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController.delegate = self
        performFetch()
    }
    
    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.persistenceStore(willUpdateEntity: true)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        delegate?.persistenceStore(didUpdateEntity: true)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.persistenceStore(willUpdateEntity: false)
    }
    
}
