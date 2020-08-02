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

class MovieDetailCoordinator: Coordinator, MovieDetailCoordinatorProtocol {
    
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
        viewController.viewModel = viewModel(for: movieInfo, and: useCaseProvider)
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showMovieVideos() {
        let coordinator = MovieVideosCoordinator(navigationController: navigationController)
        
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)
        
        coordinator.movieId = movieInfo.id
        coordinator.movieTitle = movieInfo.title
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func showMovieCredits() {
        let coordinator = MovieCreditsCoordinator(navigationController: navigationController)
        
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)
        
        coordinator.movieId = movieInfo.id
        coordinator.movieTitle = movieInfo.title
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func showMovieReviews() {
        let coordinator = MovieReviewsCoordinator(navigationController: navigationController)
        
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)
        
        coordinator.movieId = movieInfo.id
        coordinator.movieTitle = movieInfo.title
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func showSimilarMovies() {
        let coordinator = SimilarMoviesCoordinator(navigationController: navigationController)
        
        let movieInfo = getMoviePartialInfo(for: self.movieInfo)
        
        coordinator.movieId = movieInfo.id
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func viewModel(for movieInfo: MovieDetailInfo,
                           and useCaseProvider: UseCaseProviderProtocol) -> MovieDetailViewModel {
        let interactor = MovieDetailInteractor(useCaseProvider: InjectionFactory.useCaseProvider(),
                                               authHandler: AuthenticationHandler.shared)
        let factory = MovieDetailViewFactory()
        let viewModel: MovieDetailViewModel
        switch movieInfo {
        case .complete(let movie):
            viewModel = MovieDetailViewModel(movie, interactor: interactor, factory: factory)
        case .partial(let movieId, let movieTitle):
            viewModel = MovieDetailViewModel(id: movieId, title: movieTitle,
                                             interactor: interactor, factory: factory)
        }
        
        return viewModel
    }
    
    private func getMoviePartialInfo(for movieInfo: MovieDetailInfo) -> (id: Int, title: String) {
        switch movieInfo {
        case .complete(let movie):
            return (movie.id, movie.title)
        case .partial(let movieId, let movieTitle):
            return (movieId, movieTitle)
        }
    }
    
}
