//
//  AuthPermissionCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class AuthPermissionCoordinator: AuthPermissionCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?

    var navigationController: UINavigationController
    var authPermissionURL: URL

    var presentingViewController: UIViewController?
    var authPermissionDelegate: AuthPermissionViewControllerDelegate?

    init(navigationController: UINavigationController,
         authPermissionURL: URL) {
        self.navigationController = navigationController
        self.authPermissionURL = authPermissionURL
    }

    func start() {
        let viewController = AuthPermissionViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: authPermissionURL)
        viewController.delegate = authPermissionDelegate
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: false)

        presentingViewController?.present(navigationController, animated: true, completion: nil)
    }

    func dismiss(completion: (() -> Void)? = nil) {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            completion?()
            self?.parentCoordinator?.childDidFinish()
        }
    }

    func didDismiss() {
        parentCoordinator?.childDidFinish()
    }

}
