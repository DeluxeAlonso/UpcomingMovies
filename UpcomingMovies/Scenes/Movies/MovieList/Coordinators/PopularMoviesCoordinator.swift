//
//  PopularMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/31/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class PopularMoviesCoordinator: BaseCoordinator, MovieListCoordinatorProtocol, MovieDetailCoordinable {

    override func start() {
        let viewController = MovieListViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(name: "PopularMovies",
                                                              argument: LocalizedStrings.popularMoviesTitle())
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
