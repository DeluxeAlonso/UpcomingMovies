//
//  MovieVideosCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/21/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class MovieVideosCoordinator: BaseCoordinator, MovieVideosCoordinatorProtocol {

    var movieId: Int!
    var movieTitle: String!

//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }

    override func start() {
        let viewController = MovieVideosViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(arguments: movieId, movieTitle)
        viewController.coordinator = self

        if navigationController.delegate == nil {
            navigationController.delegate = self
        }
        navigationController.pushViewController(viewController, animated: true)
    }

}
