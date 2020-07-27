//
//  SavedMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class FavoritesSavedMoviesCoordinator: Coordinator, SavedMoviesCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SavedMoviesViewController.instantiate()
        
        let interactor = FavoritesSavedMoviesInteractor(useCaseProvider: InjectionFactory.useCaseProvider())
        let viewModel = SavedMoviesViewModel(interactor: interactor)
        viewModel.title = ProfileCollectionOption.favorites.title
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

class WatchListSavedMoviesCoordinator: Coordinator, SavedMoviesCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SavedMoviesViewController.instantiate()
        
        let interactor = WatchListSavedMoviesInteractor(useCaseProvider: InjectionFactory.useCaseProvider())
        let viewModel = SavedMoviesViewModel(interactor: interactor)
        viewModel.title = ProfileCollectionOption.watchlist.title
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
