//
//  MoviesByGenreCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/31/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MoviesByGenreCoordinator: BaseCoordinator, MovieListCoordinatorProtocol, MovieDetailCoordinable {

    private let genreId: Int
    private let genreName: String

    init(navigationController: UINavigationController, genreId: Int, genreName: String) {
        self.genreId = genreId
        self.genreName = genreName
        super.init(navigationController: navigationController)
    }

    override func start() {
        let viewController = MovieListViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(name: "MoviesByGenre",
                                                              arguments: genreId, genreName)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
