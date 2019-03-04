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
    
    private var store: FavoriteMoviesStore
    
    var updateFavorites: (() -> Void)?
    
    var favoriteMovieCells: [FavoriteMovieCellViewModel] {
        let favorites = store.favoriteMovies
        return favorites.map { FavoriteMovieCellViewModel($0) }
    }
    
    init(store: FavoriteMoviesStore) {
        self.store = store
        self.store.delegate = self
        self.store.loadFavoriteMovies()
    }
    
}

// MARK: - FavoriteMoviesStoreDelegate

extension FavoriteMoviesViewModel: FavoriteMoviesStoreDelegate {
    
    func favoriteMoviesStore(_ favoriteMoviesStore: FavoriteMoviesStore, didUpdateFavorites update: Bool) {
        updateFavorites?()
    }
    
}
