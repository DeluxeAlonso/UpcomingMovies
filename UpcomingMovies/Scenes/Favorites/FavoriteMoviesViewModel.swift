//
//  FavoriteMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class FavoriteMoviesViewModel {
    
    private var managedObjectContext: NSManagedObjectContext
    private var favoriteStore: PersistenceStore<Favorite>!
    
    var updateFavorites: (() -> Void)?
    
    var favorites: [Favorite] {
        return favoriteStore.entities
    }
    
    var favoriteMovieCells: [FavoriteMovieCellViewModel] {
        return favorites.map { FavoriteMovieCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(managedObjectContext: NSManagedObjectContext = PersistenceManager.shared.mainContext) {
        self.managedObjectContext = managedObjectContext
        setupStores()
    }
    
    private func setupStores() {
        favoriteStore = PersistenceStore(managedObjectContext)
        favoriteStore.configure()
        favoriteStore.delegate = self
    }
    
    // MARK: - Public
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < favorites.count else { return nil }
        let favorite = favorites[index]
        return MovieDetailViewModel(id: favorite.id,
                                    title: favorite.title,
                                    managedObjectContext: managedObjectContext)
    }
    
}

// MARK: - FavoriteMoviesStoreDelegate

extension FavoriteMoviesViewModel: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {
    }
    
    func persistenceStore(didUpdateEntity update: Bool) {
        updateFavorites?()
    }
    
}
