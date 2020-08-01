//
//  MoviesByGenreCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/31/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class MoviesByGenreCoordinator: MovieListCoordinatorProtocol, Coordinator, MovieDetailCoordinable {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    var genreId: Int!
    var genreName: String!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieListViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let interactor = MoviesByGenreInteractor(useCaseProvider: useCaseProvider,
                                                     genreId: genreId,
                                                     genreName: genreName)
        let viewModel = MovieListViewModel(interactor: interactor)
        viewModel.displayTitle = genreName
        
        viewController.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
