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

    let startLoading: Bindable<Bool> = Bindable(false)

    let showErrorRetryView: Bindable<Error?> = Bindable(nil)
    let showGenreName: Bindable<String> = Bindable("-")
    let showMovieOptions: Bindable<[MovieDetailOption]> = Bindable([])

    let didSetupMovieDetail: Bindable<Bool> = Bindable(true)

    let showSuccessAlert: Bindable<String> = Bindable("")
    let showErrorAlert: Bindable<Error?> = Bindable(nil)

    let didSelectShareAction: Bindable<Bool> = Bindable(true)

    let movieAccountState: Bindable<MovieAccountStateModel?> = Bindable(nil)

    // MARK: - Properties

    private(set) var id: Int
    private(set) var title: String
    private(set) var releaseDate: String?
    private(set) var overview: String?
    private(set) var voteAverage: Double?
    private(set) var posterURL: URL?
    private(set) var backdropURL: URL?

    private var needsFetch: Bool

    // MARK: - Computed properties

    var screenTitle: String {
        return LocalizedStrings.movieDetailTitle()
    }

    var shareTitle: String {
        return String(format: LocalizedStrings.movieDetailShareText(), title)
    }

    // MARK: - Initializers

    init(_ movie: Movie,
         interactor: MovieDetailInteractorProtocol,
         factory: MovieDetailFactoryProtocol) {
        self.id = movie.id
        self.title = movie.title
        self.interactor = interactor
        self.factory = factory

        self.needsFetch = false

        setupMovie(movie)

        showMovieOptions.value = factory.options
    }

    init(id: Int, title: String,
         interactor: MovieDetailInteractorProtocol,
         factory: MovieDetailFactoryProtocol) {
        self.id = id
        self.title = title
        self.interactor = interactor
        self.factory = factory

        self.needsFetch = true

        showMovieOptions.value = factory.options
    }

    // MARK: - Private

    private func setupMovie(_ movie: Movie) {
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        posterURL = movie.posterURL
        backdropURL = movie.backdropURL

        getMovieGenreName(for: movie.genreIds?.first)

        didSetupMovieDetail.value = true
    }

    private func getMovieGenreName(for genreId: Int?) {
        guard let genreId = genreId else { return }
        interactor.findGenre(with: genreId, completion: { [weak self] result in
            guard let self = self else { return }
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
                self.showErrorRetryView.value = error
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
            guard let accountState = try? result.get() else {
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
                self.showSuccessAlert.value = message
            case .failure(let error):
                self.showErrorAlert.value = error
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
                self.showErrorAlert.value = error
            }
        }
    }

    private func removeFromWatchlist() {
        interactor.removeFromWatchlist(movieId: id) { result in
            switch result {
            case .success:
                self.updateWatchlistState(isInWatchlist: false)
            case .failure(let error):
                self.showErrorAlert.value = error
            }
        }
    }

    private func updateWatchlistState(isInWatchlist: Bool) {
        self.movieAccountState.value?.isInWatchlist = true
        self.showSuccessAlert.value = isInWatchlist ? LocalizedStrings.addToWatchlistSuccess() : LocalizedStrings.removeFromWatchlistSuccess()
    }

    // MARK: - Alert actions

    func getAvailableAlertActions() -> [MovieDetailActionModel] {
        var alertActions: [MovieDetailActionModel] = []
        let shareAction = MovieDetailActionModel(title: LocalizedStrings.movieDetailShareActionTitle()) {
            self.didSelectShareAction.value = true
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
