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

final class MovieDetailCoordinator: BaseCoordinator, MovieDetailCoordinatorProtocol {

    private let movieInfo: MovieDetailInfo

    private var movieDetailPosterViewController: MovieDetailPosterViewController?
    private var movieDetailOptionsViewController: MovieDetailOptionsViewController?

    // MARK: - Initializers

    init(navigationController: UINavigationController, movieInfo: MovieDetailInfo) {
        self.movieInfo = movieInfo
        super.init(navigationController: navigationController)
    }

    // MARK: - MovieDetailCoordinatorProtocol

    override func start() {
        let viewController = MovieDetailViewController.instantiate()

        viewController.viewModel = viewModel(for: movieInfo)
        viewController.userInterfaceHelper = DIContainer.shared.resolve()
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
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

    func embedMovieDetailPoster(on parentViewController: MovieDetailPosterViewControllerDelegate,
                                in containerView: UIView,
                                with backdropURL: URL?,
                                and posterURL: URL?) {
        guard movieDetailPosterViewController == nil else {
            let viewModel = MovieDetailPosterViewModel(backdropURL: backdropURL, posterURL: posterURL)
            movieDetailPosterViewController?.update(with: viewModel)
            return
        }

        let viewController = MovieDetailPosterViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(arguments: backdropURL, posterURL)
        viewController.delegate = parentViewController

        parentViewController.add(asChildViewController: viewController, containerView: containerView)

        self.movieDetailPosterViewController = viewController
    }

    func embedMovieDetailOptions(on parentViewController: MovieDetailOptionsViewControllerDelegate,
                                 in containerView: UIView,
                                 with options: [MovieDetailOption]) {
        guard movieDetailOptionsViewController == nil else { return }

        let viewController = MovieDetailOptionsViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: options)
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
        coordinator.start()
    }

    private func showMovieCredits() {
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)

        let coordinator = MovieCreditsCoordinator(navigationController: navigationController, movieId: movieInfo.id, movieTitle: movieInfo.title)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    private func showMovieReviews() {
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)

        let coordinator = MovieReviewsCoordinator(navigationController: navigationController,
                                                  movieId: movieInfo.id,
                                                  movieTitle: movieInfo.title)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    private func showSimilarMovies() {
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)

        let coordinator = SimilarMoviesCoordinator(navigationController: navigationController, movieId: movieInfo.id)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
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
