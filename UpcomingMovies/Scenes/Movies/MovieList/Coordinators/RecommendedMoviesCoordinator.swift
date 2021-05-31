//
//  RecommendedMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 29/05/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class RecommendedMoviesCoordinator: MovieListCoordinatorProtocol, Coordinator, MovieDetailCoordinable {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MovieListViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(name: "RecommendedMovies",
                                                              argument: "Recommendations")
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
