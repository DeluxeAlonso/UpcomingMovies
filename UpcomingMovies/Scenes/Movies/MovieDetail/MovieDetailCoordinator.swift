//
//  MovieDetailCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/14/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

enum MovieDetailInfo {

    case complete(movie: MovieProtocol)
    case partial(movieId: Int, movieTitle: String)

}

final class MovieDetailCoordinator: BaseCoordinator, MovieDetailCoordinatorProtocol {

    private let movieInfo: MovieDetailInfo

    private var movieDetailPosterCoordinator: MovieDetailPosterCoordinator?
    private var movieDetailTitleCoordinator: MovieDetailTitleCoordinator?
    private var movieDetailOptionsCoordinator: MovieDetailOptionsCoordinator?

    // MARK: - Initializers

    init(navigationController: UINavigationController,
         movieInfo: MovieDetailInfo) {
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
        if movieDetailPosterCoordinator != nil {
            movieDetailPosterCoordinator?.dismiss()
            movieDetailPosterCoordinator = nil
        }

        let coordinator = MovieDetailPosterCoordinator(navigationController: navigationController,
                                                       renderContent: renderContent,
                                                       delegate: parentViewController)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        movieDetailPosterCoordinator = coordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .embed(parentViewController: parentViewController, containerView: containerView))
    }

    func embedMovieDetailTitle(on parentViewController: UIViewController,
                               in containerView: UIView) {
        embedMovieDetailTitle(on: parentViewController,
                              in: containerView,
                              with: nil)
    }

    func embedMovieDetailTitle(on parentViewController: UIViewController,
                               in containerView: UIView,
                               with renderContent: MovieDetailTitleRenderContent?) {
        if movieDetailTitleCoordinator != nil {
            movieDetailTitleCoordinator?.dismiss()
            movieDetailTitleCoordinator = nil
        }
        let coordinator = MovieDetailTitleCoordinator(navigationController: navigationController, renderContent: renderContent)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        movieDetailTitleCoordinator = coordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .embed(parentViewController: parentViewController, containerView: containerView))
    }

    func embedMovieDetailOptions(on parentViewController: MovieDetailOptionsViewControllerDelegate,
                                 in containerView: UIView) {
        embedMovieDetailOptions(on: parentViewController, in: containerView, with: nil)
    }

    func embedMovieDetailOptions(on parentViewController: MovieDetailOptionsViewControllerDelegate,
                                 in containerView: UIView,
                                 with renderContent: MovieDetailOptionsRenderContent?) {
        if movieDetailOptionsCoordinator != nil {
            movieDetailOptionsCoordinator?.dismiss()
            movieDetailOptionsCoordinator = nil
        }
        let coordinator = MovieDetailOptionsCoordinator(navigationController: navigationController,
                                                        renderContent: renderContent,
                                                        delegate: parentViewController)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        movieDetailOptionsCoordinator = coordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .embed(parentViewController: parentViewController, containerView: containerView))
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
