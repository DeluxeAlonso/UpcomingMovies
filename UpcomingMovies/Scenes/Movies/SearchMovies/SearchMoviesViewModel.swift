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
    
    func searchOptionsViewModel(_ managedObjectContext: NSManagedObjectContext) -> SearchOptionsViewModel {
        return SearchOptionsViewModel(managedObjectContext: managedObjectContext)
    }
    
    func prepareSearchResultController(_ managedObjectContext: NSManagedObjectContext) -> SearchMoviesResultController {
        let viewModel = SearchMoviesResultViewModel(managedObjectContext: managedObjectContext)
        return SearchMoviesResultController(viewModel: viewModel)
    }
    
    // MARK: - Default search options
    
    func popularMoviesViewModel() -> MovieListViewModel {
        return MovieListViewModel(filter: .popular)
    }
    
    func topRatedMoviesViewModel() -> MovieListViewModel {
        return MovieListViewModel(filter: .topRated)
    }
    
    func moviesByGenreViewModel(genreId: Int, genreName: String) -> MovieListViewModel {
        return MovieListViewModel(filter: .byGenre(genreId: genreId, genreName: genreName))
    }
    
}
