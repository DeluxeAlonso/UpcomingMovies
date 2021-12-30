//
//  MovieListCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/20/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol MovieListCoordinatorProtocol: Coordinator {}

extension MovieListCoordinatorProtocol {

    func showDetail(for movie: Movie) {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController)
        coordinator.movieInfo = .complete(movie: movie)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

}

class PopularMoviesCoordinator: MovieListCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MovieListViewController.instantiate()

        let useCaseProvider = InjectionFactory.useCaseProvider()
        let contentHandler = PopularMoviesContentHandler(movieUseCase: useCaseProvider.movieUseCase())
        let viewModel = MovieListViewModel(useCaseProvider: useCaseProvider, contentHandler: contentHandler)

        viewController.viewModel = viewModel
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}

class TopRatedMoviesCoordinator: MovieListCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MovieListViewController.instantiate()

        let useCaseProvider = InjectionFactory.useCaseProvider()
        let contentHandler = TopRatedMoviesContentHandler(movieUseCase: useCaseProvider.movieUseCase())
        let viewModel = MovieListViewModel(useCaseProvider: useCaseProvider, contentHandler: contentHandler)

        viewController.coordinator = self
        viewController.viewModel = viewModel

        navigationController.pushViewController(viewController, animated: true)
    }

}

class SimilarMoviesCoordinator: NSObject, MovieListCoordinatorProtocol, UINavigationControllerDelegate {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var movieId: Int!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MovieListViewController.instantiate()

        let useCaseProvider = InjectionFactory.useCaseProvider()
        let contentHandler = SimilarMoviesContentHandler(movieUseCase: useCaseProvider.movieUseCase(), movieId: movieId)
        let viewModel = MovieListViewModel(useCaseProvider: useCaseProvider, contentHandler: contentHandler)

        viewController.coordinator = self
        viewController.viewModel = viewModel

        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

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

class MoviesByGenreCoordinator: MovieListCoordinatorProtocol {

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
        let contentHandler = MoviesByGenreContentHandler(movieUseCase: useCaseProvider.movieUseCase(),
                                                         genreId: genreId,
                                                         genreName: genreName)
        let viewModel = MovieListViewModel(useCaseProvider: useCaseProvider, contentHandler: contentHandler)

        viewController.coordinator = self
        viewController.viewModel = viewModel

        navigationController.pushViewController(viewController, animated: true)
    }

}
