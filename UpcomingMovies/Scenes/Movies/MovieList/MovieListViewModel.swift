//
//  MovieListViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieListViewModel: MoviesViewModel {
    
    var useCaseProvider: UseCaseProviderProtocol
   
    var movieClient = MovieClient()
    
    var filter: MovieListFilter
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    
    // MARK: - Computed Properties
    
    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0, genreUseCase: useCaseProvider.genreUseCase()) }
    }
    
    // MARK: - Initializers
    
    init(filter: MovieListFilter = .upcoming, useCaseProvider: UseCaseProviderProtocol) {
        self.filter = filter
        self.useCaseProvider = useCaseProvider
    }
    
}
