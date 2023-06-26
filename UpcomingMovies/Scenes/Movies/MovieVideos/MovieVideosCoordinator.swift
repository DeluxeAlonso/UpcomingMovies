//
//  MovieVideosCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/21/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class MovieVideosCoordinator: BaseCoordinator, MovieVideosCoordinatorProtocol {

    private let movieId: Int
    private let movieTitle: String

    init(navigationController: UINavigationController, movieId: Int, movieTitle: String) {
        self.movieId = movieId
        self.movieTitle = movieTitle
        super.init(navigationController: navigationController)
    }

    override func build() -> MovieVideosViewController {
        let viewController = MovieVideosViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(arguments: movieId, movieTitle)
        viewController.coordinator = self

        return viewController
    }

}
