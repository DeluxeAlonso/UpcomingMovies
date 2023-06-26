//
//  MovieDetailCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/14/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

enum MovieDetailInfo {

    case complete(movie: Movie)
    case partial(movieId: Int, movieTitle: String)

}

// TODO: - Adds unit tests for MovieDetailCoordinator
final class MovieDetailCoordinator: BaseCoordinator, MovieDetailCoordinatorProtocol {

    private let movieInfo: MovieDetailInfo

    private var movieDetailPosterViewController: MovieDetailPosterViewController?
    private var movieDetailTitleViewController: MovieDetailTitleViewController?
    private var movieDetailOptionsViewController: MovieDetailOptionsViewController?

    // MARK: - Initializers

    init(navigationController: UINavigationController, movieInfo: MovieDetailInfo) {
        self.movieInfo = movieInfo
        super.init(navigationController: navigationController)
    }

    // MARK: - MovieDetailCoordinatorProtocol

    override func build() -> MovieDetailViewController {
        let viewController = MovieDetailViewController.instantiate()

        viewController.viewModel = viewModel(for: movieInfo)
        viewController.userInterfaceHelper = DIContainer.shared.resolve()
        viewController.coordinator = self

        return viewController
    }

    // MARK: - MovieDetailCoordinatorProtocol

    func showMovieOption(_ option: MovieDetailOption) {
        switch option {
        case .credits: showMovieCredits()
        case .reviews: showMovieReviews()
        case .trailers: showMovieVideos()
        case .similarMovies: showSimilarMovies()
        }
    }

    func showSharingOptions(withShareTitle title: String) {
        let activityViewController = UIActivityViewController(activityItems: [title],
                                                              applicationActivities: nil)
        navigationController.present(activityViewController, animated: true, completion: nil)
    }

    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction]) {
        let actionSheet = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .actionSheet)

        for action in actions { actionSheet.addAction(action) }
        navigationController.present(actionSheet, animated: true, completion: nil)
    }

    func embedMovieDetailPoster(on parentViewController: MovieDetailPosterViewControllerDelegate, in containerView: UIView) {
        embedMovieDetailPoster(on: parentViewController, in: containerView, with: nil)
    }

    func embedMovieDetailPoster(on parentViewController: MovieDetailPosterViewControllerDelegate,
                                in containerView: UIView,
                                with renderContent: MovieDetailPosterRenderContent?) {
        let viewModel: MovieDetailPosterViewModelProtocol = DIContainer.shared.resolve(argument: renderContent)
        guard movieDetailPosterViewController == nil else {
            movieDetailPosterViewController?.update(with: viewModel)
            return
        }

        let viewController = MovieDetailPosterViewController.instantiate()

        viewController.viewModel = viewModel
        viewController.delegate = parentViewController

        parentViewController.add(asChildViewController: viewController, containerView: containerView)

        self.movieDetailPosterViewController = viewController
    }

    func embedMovieDetailTitle(on parentViewController: UIViewController,
                               in containerView: UIView) {
        embedMovieDetailTitle(on: parentViewController,
                              in: containerView,
                              with: nil)
    }

    var viewModel: MovieDetailTitleViewModelProtocol?
    func embedMovieDetailTitle(on parentViewController: UIViewController,
                               in containerView: UIView,
                               with renderContent: MovieDetailTitleRenderContent?) {
        let viewModel: MovieDetailTitleViewModelProtocol = DIContainer.shared.resolve(argument: renderContent)
        self.viewModel = viewModel
        guard movieDetailTitleViewController == nil else {
            movieDetailTitleViewController?.update(with: viewModel)
            return
        }
        let viewController = MovieDetailTitleViewController.instantiate()

        viewController.viewModel = viewModel
        parentViewController.add(asChildViewController: viewController, containerView: containerView)

        self.movieDetailTitleViewController = viewController
    }

    func embedMovieDetailOptions(on parentViewController: MovieDetailOptionsViewControllerDelegate,
                                 in containerView: UIView) {
        embedMovieDetailOptions(on: parentViewController, in: containerView, with: nil)
    }

    func embedMovieDetailOptions(on parentViewController: MovieDetailOptionsViewControllerDelegate,
                                 in containerView: UIView,
                                 with renderContent: MovieDetailOptionsRenderContent?) {
        let viewModel: MovieDetailOptionsViewModelProtocol = DIContainer.shared.resolve(argument: renderContent)
        guard movieDetailOptionsViewController == nil else {
            movieDetailOptionsViewController?.update(with: viewModel)
            return
        }

        let viewController = MovieDetailOptionsViewController.instantiate()

        viewController.viewModel = viewModel
        viewController.delegate = parentViewController

        parentViewController.add(asChildViewController: viewController, containerView: containerView)

        self.movieDetailOptionsViewController = viewController
    }

    // MARK: - Private

    private func showMovieVideos() {
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)

        let coordinator = MovieVideosCoordinator(navigationController: navigationController, movieId: movieInfo.id, movieTitle: movieInfo.title)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .push)
    }

    private func showMovieCredits() {
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)

        let coordinator = MovieCreditsCoordinator(navigationController: navigationController, movieId: movieInfo.id, movieTitle: movieInfo.title)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .push)
    }

    private func showMovieReviews() {
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)

        let coordinator = MovieReviewsCoordinator(navigationController: navigationController,
                                                  movieId: movieInfo.id,
                                                  movieTitle: movieInfo.title)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .push)
    }

    private func showSimilarMovies() {
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)

        let coordinator = SimilarMoviesCoordinator(navigationController: navigationController, movieId: movieInfo.id)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .push)
    }

    private func viewModel(for movieInfo: MovieDetailInfo) -> MovieDetailViewModelProtocol {
        switch movieInfo {
        case .complete(let movie):
            return DIContainer.shared.resolve(argument: movie)
        case .partial(let movieId, let movieTitle):
            return DIContainer.shared.resolve(arguments: movieId, movieTitle)
        }
    }

    private func getMoviePartialInfo(for movieInfo: MovieDetailInfo) -> (id: Int, title: String) {
        switch movieInfo {
        case .complete(let movie):
            return (movie.id, movie.title)
        case .partial(let movieId, let movieTitle):
            return (movieId, movieTitle)
        }
    }

}
