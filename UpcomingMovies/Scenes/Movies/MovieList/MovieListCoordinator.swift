//
//  MovieListCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/20/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol MovieListCoordinator: Coordinator {
    
}

class PopularMoviesCoordinator: MovieListCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieListViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let contentHandler = PopularMoviesContentHandler(movieUseCase: useCaseProvider.movieUseCase())
        let viewModel = MovieListViewModel(useCaseProvider: useCaseProvider, contentHandler: contentHandler)
        
        viewController.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

class TopRatedMoviesCoordinator: MovieListCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieListViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let contentHandler = TopRatedMoviesContentHandler(movieUseCase: useCaseProvider.movieUseCase())
        let viewModel = MovieListViewModel(useCaseProvider: useCaseProvider, contentHandler: contentHandler)
        
        viewController.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

class SimilarMoviesCoordinator: MovieListCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    var movieId: Int!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieListViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let contentHandler = SimilarMoviesContentHandler(movieUseCase: useCaseProvider.movieUseCase(), movieId: movieId)
        let viewModel = MovieListViewModel(useCaseProvider: useCaseProvider, contentHandler: contentHandler)
        
        viewController.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

class MoviesByGenreCoordinator: MovieListCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    var genreId: Int!
    var genreName: String!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieListViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let contentHandler = MoviesByGenreContentHandler(movieUseCase: useCaseProvider.movieUseCase(),
                                                         genreId: genreId,
                                                         genreName: genreName)
        let viewModel = MovieListViewModel(useCaseProvider: useCaseProvider, contentHandler: contentHandler)
        
        viewController.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
