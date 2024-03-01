//
//  RecommendedMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 29/05/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

final class RecommendedMoviesCoordinator: BaseCoordinator, MovieListCoordinatorProtocol, MovieDetailCoordinable {

    override func build() -> MovieListViewController {
        let viewController = MovieListViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(name: "RecommendedMovies",
                                                              argument: LocalizedStrings.movieListRecommendationsTitle())
        viewController.coordinator = self

        return viewController
    }

}
