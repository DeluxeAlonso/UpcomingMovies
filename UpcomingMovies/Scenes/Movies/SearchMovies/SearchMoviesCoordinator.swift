//
//  SearchMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/18/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class SearchMoviesCoordinator: NSObject, SearchMoviesCoordinatorProtocol, RootCoordinator, MovieDetailCoordinable {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    // MARK: - Initializers

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    var rootIdentifier: String {
        return RootCoordinatorIdentifier.searchMovies
    }

    func start() {
        let viewController = SearchMoviesViewController.instantiate()

        viewController.coordinator = self

        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func embedSearchOptions(on parentViewController: UIViewController,
                            in containerView: UIView) -> SearchOptionsViewController {
        let viewController = SearchOptionsViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve()

        parentViewController.add(asChildViewController: viewController,
                                 containerView: containerView)

        return viewController
    }

    func embedSearchController(on parentViewController: SearchMoviesResultControllerDelegate) -> SearchController {
        let searchResultController = SearchMoviesResultController(viewModel: DIContainer.shared.resolve())

        let searchController = SearchController(searchResultsController: searchResultController,
                                                hidesNavigationBarDuringPresentation: false,
                                                searchBarStyle: .minimal)

        searchResultController.delegate = parentViewController
        searchResultController.coordinator = self

        parentViewController.navigationItem.searchController = searchController
        parentViewController.definesPresentationContext = true

        return searchController
    }

    func showMovieDetail(for movieId: Int, and movieTitle: String) {
        let movieInfo = MovieDetailInfo.partial(movieId: movieId, movieTitle: movieTitle)

        let coordinator = MovieDetailCoordinator(navigationController: navigationController, movieInfo: movieInfo)
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

// MARK: - UINavigationControllerDelegate

 extension SearchMoviesCoordinator: UINavigationControllerDelegate {

     func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
         guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
             return
         }
         // Check whether our view controller array already contains that view controller.
         // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
         if navigationController.viewControllers.contains(fromViewController) {
             return
         }
         unwrappedParentCoordinator.childDidFinish()
     }

 }
