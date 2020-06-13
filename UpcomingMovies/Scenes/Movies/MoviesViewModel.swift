//
//  MoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/6/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol MoviesViewModel {
    
    associatedtype MovieCellViewModel
    
    var useCaseProvider: UseCaseProviderProtocol { get set }
    var movieUseCase: MovieUseCaseProtocol { get set }
    
    var viewState: Bindable<SimpleViewState<Movie>> { get set }
    
    var movieCells: [MovieCellViewModel] { get }
    var movies: [Movie] { get }
    
    var startLoading: Bindable<Bool> { get set }
    
    var movieFetchHandler: MovieFetchHandlerProtocol { get set }
    
}

extension MoviesViewModel {
    
    var movies: [Movie] {
        return viewState.value.currentEntities
    }
    
    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
    }
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        return MovieDetailViewModel(movies[index], useCaseProvider: useCaseProvider)
    }
    
    func getMovies() {
        let showLoader = viewState.value.isInitialPage
        fetchMovies(currentPage: viewState.value.currentPage, showLoader: showLoader)
    }
    
    func refreshMovies() {
        self.fetchMovies(currentPage: 1, showLoader: false)
    }
    
    private func fetchMovies(currentPage: Int, showLoader: Bool = false) {
        startLoading.value = showLoader
        movieFetchHandler.getMovies(page: currentPage, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let movies):
                self.processMovieResult(movies, currentPage: currentPage)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    func processMovieResult(_ movies: [Movie], currentPage: Int) {
        var allMovies = currentPage == 1 ? [] : viewState.value.currentEntities
        allMovies.append(contentsOf: movies)
        guard !allMovies.isEmpty else {
            viewState.value = .empty
            return
        }
        if movies.isEmpty {
            viewState.value = .populated(allMovies)
        } else {
            viewState.value = .paging(allMovies, next: currentPage + 1)
        }
    }
    
}
