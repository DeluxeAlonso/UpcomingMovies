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

    var screenTitle: String { get }
    var shareTitle: String { get }
    var cancelTitle: String { get }

    var startLoading: AnyBehaviorBindable<Bool> { get }
    var showGenreName: AnyBehaviorBindable<String> { get }
    var didSetupMovieDetail: AnyBehaviorBindable<Bool> { get }
    var showSuccessAlert: AnyPublishBindable<String> { get }
    var showErrorAlert: AnyPublishBindable<Error> { get }
    var showErrorRetryView: AnyPublishBindable<Error> { get }
    var didSelectShareAction: AnyPublishBindable<Bool> { get }
    var movieAccountState: AnyBehaviorBindable<MovieAccountStateModel?> { get }

    var movieDetailPosterRenderContent: AnyBehaviorBindable<MovieDetailPosterRenderContent?> { get }
    var movieDetailTitleRenderContent: AnyBehaviorBindable<MovieDetailTitleRenderContent?> { get }
    var movieDetailOptionsRenderContent: AnyBehaviorBindable<MovieDetailOptionsRenderContent?> { get }

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
    func findGenres(for identifiers: [Int], completion: @escaping (Result<[Genre], Error>) -> Void)

    func getMovieDetail(for movieId: Int, completion: @escaping (Result<MovieProtocol, Error>) -> Void)

    func getMovieAccountState(for movieId: Int,
                              completion: @escaping (Result<Movie.AccountState, Error>) -> Void)

    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void)

    func addToWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void)

    func removeFromWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void)

    func saveMovieVisit(with id: Int, title: String, posterPath: String?)

}

protocol MovieDetailFactoryProtocol {

    var options: [MovieDetailOption] { get }

}

protocol MovieDetailCoordinatorProtocol: AnyObject {

    func showMovieOption(_ option: MovieDetailOption)
    func showSharingOptions(withShareTitle title: String)

    func embedMovieDetailOptions(on parentViewController: MovieDetailOptionsViewControllerDelegate,
                                 in containerView: UIView)
    func embedMovieDetailOptions(on parentViewController: MovieDetailOptionsViewControllerDelegate,
                                 in containerView: UIView,
                                 with renderContent: MovieDetailOptionsRenderContent?)

    func embedMovieDetailPoster(on parentViewController: MovieDetailPosterViewControllerDelegate, in containerView: UIView)
    func embedMovieDetailPoster(on parentViewController: MovieDetailPosterViewControllerDelegate,
                                in containerView: UIView,
                                with renderContent: MovieDetailPosterRenderContent?)

    func embedMovieDetailTitle(on parentViewController: UIViewController,
                               in containerView: UIView)
    func embedMovieDetailTitle(on parentViewController: UIViewController,
                               in containerView: UIView,
                               with renderContent: MovieDetailTitleRenderContent?)

    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction])

}

protocol MovieDetailUIHelperProtocol {

    func showHUD(with text: String, in view: UIView)

    func showLoader(in view: UIView)
    func hideLoader()

    func presentRetryView(in view: UIView,
                          with errorMessage: String?,
                          retryHandler: @escaping () -> Void)
    func hideRetryView()

}
