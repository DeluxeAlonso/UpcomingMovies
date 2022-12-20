//
//  TopRatedMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/31/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class TopRatedMoviesCoordinator: BaseCoordinator, MovieListCoordinatorProtocol, MovieDetailCoordinable {

    override func start() {
        let viewController = MovieListViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(name: "TopRatedMovies",
                                                              argument: LocalizedStrings.topRatedMoviesTitle())
        viewController.coordinator = self

        if navigationController.delegate == nil {
            navigationController.delegate = self
        }
        navigationController.pushViewController(viewController, animated: true)
    }

}
