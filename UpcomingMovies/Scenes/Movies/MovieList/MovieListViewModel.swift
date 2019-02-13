//
//  MovieListViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class MovieListViewModel: MoviesViewModel {

    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0) }
    }
    
    // MARK: - Properties
    
    var movieClient = MovieClient()
    var filter: MovieListFilter
    
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.loading)
    
    // MARK: - Initializers
    
    init(filter: MovieListFilter = .upcoming) {
        self.filter = filter
    }
    
}
