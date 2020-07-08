//
//  UpcomingMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class UpcomingMoviesViewModel: UpcomingMoviesViewModelProtocol {

    // MARK: - Properties
    
    var contentHandler: MoviesContentHandlerProtocol
    
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    
    var startLoading: Bindable<Bool> = Bindable(false)
    
    // MARK: - Computed Properties
    
    var movieCells: [UpcomingMovieCellViewModel] {
        return movies.compactMap { UpcomingMovieCellViewModel($0) }
    }
    
    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
    }
    
    // MARK: - Initializers
    
    init(contentHandler: MoviesContentHandlerProtocol) {
        self.contentHandler = contentHandler
    }
    
    // MARK: - Public
    
    func movie(for index: Int) -> Movie {
        return movies[index]
    }
    
}
