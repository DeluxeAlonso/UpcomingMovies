//
//  AuthPermissionCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class AuthPermissionCoordinator: BaseCoordinator, AuthPermissionCoordinatorProtocol {

    private let authPermissionURL: URL
    private let authPermissionDelegate: AuthPermissionViewControllerDelegate?

    init(navigationController: UINavigationController,
         authPermissionURL: URL,
         authPermissionDelegate: AuthPermissionViewControllerDelegate?) {
        self.authPermissionURL = authPermissionURL
        self.authPermissionDelegate = authPermissionDelegate
        super.init(navigationController: navigationController)
    }

    override func build() -> AuthPermissionViewController {
        let viewController = AuthPermissionViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: authPermissionURL)
        viewController.delegate = authPermissionDelegate
        viewController.coordinator = self

        return viewController
    }

    func didDismiss() {
        unwrappedParentCoordinator.childDidFinish()
    }

}
