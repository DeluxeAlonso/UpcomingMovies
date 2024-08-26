//
//  MovieDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieDetailViewModel: MovieDetailViewModelProtocol {

    // MARK: - Dependencies

    private let interactor: MovieDetailInteractorProtocol
    private let factory: MovieDetailFactoryProtocol

    // MARK: - Reactive properties

    let startLoading = BehaviorBindable(false).eraseToAnyBindable()

    let showGenreName = BehaviorBindable("-").eraseToAnyBindable()

    let didSetupMovieDetail = BehaviorBindable(false).eraseToAnyBindable()

    let showSuccessAlert = PublishBindable<String>().eraseToAnyBindable()
    let showErrorAlert = PublishBindable<Error>().eraseToAnyBindable()
    let showErrorRetryView = PublishBindable<Error>().eraseToAnyBindable()

    let didSelectShareAction = PublishBindable<Bool>().eraseToAnyBindable()

    let movieAccountState = BehaviorBindable<MovieAccountStateModel?>(nil).eraseToAnyBindable()

    let movieDetailPosterRenderContent = BehaviorBindable<MovieDetailPosterRenderContent?>(nil).eraseToAnyBindable()
    let movieDetailTitleRenderContent = BehaviorBindable<MovieDetailTitleRenderContent?>(nil).eraseToAnyBindable()
    let movieDetailOptionsRenderContent = BehaviorBindable<MovieDetailOptionsRenderContent?>(nil).eraseToAnyBindable()

    // MARK: - Properties

    private(set) var id: Int
    private(set) var title: String
    private(set) var releaseDate: String?
    private(set) var overview: String?
    private(set) var voteAverage: Double?
    private(set) var posterURL: URL?

    private var needsFetch: Bool

    // MARK: - Computed properties

    var screenTitle: String {
        LocalizedStrings.movieDetailTitle()
    }

    var shareTitle: String {
        String(format: LocalizedStrings.movieDetailShareText(), title)
    }

    var cancelTitle: String {
        LocalizedStrings.cancel()
    }

    // MARK: - Initializers

    init(_ movie: MovieProtocol,
         interactor: MovieDetailInteractorProtocol,
         factory: MovieDetailFactoryProtocol) {
        self.id = movie.id
        self.title = movie.title

        self.interactor = interactor
        self.factory = factory

        self.needsFetch = false

        setupMovie(movie)
    }

    init(id: Int, title: String,
         interactor: MovieDetailInteractorProtocol,
         factory: MovieDetailFactoryProtocol) {
        self.id = id
        self.title = title

        self.interactor = interactor
        self.factory = factory

        self.needsFetch = true
    }

    // MARK: - Private

    private func setupMovie(_ movie: MovieProtocol) {
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        posterURL = movie.posterURL

        getMovieGenreName(for: movie.genreIds?.first)

        didSetupMovieDetail.value = true

        movieDetailPosterRenderContent.value = MovieDetailPosterRenderContent(movie: movie)
        movieDetailTitleRenderContent.value = MovieDetailTitleRenderContent(movie: movie)
        movieDetailOptionsRenderContent.value = MovieDetailOptionsRenderContent(options: factory.options)
    }

    private func getMovieGenreName(for genreId: Int?) {
        guard let genreId = genreId else { return }
        interactor.findGenre(with: genreId, completion: { result in
            let genre = try? result.get()
            self.showGenreName.value = genre?.name ?? "-"
        })
    }

    // MARK: - Networking

    func getMovieDetail(showLoader: Bool) {
        fetchMovieDetail(showLoader: showLoader)
    }

    private func fetchMovieDetail(showLoader: Bool = true) {
        guard needsFetch else { return }
        startLoading.value = showLoader
        interactor.getMovieDetail(for: id, completion: { result in
            self.startLoading.value = false
            switch result {
            case .success(let movie):
                self.setupMovie(movie)
                self.checkMovieAccountState()
            case .failure(let error):
                self.showErrorRetryView.send(error)
            }
        })
    }

    func saveVisitedMovie() {
        interactor.saveMovieVisit(with: id, title: title, posterPath: posterURL?.absoluteString)
    }

    // MARK: - Movie account state

    func checkMovieAccountState() {
        guard interactor.isUserSignedIn() else {
            self.movieAccountState.value = nil
            return
        }
        interactor.getMovieAccountState(for: id, completion: { result in
            guard let accountState = result.wrappedValue else {
                self.movieAccountState.value = nil
                return
            }
            self.movieAccountState.value = MovieAccountStateModel.init(accountState)
        })
    }

    // MARK: - Favorites

    func handleFavoriteMovie() {
        guard let currentFavoriteValue = movieAccountState.value?.isFavorite else { return }
        let newFavoriteValue = !currentFavoriteValue
        interactor.markMovieAsFavorite(movieId: id, favorite: newFavoriteValue, completion: { result in
            switch result {
            case .success:
                self.movieAccountState.value?.isFavorite = newFavoriteValue
                let message = newFavoriteValue ? LocalizedStrings.addToFavoritesSuccess() : LocalizedStrings.removeFromFavoritesSuccess()
                self.showSuccessAlert.send(message)
            case .failure(let error):
                self.showErrorAlert.send(error)
            }
        })
    }

    // MARK: - Watchlist

    private func addToWatchlist() {
        interactor.addToWatchlist(movieId: id) { result in
            switch result {
            case .success:
                self.updateWatchlistState(isInWatchlist: true)
            case .failure(let error):
                self.showErrorAlert.send(error)
            }
        }
    }

    private func removeFromWatchlist() {
        interactor.removeFromWatchlist(movieId: id) { result in
            switch result {
            case .success:
                self.updateWatchlistState(isInWatchlist: false)
            case .failure(let error):
                self.showErrorAlert.send(error)
            }
        }
    }

    private func updateWatchlistState(isInWatchlist: Bool) {
        movieAccountState.value?.isInWatchlist = true

        let successMessage = isInWatchlist ? LocalizedStrings.addToWatchlistSuccess() : LocalizedStrings.removeFromWatchlistSuccess()
        showSuccessAlert.send(successMessage)
    }

    // MARK: - Alert actions

    func getAvailableAlertActions() -> [MovieDetailActionModel] {
        var alertActions: [MovieDetailActionModel] = []
        let shareAction = MovieDetailActionModel(title: LocalizedStrings.movieDetailShareActionTitle()) {
            self.didSelectShareAction.send(true)
        }
        alertActions.append(shareAction)
        if let watchlistAction = makeWatchlistAlertAction() { alertActions.append(watchlistAction) }
        return alertActions
    }

    private func makeWatchlistAlertAction() -> MovieDetailActionModel? {
        guard let movieAccountState = movieAccountState.value else { return nil }
        let title = movieAccountState.isInWatchlist ? LocalizedStrings.removeFromWatchlistHint() : LocalizedStrings.addToWatchlistHint()
        let watchlistAction = MovieDetailActionModel(title: title) {
            movieAccountState.isInWatchlist ? self.removeFromWatchlist() : self.addToWatchlist()
        }
        return watchlistAction
    }

}

struct MovieAccountStateModel {

    init(_ accountState: Movie.AccountState) {
        self.isFavorite = accountState.favorite
        self.isInWatchlist = accountState.watchlist
    }

    var isFavorite: Bool
    var isInWatchlist: Bool

}
