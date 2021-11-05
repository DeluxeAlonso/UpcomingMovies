//
//  UpcomingMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class UpcomingMoviesViewModel: UpcomingMoviesViewModelProtocol, SimpleViewStateProcessable {

    // MARK: - Dependencies

    private let interactor: MoviesInteractorProtocol

    // MARK: - Reactive properties

    private(set) var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    private(set) var startLoading: Bindable<Bool> = Bindable(false)

    // MARK: - Computed properties

    private var movies: [Movie] {
        return viewState.value.currentEntities
    }

    var movieCells: [UpcomingMovieCellViewModelProtocol] {
        return movies.compactMap { UpcomingMovieCellViewModel($0) }
    }

    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
    }

    // MARK: - Initializers

    init(interactor: MoviesInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - UpcomingMoviesViewModelProtocol

    func getMovies() {
        let showLoader = viewState.value.isInitialPage
        fetchMovies(currentPage: viewState.value.currentPage, showLoader: showLoader)
    }

    func refreshMovies() {
        self.fetchMovies(currentPage: 1, showLoader: false)
    }

    func movie(for index: Int) -> Movie {
        return movies[index]
    }

    // MARK: - Private

    private func fetchMovies(currentPage: Int, showLoader: Bool = false) {
        startLoading.value = showLoader
        interactor.getMovies(page: currentPage, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let movies):
                self.viewState.value = self.processResult(movies,
                                                          currentPage: currentPage,
                                                          currentEntities: self.movies)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }

}
