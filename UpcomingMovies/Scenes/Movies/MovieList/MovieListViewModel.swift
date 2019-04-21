//
//  MovieListViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class MovieListViewModel: MoviesViewModel {
   
    var movieClient = MovieClient()
    
    var managedObjectContext: NSManagedObjectContext
    var filter: MovieListFilter
    
    var startLoading: ((Bool) -> Void)?
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    
    // MARK: - Computed Properties
    
    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(filter: MovieListFilter = .upcoming, managedObjectContext: NSManagedObjectContext) {
        self.filter = filter
        self.managedObjectContext = managedObjectContext
    }
    
}
