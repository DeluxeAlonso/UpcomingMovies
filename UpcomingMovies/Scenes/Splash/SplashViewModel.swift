//
//  SplashViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class SplashViewModel {
    
    private let genreClient = GenreClient()
    
    var genresFetched: (() -> Void)?
    
    private var managedObjectContext: NSManagedObjectContext!
    private var genreStore: PersistenceStore<Genre>!
    
    init(managedObjectContext: NSManagedObjectContext = PersistenceManager.shared.mainContext) {
        self.managedObjectContext = managedObjectContext
        setupStores()
    }
    
    private func setupStores() {
        genreStore = PersistenceStore(managedObjectContext)
    }
    
    /**
     * Fetch all the movie genres and save them in the AppManager Singleton.
     */
    func getMovieGenres() {
        genreClient.getAllGenres(context: managedObjectContext) { _ in
            // We only set the genres when starting the appp
            PersistenceManager.shared.genres = self.genreStore.findAll()
            self.genresFetched?()
        }
    }

}
