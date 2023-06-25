//
//  MovieReviewDetailCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/22/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MovieReviewDetailCoordinator: BaseCoordinator, MovieReviewDetailCoordinatorProtocol {

    private let review: Review

    var presentingViewController: UIViewController?
    var transitioningDelegate: UIViewControllerTransitioningDelegate?

    init(navigationController: UINavigationController, review: Review) {
        self.review = review
        super.init(navigationController: navigationController)
    }

    override func build() -> UIViewController {
        let viewController = MovieReviewDetailViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: review)
        viewController.coordinator = self

        return viewController
    }

//    override func start() {
//        let viewController = build()
//
//        navigationController.pushViewController(viewController, animated: false)
//        navigationController.modalPresentationStyle = .fullScreen
//        navigationController.transitioningDelegate = transitioningDelegate
//
//        presentingViewController?.present(navigationController, animated: true, completion: nil)
//    }

//    override func start() {
//        let viewController = MovieReviewDetailViewController.instantiate()
//
//        viewController.viewModel = DIContainer.shared.resolve(argument: review)
//        viewController.coordinator = self
//
//        navigationController.pushViewController(viewController, animated: false)
//        navigationController.modalPresentationStyle = .fullScreen
//        navigationController.transitioningDelegate = transitioningDelegate
//
//        presentingViewController?.present(navigationController, animated: true, completion: nil)
//    }

    override func dismiss() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
