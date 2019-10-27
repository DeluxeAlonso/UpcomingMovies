//
//  SearchMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class SearchMoviesViewModel: NSObject {
    
    var managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext = PersistenceManager.shared.mainContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func buildSearchOptionsViewModel() -> SearchOptionsViewModel {
        return SearchOptionsViewModel()
    }
    
    func prepareSearchResultController() -> SearchMoviesResultController {
        let viewModel = SearchMoviesResultViewModel(managedObjectContext: managedObjectContext)
        return SearchMoviesResultController(viewModel: viewModel)
    }
    
    // MARK: - Default search options
    
    func popularMoviesViewModel() -> MovieListViewModel {
        return MovieListViewModel(filter: .popular,
                                  managedObjectContext: managedObjectContext)
    }
    
    func topRatedMoviesViewModel() -> MovieListViewModel {
        return MovieListViewModel(filter: .topRated,
                                  managedObjectContext: managedObjectContext)
    }
    
    func moviesByGenreViewModel(genreId: Int) -> MovieListViewModel {
        return MovieListViewModel(filter: .byGenre(genreId: genreId),
                                  managedObjectContext: managedObjectContext)
    }
    
    func recentlyVisitedMovieViewModel(id: Int, title: String) -> MovieDetailViewModel {
        return MovieDetailViewModel(id: id,
                                    title: title)
    }
    
}
