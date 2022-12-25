//
//  MovieReviewDetailCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/22/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

// TODO: - Make this class inherit from base coordinator
final class MovieReviewDetailCoordinator: Coordinator, MovieReviewDetailCoordinatorProtocol {

    private let review: Review

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var presentingViewController: UIViewController?
    var transitioningDelegate: UIViewControllerTransitioningDelegate?

    init(navigationController: UINavigationController, review: Review) {
        self.navigationController = navigationController
        self.review = review
    }

    func start() {
        let viewController = MovieReviewDetailViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: review)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: false)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.transitioningDelegate = transitioningDelegate

        presentingViewController?.present(navigationController, animated: true, completion: nil)
    }

    func dismiss() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
