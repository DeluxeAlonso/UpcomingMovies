//
//  SearchMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/18/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class SearchMoviesCoordinator: SearchMoviesCoordinatorProtocol, Coordinator, MovieDetailCoordinable {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SearchMoviesViewController.instantiate()
        
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    @discardableResult
    func embedSearchOptions(on parentViewController: UIViewController,
                            in containerView: UIView) -> SearchOptionsViewController {
        let viewController = SearchOptionsViewController.instantiate()
        
        let interactor = SearchOptionsInteractor(useCaseProvider: InjectionFactory.useCaseProvider())
        let viewModel = SearchOptionsViewModel(interactor: interactor)
        
        viewController.viewModel = viewModel
        
        parentViewController.add(asChildViewController: viewController,
                                 containerView: containerView)
        
        return viewController
    }
    
    @discardableResult
    func embedSearchController(on parentViewController: SearchMoviesResultControllerDelegate) -> DefaultSearchController {
        let interactor = SearchMoviesResultInteractor(useCaseProvider: InjectionFactory.useCaseProvider(),
                                                      authHandler: DIContainer.shared.resolve(AuthenticationHandlerProtocol.self))
        let searchResultViewModel = SearchMoviesResultViewModel(interactor: interactor)
        let searchResultController = SearchMoviesResultController(viewModel: searchResultViewModel)
        
        let searchController = DefaultSearchController(searchResultsController: searchResultController)
        
        searchResultController.delegate = parentViewController
        searchResultController.coordinator = self
        
        parentViewController.navigationItem.searchController = searchController
        parentViewController.definesPresentationContext = true
        
        return searchController
    }
    
    func showMovieDetail(for movieId: Int, and movieTitle: String) {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController)
        coordinator.movieInfo = .partial(movieId: movieId, movieTitle: movieTitle)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func showMoviesByGenre(_ genreId: Int, genreName: String) {
        let coordinator = MoviesByGenreCoordinator(navigationController: navigationController)
        coordinator.genreId = genreId
        coordinator.genreName = genreName
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func showDefaultSearchOption(_ option: DefaultSearchOption) {
        switch option {
        case .popular:
            showPopularMovies()
        case .topRated:
            showTopRatedMovies()
        }
    }
    
    private func showPopularMovies() {
        let coordinator = PopularMoviesCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func showTopRatedMovies() {
        let coordinator = TopRatedMoviesCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
