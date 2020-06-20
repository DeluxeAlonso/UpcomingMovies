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

class UpcomingMoviesCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    var navigationDelegate: UpcomingMoviesNavigationDelegate!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UpcomingMoviesViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let contentHandler = UpcomingMoviesContentHandler(movieUseCase: useCaseProvider.movieUseCase())
        let viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider,
                                                contentHandler: contentHandler)
        
        viewController.coordinator = self
        viewController.viewModel = viewModel
        
        setNavigationDelegate()
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Navigation
    
    func showDetail(for movie: Movie, with navigationConfiguration: NavigationConfiguration?) {
        configureNavigationDelegate(with: navigationConfiguration)
        
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController: navigationController)
        movieDetailCoordinator.movie = movie
        movieDetailCoordinator.parentCoordinator = self
        
        childCoordinators.append(movieDetailCoordinator)
        movieDetailCoordinator.start()
    }
    
    // MARK: - Navigation Configuration
    
    func setNavigationDelegate() {
        navigationDelegate = UpcomingMoviesNavigationDelegate()
        navigationDelegate.parentCoordinator = self
        
        navigationController.delegate = navigationDelegate
    }
    
    private func configureNavigationDelegate(with navigationConfiguration: NavigationConfiguration?) {
        guard let navigationConfiguration = navigationConfiguration else { return }
        
        navigationDelegate.configure(selectedFrame: navigationConfiguration.selectedFrame,
                                     with: navigationConfiguration.imageToTransition)
        navigationDelegate.updateOffset(navigationConfiguration.transitionOffset)
    }
    
}
