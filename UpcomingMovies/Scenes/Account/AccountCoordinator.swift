//
//  AccountCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/20/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class AccountCoordinator: BaseCoordinator, AccountCoordinatorProtocol {

    override func start() {
        let viewController = AccountViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve()
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }

    func embedSignInViewController(on parentViewController: SignInViewControllerDelegate) -> SignInViewController {
        navigationController.setNavigationBarHidden(true, animated: true)

        let viewController = SignInViewController.instantiate()
        viewController.delegate = parentViewController

        parentViewController.add(asChildViewController: viewController)

        return viewController
    }

    func embedProfileViewController(on parentViewController: ProfileViewControllerDelegate,
                                    for user: User?) -> ProfileViewController {
        navigationController.setNavigationBarHidden(false, animated: true)

        let viewController = ProfileViewController.instantiate()

        viewController.viewModel = DIContainer.shared.resolve(argument: user)
        viewController.delegate = parentViewController

        parentViewController.add(asChildViewController: viewController)

        return viewController
    }

    func removeChildViewController<T: UIViewController>(_ viewController: inout T?,
                                                        from parentViewController: UIViewController) {
        parentViewController.remove(asChildViewController: viewController)
        viewController = nil
    }

    func showAuthPermission(for authPermissionURL: URL,
                            and authPermissionDelegate: AuthPermissionViewControllerDelegate) {
        let navigationController = UINavigationController()
        let coordinator = AuthPermissionCoordinator(navigationController: navigationController,
                                                    authPermissionURL: authPermissionURL)
        coordinator.authPermissionDelegate = authPermissionDelegate
        coordinator.presentingViewController = self.navigationController.topViewController
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    func showProfileOption(_ profileOption: ProfileOptionProtocol) {
        guard let profileOption = ProfileOption(rawValue: profileOption.identifier) else { return }
        switch profileOption {
        case .favorites:
            showFavoritesSavedMovies()
        case .watchlist:
            showWatchlistSavedMovies()
        case .recommended:
            showRecommendedMovies()
        case .customLists:
            showCustomLists()
        case .includeAdult:
            break
        }
    }

    // MARK: - Saved Collection Options

    private func showFavoritesSavedMovies() {
        let coordinator = FavoritesSavedMoviesCoordinator(navigationController: navigationController)

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    private func showWatchlistSavedMovies() {
        let coordinator = WatchlistSavedMoviesCoordinator(navigationController: navigationController)

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    // MARK: - Recommended Options

    func showRecommendedMovies() {
        let coordinator = RecommendedMoviesCoordinator(navigationController: navigationController)

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    // MARK: - Profile Group Options

    private func showCustomLists() {
        let coordinator = CustomListsCoordinator(navigationController: navigationController)

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

}

extension AccountCoordinator: RootCoordinator {

    var rootIdentifier: String {
        return RootCoordinatorIdentifier.account
    }

}
