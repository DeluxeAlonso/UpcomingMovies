//
//  UpcomingMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

struct NavigationConfiguration {
    
    let selectedFrame: CGRect
    let imageToTransition: UIImage?
    let transitionOffset: CGFloat
    
    init(selectedFrame: CGRect, imageToTransition: UIImage?, transitionOffset: CGFloat) {
        self.selectedFrame = selectedFrame
        self.imageToTransition = imageToTransition
        self.transitionOffset = transitionOffset
    }
    
}

class UpcomingMoviesCoordinator: NSObject, Coordinator, UpcomingMoviesCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    var navigationDelegate: UpcomingMoviesNavigationDelegate!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UpcomingMoviesViewController.instantiate()
        
        let interactor = UpcomingMoviesInteractor(useCaseProvider: InjectionFactory.useCaseProvider())
        let viewModel = UpcomingMoviesViewModel(interactor: interactor)
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        setupNavigationDelegate()
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetail(for movie: Movie, with navigationConfiguration: NavigationConfiguration?) {
        configureNavigationDelegate(with: navigationConfiguration)
        
        let coordinator = MovieDetailCoordinator(navigationController: navigationController)
        coordinator.movieInfo = .complete(movie: movie)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    // MARK: - Navigation Configuration
    
    private func setupNavigationDelegate() {
        // We only configure the delegate if it is needed.
        guard navigationController.delegate == nil else { return }
        
        navigationDelegate = UpcomingMoviesNavigation()
        navigationDelegate.parentCoordinator = self
        
        navigationController.delegate = navigationDelegate
    }
    
    private func configureNavigationDelegate(with navigationConfiguration: NavigationConfiguration?) {
        guard let navigationConfiguration = navigationConfiguration else { return }
        setupNavigationDelegate()
        
        navigationDelegate.configure(selectedFrame: navigationConfiguration.selectedFrame,
                                     with: navigationConfiguration.imageToTransition)
        navigationDelegate.updateOffset(navigationConfiguration.transitionOffset)
    }
    
}
