//
//  SimilarMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/31/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class SimilarMoviesCoordinator: BaseCoordinator, MovieListCoordinatorProtocol, MovieDetailCoordinable {

    private let movieId: Int

    init(navigationController: UINavigationController, movieId: Int) {
        self.movieId = movieId
        super.init(navigationController: navigationController)
    }

    override func build() -> MovieListViewController {
        let viewController = MovieListViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(name: "SimilarMovies",
                                                              arguments: LocalizedStrings.similarMoviesTitle(), movieId)
        viewController.coordinator = self

        return viewController
    }

}
