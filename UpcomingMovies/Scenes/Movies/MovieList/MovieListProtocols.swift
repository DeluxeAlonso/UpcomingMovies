//
//  MovieListProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol MovieListViewModelProtocol: MoviesViewModel {
        
    var movieCells: [MovieCellViewModel] { get }
    
}

protocol MovieListCoordinatorProtocol: Coordinator {
    
    func showDetail(for movie: Movie)
    
}

extension MovieListCoordinatorProtocol {
    
    func showDetail(for movie: Movie) {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController)
        coordinator.movieInfo = .complete(movie: movie)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
