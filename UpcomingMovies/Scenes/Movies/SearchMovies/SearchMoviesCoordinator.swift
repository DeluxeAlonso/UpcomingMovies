//
//  SearchMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/18/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class SearchMoviesCoordinator: BaseCoordinator, SearchMoviesCoordinatorProtocol, RootCoordinator, MovieDetailCoordinable {

    // MARK: - Coordinator

    var rootIdentifier: String {
        RootCoordinatorIdentifier.searchMovies
    }

    override func build() -> SearchMoviesViewController {
        let viewController = SearchMoviesViewController.instantiate()
        viewController.coordinator = self

        return viewController
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
        coordinator.start(coordinatorMode: .push)
    }

    func showMoviesByGenre(_ genreId: Int, genreName: String) {
        let coordinator = MoviesByGenreCoordinator(navigationController: navigationController, genreId: genreId, genreName: genreName)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .push)
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
        coordinator.start(coordinatorMode: .push)
    }

    private func showTopRatedMovies() {
        let coordinator = TopRatedMoviesCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .push)
    }

}
