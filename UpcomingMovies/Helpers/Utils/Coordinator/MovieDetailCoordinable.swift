//
//  MovieDetailCoordinable.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/26/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol MovieDetailCoordinable {

    func showMovieDetail(for movie: Movie)

}

extension MovieDetailCoordinable where Self: Coordinator {

    func showMovieDetail(for movie: Movie) {
        let movieInfo = MovieDetailInfo.complete(movie: movie)

        let coordinator = MovieDetailCoordinator(navigationController: navigationController, movieInfo: movieInfo)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .push)
    }

}
