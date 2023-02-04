//
//  UpcomingMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

struct UpcomingMoviesNavigationConfiguration {

    let selectedFrame: CGRect
    let imageToTransition: UIImage?
    let transitionOffset: CGFloat

    init(selectedFrame: CGRect, imageToTransition: UIImage?, transitionOffset: CGFloat) {
        self.selectedFrame = selectedFrame
        self.imageToTransition = imageToTransition
        self.transitionOffset = transitionOffset
    }

}

final class UpcomingMoviesCoordinator: BaseCoordinator, UpcomingMoviesCoordinatorProtocol, RootCoordinator, MovieDetailCoordinable {

    var navigationDelegate: UpcomingMoviesNavigationDelegate?

    // MARK: - Coordinator

    var rootIdentifier: String {
        RootCoordinatorIdentifier.upcomingMovies
    }

    override func start() {
        let viewController = UpcomingMoviesViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve()
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

    func showMovieDetail(for movie: Movie, with navigationConfiguration: UpcomingMoviesNavigationConfiguration?) {
        if let navigationConfiguration = navigationConfiguration {
            configureNavigationDelegate(with: navigationConfiguration)
        }

        showMovieDetail(for: movie)
    }

    // MARK: - Navigation Configuration

    private func setupNavigationDelegate() {
        // We only configure the delegate if it is needed.
        guard navigationController.delegate == nil else { return }

        navigationDelegate = UpcomingMoviesNavigation()
        navigationDelegate?.parentCoordinator = self

        navigationController.delegate = navigationDelegate
    }

    private func configureNavigationDelegate(with navigationConfiguration: UpcomingMoviesNavigationConfiguration) {
        setupNavigationDelegate()

        navigationDelegate?.configure(selectedFrame: navigationConfiguration.selectedFrame,
                                      with: navigationConfiguration.imageToTransition)
        navigationDelegate?.updateOffset(navigationConfiguration.transitionOffset)
    }

}
