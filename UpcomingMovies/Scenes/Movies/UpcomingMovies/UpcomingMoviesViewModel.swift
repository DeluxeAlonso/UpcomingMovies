//
//  UpcomingMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class UpcomingMoviesViewModel: MoviesViewModel {

    // MARK: - Properties
    
    var useCaseProvider: UseCaseProviderProtocol
    var movieUseCase: MovieUseCaseProtocol
    var movieFetchHandler: MovieFetchHandlerProtocol
    
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    var selectedMovieCell: UpcomingMovieCellViewModel?
    
    var startLoading: Bindable<Bool> = Bindable(false)
    
    // MARK: - Computed Properties
    
    var movieCells: [UpcomingMovieCellViewModel] {
        return movies.compactMap { UpcomingMovieCellViewModel($0) }
    }
    
    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
    }
    
    // MARK: - Initializers
    
    init(useCaseProvider: UseCaseProviderProtocol, movieFetchHandler: MovieFetchHandlerProtocol) {
        self.useCaseProvider = useCaseProvider
        self.movieUseCase = self.useCaseProvider.movieUseCase()
        self.movieFetchHandler = movieFetchHandler
    }
    
    // MARK: - Public
    
    func setSelectedMovie(at index: Int) {
        selectedMovieCell = movieCells[index]
    }
    
}
