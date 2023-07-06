//
//  SignInCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

final class SignInCoordinator: BaseCoordinator, SignInCoordinatorProtocol {

    private weak var delegate: SignInViewControllerDelegate?

    init(navigationController: UINavigationController, delegate: SignInViewControllerDelegate?) {
        self.delegate = delegate
        super.init(navigationController: navigationController)
    }

    override func build() -> SignInViewController {
        let viewController = SignInViewController.instantiate()
        viewController.viewModel = DIContainer.shared.resolve()
        viewController.coordinator = self
        viewController.delegate = delegate
        return viewController
    }

    func showAuthPermission(for authPermissionURL: URL,
                            and authPermissionDelegate: AuthPermissionViewControllerDelegate) {
        guard let presentingViewController = navigationController.topViewController else { return }
        let coordinator = AuthPermissionCoordinator(navigationController: UINavigationController(),
                                                    authPermissionURL: authPermissionURL,
                                                    authPermissionDelegate: authPermissionDelegate)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .present(presentingViewController: presentingViewController, configuration: nil))
    }

}
