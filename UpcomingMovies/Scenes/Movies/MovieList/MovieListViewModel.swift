//
//  MovieListViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieListViewModel: MovieListViewModelProtocol {
    
    var useCaseProvider: UseCaseProviderProtocol
    var interactor: MoviesInteractorProtocol
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    
    // MARK: - Computed Properties
    
    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(useCaseProvider: UseCaseProviderProtocol, contentHandler: MoviesInteractorProtocol) {
        self.useCaseProvider = useCaseProvider
        self.interactor = contentHandler
    }
    
}
