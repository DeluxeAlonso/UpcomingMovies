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
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    /**
     * Fetch all the movie genres and save them in the AppManager Singleton.
     */
    func getMovieGenres() {
        genreClient.getAllGenres(context: managedObjectContext) { result in
            switch result {
            case .success:
                self.genresFetched?()
            case .failure:
                self.genresFetched?()
            }
        }
    }

}
