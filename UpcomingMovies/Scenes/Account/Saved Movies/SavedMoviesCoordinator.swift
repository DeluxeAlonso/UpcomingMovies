//
//  SavedMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class FavoritesSavedMoviesCoordinator: SavedMoviesCoordinatorProtocol, Coordinator, MovieDetailCoordinable {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SavedMoviesViewController.instantiate()
        
        let interactor = FavoritesSavedMoviesInteractor(useCaseProvider: InjectionManager.shared.resolve(for: UseCaseProviderProtocol.self))
        let viewModel = SavedMoviesViewModel(interactor: interactor)
        viewModel.displayTitle = ProfileCollectionOption.favorites.title
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

class WatchListSavedMoviesCoordinator: SavedMoviesCoordinatorProtocol, Coordinator, MovieDetailCoordinable {
    
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
        viewModel.displayTitle = ProfileCollectionOption.watchlist.title
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
