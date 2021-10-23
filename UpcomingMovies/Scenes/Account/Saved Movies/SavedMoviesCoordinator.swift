//
//  SavedMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class FavoritesSavedMoviesCoordinator: SavedMoviesCoordinatorProtocol, Coordinator, MovieDetailCoordinable {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = SavedMoviesViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: ProfileOption.favorites.title)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}

class WatchlistSavedMoviesCoordinator: SavedMoviesCoordinatorProtocol, Coordinator, MovieDetailCoordinable {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = SavedMoviesViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: ProfileOption.watchlist.title)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
