//
//  UpcomingMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

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
    
    func showDetail(for movie: Movie) {
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
    
    func configureNavigationDelegate(with selectedFrame: CGRect,
                                     and imageToTransiton: UIImage?,
                                     transitionOffset: CGFloat) {
        navigationDelegate.configure(selectedFrame: selectedFrame, with: imageToTransiton)
        navigationDelegate.updateOffset(transitionOffset)
    }
    
}
