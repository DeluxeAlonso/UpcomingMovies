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
        
        var viewModel = InjectionManager.shared.resolve(for: SavedMoviesViewModelProtocol.self,
                                                        argument: "Favorites")
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
        
        var viewModel = InjectionManager.shared.resolve(for: SavedMoviesViewModelProtocol.self,
                                                        argument: "Watchlist")
        viewModel.displayTitle = ProfileCollectionOption.watchlist.title
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
