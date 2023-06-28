//
//  MovieDetailOptionsCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 28/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

protocol MovieDetailOptionsCoordinatorProtocol: AnyObject { }

final class MovieDetailOptionsCoordinator: BaseCoordinator, MovieDetailOptionsCoordinatorProtocol {

    private let renderContent: MovieDetailOptionsRenderContent?
    private weak var delegate: MovieDetailOptionsViewControllerDelegate?

    init(navigationController: UINavigationController,
         renderContent: MovieDetailOptionsRenderContent?,
         delegate: MovieDetailOptionsViewControllerDelegate?) {
        self.renderContent = renderContent
        self.delegate = delegate
        super.init(navigationController: navigationController)
    }

    override func build() -> MovieDetailOptionsViewController {
        let viewController = MovieDetailOptionsViewController.instantiate()
        viewController.viewModel = DIContainer.shared.resolve(argument: renderContent)
        viewController.delegate = delegate

        return viewController
    }

}
