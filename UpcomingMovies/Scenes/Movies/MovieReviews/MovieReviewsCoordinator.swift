//
//  MovieReviewsCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/21/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class MovieReviewsCoordinator: BaseCoordinator, MovieReviewsCoordinatorProtocol {

    private let movieId: Int
    private let movieTitle: String

    init(navigationController: UINavigationController, movieId: Int, movieTitle: String) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        super.init(navigationController: navigationController)
    }

    override func build() -> MovieReviewsViewController {
        let viewController = MovieReviewsViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(arguments: movieId, movieTitle)
        viewController.coordinator = self

        return viewController
    }

    func showReviewDetail(for review: ReviewProtocol, transitionView: UIView? = nil) {
        guard let presentingViewController = navigationController.topViewController else { return }

        let coordinator = MovieReviewDetailCoordinator(navigationController: UINavigationController(), review: review)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)

        let transitioningDelegate = ScaleTransitioningDelegate(viewToScale: transitionView)
        let coordinatorModeConfig = CoordinatorModePresentConfiguration(modalPresentationStyle: .fullScreen,
                                                                        transitioningDelegate: transitioningDelegate)
        coordinator.start(coordinatorMode: .present(presentingViewController: presentingViewController,
                                                    configuration: coordinatorModeConfig))
    }

}
