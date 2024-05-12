//
//  MovieReviewDetailCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/22/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class MovieReviewDetailCoordinator: BaseCoordinator, MovieReviewDetailCoordinatorProtocol {

    private let review: ReviewProtocol
    var transitioningDelegate: UIViewControllerTransitioningDelegate?

    init(navigationController: UINavigationController, review: ReviewProtocol) {
        self.review = review
        super.init(navigationController: navigationController)
    }

    override func build() -> MovieReviewDetailViewController {
        let viewController = MovieReviewDetailViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: review)
        viewController.coordinator = self

        return viewController
    }

}
