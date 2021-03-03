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
    
    var interactor: MoviesInteractorProtocol
    
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
    
    init(interactor: MoviesInteractorProtocol) {
        self.interactor = interactor
    }
    
    // MARK: - Public
    
    func getMovies() {
        let showLoader = viewState.value.isInitialPage
        fetchMovies(currentPage: viewState.value.currentPage, showLoader: showLoader)
    }
    
    func refreshMovies() {
        self.fetchMovies(currentPage: 1, showLoader: false)
    }
    
    private func fetchMovies(currentPage: Int, showLoader: Bool = false) {
        startLoading.value = showLoader
        interactor.getMovies(page: currentPage, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let movies):
                self.viewState.value = self.processMovieResult(movies,
                                                               currentPage: currentPage,
                                                               currentMovies: self.movies)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    private func processMovieResult(_ movies: [Movie], currentPage: Int,
                                    currentMovies: [Movie]) -> SimpleViewState<Movie> {
        var allMovies = currentPage == 1 ? [] : currentMovies
        allMovies.append(contentsOf: movies)
        guard !allMovies.isEmpty else { return .empty }
        
        return movies.isEmpty ? .populated(allMovies) : .paging(allMovies, next: currentPage + 1)
    }
    
    func selectedMovie(at index: Int) -> Movie {
        return movies[index]
    }
    
}
