//
//  MoviesByGenreCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/31/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MoviesByGenreCoordinator: MovieListCoordinatorProtocol, Coordinator, MovieDetailCoordinable {

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

        viewController.viewModel = DIContainer.shared.resolve(name: "MoviesByGenre",
                                                              arguments: genreId, genreName)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
