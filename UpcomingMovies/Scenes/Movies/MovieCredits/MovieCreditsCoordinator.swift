//
//  MovieCreditsCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/21/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class MovieCreditsCoordinator: Coordinator, MovieCreditsCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var movieId: Int
    var movieTitle: String

    init(navigationController: UINavigationController, movieId: Int, movieTitle: String) {
        self.navigationController = navigationController
        self.movieId = movieId
        self.movieTitle = movieTitle
    }

    func start() {
        let viewController = MovieCreditsViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(arguments: movieId, movieTitle)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
