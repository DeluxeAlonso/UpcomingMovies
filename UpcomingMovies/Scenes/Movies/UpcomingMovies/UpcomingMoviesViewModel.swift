//
//  UpcomingMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

final class UpcomingMoviesViewModel: MoviesViewModel {
    
    // MARK: - Properties
    
    var movieClient = MovieClient()
    
    var filter: MovieListFilter = .upcoming
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    var selectedMovieCell: UpcomingMovieCellViewModel?
    
    var startLoading: ((Bool) -> Void)?
    
    // MARK: - Computed Properties
    
    var movieCells: [UpcomingMovieCellViewModel] {
        return movies.compactMap { UpcomingMovieCellViewModel($0) }
    }
    
    // MARK: - Public
    
    func setSelectedMovie(at index: Int) {
        selectedMovieCell = movieCells[index]
    }

}
