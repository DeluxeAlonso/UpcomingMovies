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
    
    private var favoriteStore: PersistenceStore<Favorite>!
    
    var updateFavorites: (() -> Void)?
    
    var favoriteMovieCells: [FavoriteMovieCellViewModel] {
        let favorites = favoriteStore.entities
        return favorites.map { FavoriteMovieCellViewModel($0) }
    }
    
    init(managedObjectContext: NSManagedObjectContext = PersistenceManager.shared.mainContext) {
        favoriteStore = PersistenceStore(managedObjectContext)
        favoriteStore.configure()
        favoriteStore.delegate = self
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
