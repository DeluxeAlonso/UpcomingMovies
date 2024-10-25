//
//  AccountCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/20/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class AccountCoordinator: BaseCoordinator, AccountCoordinatorProtocol {

    private var profileCoordinator: ProfileCoordinator?
    private var signInCoordinator: SignInCoordinator?

    override func build() -> AccountViewController {
        let viewController = AccountViewController.instantiate()
        viewController.viewModel = DIContainer.shared.resolve()
        viewController.coordinator = self

        return viewController
    }

    func embedSignInViewController(on parentViewController: SignInViewControllerDelegate) {
        navigationController.setNavigationBarHidden(true, animated: true)

        let coordinator = SignInCoordinator(navigationController: navigationController,
                                            delegate: parentViewController)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        signInCoordinator = coordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .embed(parentViewController: parentViewController, containerView: nil))
    }

    func embedProfileViewController(on parentViewController: ProfileViewControllerDelegate, for user: UserProtocol) {
        navigationController.setNavigationBarHidden(false, animated: true)

        let coordinator = ProfileCoordinator(navigationController: navigationController, user: user, delegate: parentViewController)
        coordinator.parentCoordinator = unwrappedParentCoordinator
        profileCoordinator = coordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .embed(parentViewController: parentViewController, containerView: nil))
    }

    func removeSignInViewController(from parentViewController: UIViewController) {
        signInCoordinator?.dismiss()
        signInCoordinator = nil
    }

    func removeProfileViewController(from parentViewController: UIViewController) {
        profileCoordinator?.dismiss()
        profileCoordinator = nil
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
        coordinator.start(coordinatorMode: .push)
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
        RootCoordinatorIdentifier.account
    }

}
