//
//  MovieDetailTitleCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 28/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

protocol MovieDetailTitleCoordinatorProtocol: AnyObject { }

final class MovieDetailTitleCoordinator: BaseCoordinator, MovieDetailTitleCoordinatorProtocol {

    private let renderContent: MovieDetailTitleRenderContent?

    init(navigationController: UINavigationController,
         renderContent: MovieDetailTitleRenderContent?) {
        self.renderContent = renderContent
        super.init(navigationController: navigationController)
    }

    override func build() -> MovieDetailTitleViewController {
        let viewController = MovieDetailTitleViewController.instantiate()
        viewController.viewModel = DIContainer.shared.resolve(argument: renderContent)

        return viewController
    }

}
