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
    private let factory: UpcomingMoviesFactoryProtocol
    private let userPreferencesHandler: UserPreferencesHandlerProtocol

    // MARK: - Reactive properties

    let viewState = BehaviorBindable(UpcomingMoviesViewState.initial).eraseToAnyBindable()
    let startLoading = BehaviorBindable(false).eraseToAnyBindable()
    let presentationMode = BehaviorBindable(UpcomingMoviesPresentationMode.preview).eraseToAnyBindable()

    // MARK: - Computed properties

    private var movies: [Movie] {
        viewState.value.currentEntities
    }

    var movieCells: [UpcomingMovieCellViewModelProtocol] {
        movies.compactMap { UpcomingMovieCellViewModel($0) }
    }

    var needsPrefetch: Bool {
        viewState.value.needsPrefetch
    }

    var currentPresentationMode: UpcomingMoviesPresentationMode {
        userPreferencesHandler.upcomingMoviesPresentationMode
    }

    // MARK: - Initializers

    init(interactor: MoviesInteractorProtocol, factory: UpcomingMoviesFactoryProtocol, userPreferenceHandler: UserPreferencesHandlerProtocol) {
        self.interactor = interactor
        self.factory = factory
        self.userPreferencesHandler = userPreferenceHandler
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
        movies[index]
    }

    func getToggleBarButtonItemModel() -> ToggleBarButtonItemViewModelProtocol {
        let contents = factory.makeGridBarButtonItemContents()
        return ToggleBarButtonItemViewModel(contents: contents)
    }

    func updatePresentationMode() {
        switch presentationMode.value {
        case .preview:
            presentationMode.value = .detail
        case .detail:
            presentationMode.value = .preview
        }
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
