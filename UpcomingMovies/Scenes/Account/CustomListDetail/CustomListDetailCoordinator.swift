//
//  CustomListDetailCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class CustomListDetailCoordinator: BaseCoordinator, CustomListDetailCoordinatorProtocol, MovieDetailCoordinable {

    private let customList: List

    init(navigationController: UINavigationController, customList: List) {
        self.customList = customList
        super.init(navigationController: navigationController)
    }

    override func start() {
        let viewController = CustomListDetailViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: customList)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

}
