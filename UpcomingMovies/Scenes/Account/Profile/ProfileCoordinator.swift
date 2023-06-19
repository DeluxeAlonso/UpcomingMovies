//
//  ProfileCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class ProfileCoordinator: BaseCoordinatorV2, ProfileCoordinatorProtocol {

    private let user: User
    private weak var delegate: ProfileViewControllerDelegate?

    init(navigationController: UINavigationController, user: User, delegate: ProfileViewControllerDelegate?) {
        self.user = user
        self.delegate = delegate
        super.init(navigationController: navigationController)
    }

    override func build() -> ProfileViewController {
        let viewController = ProfileViewController.instantiate()
        viewController.viewModel = DIContainer.shared.resolve(argument: user)
        viewController.delegate = delegate
        return viewController
    }

}
