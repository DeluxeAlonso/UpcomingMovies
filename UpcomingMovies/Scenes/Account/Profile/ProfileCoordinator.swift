//
//  ProfileCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

final class ProfileCoordinator: BaseCoordinator, ProfileCoordinatorProtocol {

    private let user: UserProtocol
    private weak var delegate: ProfileViewControllerDelegate?

    init(navigationController: UINavigationController, user: UserProtocol, delegate: ProfileViewControllerDelegate?) {
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
