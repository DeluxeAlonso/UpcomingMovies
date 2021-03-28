//
//  MovieListViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

final class MovieListViewModel: MovieListViewModelProtocol {

    // MARK: - Dependencies
    
    private let interactor: MoviesInteractorProtocol
    private let viewStateHandler: ViewStateHandlerProtocol

    // MARK: - Reactive properties
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    
    var displayTitle: String?
    
    // MARK: - Computed Properties
    
    private var movies: [Movie] {
        return viewState.value.currentEntities
    }
    
    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
    }
    
    var movieCells: [MovieCellViewModelProtocol] {
        return movies.compactMap { MovieCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(interactor: MoviesInteractorProtocol, viewStateHandler: ViewStateHandlerProtocol) {
        self.interactor = interactor
        self.viewStateHandler = viewStateHandler
    }
    
    // MARK: - MovieListViewModelProtocol
    
    func getMovies() {
        let showLoader = viewState.value.isInitialPage
        fetchMovies(currentPage: viewState.value.currentPage, showLoader: showLoader)
    }
    
    func refreshMovies() {
        self.fetchMovies(currentPage: 1, showLoader: false)
    }

    func selectedMovie(at index: Int) -> Movie {
        return movies[index]
    }

    // MARK: - Private
    
    private func fetchMovies(currentPage: Int, showLoader: Bool = false) {
        startLoading.value = showLoader
        interactor.getMovies(page: currentPage, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let movies):
                self.viewState.value = self.viewStateHandler.processResult(movies,
                                                                           currentPage: currentPage,
                                                                           currentEntities: self.movies)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
}
