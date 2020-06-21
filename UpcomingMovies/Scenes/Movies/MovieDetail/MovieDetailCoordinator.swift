//
//  MovieDetailCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/14/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

enum MovieDetailInfo {
    case complete(movie: Movie)
    case partial(movieId: Int, movieTitle: String)
}

class MovieDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    var movieInfo: MovieDetailInfo!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieDetailViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        
        viewController.coordinator = self
        viewController.viewModel = viewModel(for: movieInfo, and: useCaseProvider)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func viewModel(for movieInfo: MovieDetailInfo,
                           and useCaseProvider: UseCaseProviderProtocol) -> MovieDetailViewModel {
        let viewModel: MovieDetailViewModel
        switch movieInfo {
        case .complete(let movie):
            viewModel = MovieDetailViewModel(movie, useCaseProvider: useCaseProvider)
        case .partial(let movieId, let movieTitle):
            viewModel = MovieDetailViewModel(id: movieId, title: movieTitle, useCaseProvider: useCaseProvider)
        }
        
        return viewModel
    }
    
}
