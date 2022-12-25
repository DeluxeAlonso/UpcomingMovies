//
//  MovieReviewsCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/21/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MovieReviewsCoordinator: BaseCoordinator, MovieReviewsCoordinatorProtocol {

    private let movieId: Int
    private let movieTitle: String

    init(navigationController: UINavigationController, movieId: Int, movieTitle: String) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        super.init(navigationController: navigationController)
    }

    override func start() {
        let viewController = MovieReviewsViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(arguments: movieId, movieTitle)
        viewController.coordinator = self

        if navigationController.delegate == nil {
            navigationController.delegate = self
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func showReviewDetail(for review: Review, transitionView: UIView? = nil) {
        let navigationController = UINavigationController()
        let coordinator = MovieReviewDetailCoordinator(navigationController: navigationController, review: review)

        coordinator.presentingViewController = self.navigationController.topViewController
        coordinator.parentCoordinator = unwrappedParentCoordinator
        coordinator.transitioningDelegate = ScaleTransitioningDelegate(viewToScale: transitionView)

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

}
