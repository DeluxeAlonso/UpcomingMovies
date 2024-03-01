//
//  PopularMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/31/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

final class PopularMoviesCoordinator: BaseCoordinator, MovieListCoordinatorProtocol, MovieDetailCoordinable {

    override func build() -> MovieListViewController {
        let viewController = MovieListViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(name: "PopularMovies",
                                                              argument: LocalizedStrings.popularMoviesTitle())
        viewController.coordinator = self

        return viewController
    }

}
