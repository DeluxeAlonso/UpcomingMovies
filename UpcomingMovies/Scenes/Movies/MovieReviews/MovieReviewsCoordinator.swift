//
//  MovieReviewsCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/21/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MovieReviewsCoordinator: NSObject, Coordinator, MovieReviewsCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    var movieId: Int!
    var movieTitle: String!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieReviewsViewController.instantiate()
        
        let interactor = MovieReviewsInteractor(useCaseProvider: InjectionFactory.useCaseProvider())
        let viewModel = MovieReviewsViewModel(movieId: movieId,
                                              movieTitle: movieTitle,
                                              interactor: interactor)
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showReviewDetail(for review: Review, transitionView: UIView? = nil) {
        let navigationController = UINavigationController()
        let coordinator = MovieReviewDetailCoordinator(navigationController: navigationController)

        coordinator.review = review
        coordinator.presentingViewController = self.navigationController.topViewController
        coordinator.parentCoordinator = unwrappedParentCoordinator
        coordinator.transitioningDelegate = ScaleTransitioningDelegate(viewToScale: transitionView)
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}

// MARK: - UINavigationControllerDelegate

extension MovieReviewsCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        unwrappedParentCoordinator.childDidFinish()
    }
    
}
