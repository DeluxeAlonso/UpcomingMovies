//
//  CustomListDetailCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class CustomListDetailCoordinator: CustomListDetailCoordinatorProtocol, Coordinator, MovieDetailCoordinable {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var customList: List!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = CustomListDetailViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: customList)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
