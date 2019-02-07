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
    var viewState: Bindable<MoviesViewState> = Bindable(.loading)
    var selectedMovieCell: UpcomingMovieCellViewModel?
    
    // MARK: - Computed Properties
    
    var movieCells: [UpcomingMovieCellViewModel] {
        return movies.compactMap { UpcomingMovieCellViewModel($0) }
    }
    
    var movies: [Movie] {
        return viewState.value.currentMovies
    }
    
    // MARK: - Public
    
    func setSelectedMovie(at index: Int) {
        selectedMovieCell = movieCells[index]
    }

}
