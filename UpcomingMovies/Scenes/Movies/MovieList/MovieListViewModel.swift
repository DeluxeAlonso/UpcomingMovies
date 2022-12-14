//
//  MovieListViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

final class MovieListViewModel: MovieListViewModelProtocol, SimpleViewStateProcessable {

    // MARK: - Dependencies

    private let interactor: MoviesInteractorProtocol

    // MARK: - Reactive properties

    let startLoading: AnyBehaviorBindable<Bool> = BehaviorBindable(false).eraseToAnyBindable()
    let viewState: AnyBehaviorBindable<MovieListViewState> = BehaviorBindable(.initial).eraseToAnyBindable()

    var displayTitle: String?

    // MARK: - Computed Properties

    private var movies: [Movie] {
        return viewState.value.currentEntities
    }

    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
    }

    var movieCells: [MovieListCellViewModelProtocol] {
        return movies.compactMap { MovieCellViewModel($0) }
    }

    // MARK: - Initializers

    init(interactor: MoviesInteractorProtocol) {
        self.interactor = interactor
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
                self.viewState.value = self.processResult(movies,
                                                          currentPage: currentPage,
                                                          currentEntities: self.movies)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }

}
