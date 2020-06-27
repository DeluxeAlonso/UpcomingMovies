//
//  MovieReviewDetailCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/22/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MovieReviewDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    var review: Review!
    var presentingViewController: UIViewController!
    var transitioningDelegate: UIViewControllerTransitioningDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieReviewDetailViewController.instantiate()
        let viewModel = MovieReviewDetailViewModel(review: review)
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: false)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.transitioningDelegate = transitioningDelegate
        
        presentingViewController.present(navigationController, animated: true, completion: nil)
    }
    
    func dismiss() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }
    
}
