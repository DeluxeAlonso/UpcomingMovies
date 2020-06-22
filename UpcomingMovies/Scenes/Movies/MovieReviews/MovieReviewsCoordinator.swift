//
//  MovieReviewsCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/21/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class MovieReviewsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
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
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let viewModel = MovieReviewsViewModel(movieId: movieId, movieTitle: movieTitle,
                                              useCaseProvider: useCaseProvider)
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
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
