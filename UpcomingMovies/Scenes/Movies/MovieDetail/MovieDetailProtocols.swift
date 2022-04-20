//
//  MovieDetailProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol MovieDetailViewModelProtocol {

    var id: Int { get }
    var title: String { get }
    var releaseDate: String? { get }
    var overview: String? { get }
    var voteAverage: Double? { get }
    var posterURL: URL? { get }
    var backdropURL: URL? { get }

    var needsFetch: Bool { get }

    var startLoading: Bindable<Bool> { get }
    var isFavorite: Bindable<Bool> { get }
    var showErrorView: Bindable<Error?> { get }
    var showGenreName: Bindable<String> { get }
    var showMovieOptions: Bindable<[MovieDetailOption]> { get }
    var didSetupMovieDetail: Bindable<Bool> { get }
    var didUpdateFavoriteSuccess: Bindable<Bool> { get }
    var didUpdateFavoriteFailure: Bindable<Error?> { get }
    var didSelectShareAction: Bindable<Bool> { get }

    var shouldHideFavoriteButton: (() -> Void)? { get set }

    func getAvailableAlertActions() -> [MovieDetailActionModel]

    /**
     * Retrieves movie detail information.
     * - Parameters:
     *      - showLoader: Indicates if loader should be triggered or not.
     */
    func getMovieDetail(showLoader: Bool)

    /**
     * Saves currently presented movie detail as a visited movie.
     */
    func saveVisitedMovie()

    /**
     * Checks the movie account state: if it is included in favorites or watchlist.
     */
    func checkMovieAccountState()

    /**
     * Marks a movie as a favorite or non-favorite given the current favorite state of the presented movie.
     */
    func handleFavoriteMovie()

}

protocol MovieDetailInteractorProtocol {

    func isUserSignedIn() -> Bool

    func findGenre(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void)

    func getMovieDetail(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void)

    func getMovieAccountState(for movieId: Int,
                              completion: @escaping (Result<Movie.AccountState, Error>) -> Void)

    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void)

    func saveMovieVisit(with id: Int, title: String, posterPath: String?)

}

protocol MovieDetailFactoryProtocol {

    var options: [MovieDetailOption] { get }

}

protocol MovieDetailCoordinatorProtocol: AnyObject {

    func showMovieOption(_ option: MovieDetailOption)
    func showSharingOptions(withShareTitle title: String)

}

protocol MovieDetailUIHelperProtocol {

    func showHUD(with text: String)

    func showFullscreenLoader(in view: UIView)
    func dismissFullscreenLoader()

    func presentRetryView(in view: UIView,
                          with errorMessage: String?,
                          retryHandler: @escaping () -> Void)
    func hideRetryView()

}
