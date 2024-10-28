//
//  DeepLinkHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 20/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UIKit

final class DeepLinkHandler: DeepLinkHandlerProtocol {

    private(set) var rootCoordinators: [RootCoordinator] = []

    func register(rootCoordinators: [RootCoordinator]) {
        self.rootCoordinators = rootCoordinators
    }

    func handleDeepLinkUrl(_ url: URL, in window: UIWindow?) {
        guard let urlHost = url.host, let host = DeepLinkDestination(rawValue: urlHost) else {
            return
        }
        switch host {
        case .upcomingMovies:
            changeTabBarToSelectedIndex(RootCoordinatorIdentifier.upcomingMovies, from: window)
        case .searchMovies:
            changeTabBarToSelectedIndex(RootCoordinatorIdentifier.searchMovies, from: window)
        case .favorites:
            changeTabBarToSelectedIndex(RootCoordinatorIdentifier.account, from: window)
            let parentCoordinator = currentParentCoordinator(for: RootCoordinatorIdentifier.account)
            let coordinator = FavoritesSavedMoviesCoordinator(navigationController: parentCoordinator.navigationController)
            coordinator.parentCoordinator = parentCoordinator
            parentCoordinator.childCoordinators.append(coordinator)
            coordinator.start()
        }
    }

    // MARK: - Private

    private func currentParentCoordinator(for rootCoordinatorIdentifier: String) -> Coordinator {
        let rootCoordinator = rootCoordinators[index(for: rootCoordinatorIdentifier)]
        return rootCoordinator.childCoordinators.last?.unwrappedParentCoordinator ?? rootCoordinator
    }

    private func changeTabBarToSelectedIndex(_ rootIdentifier: String, from window: UIWindow?) {
        let selectedIndex = index(for: rootIdentifier)
        guard let tabBarController = window?.rootViewController as? MainTabBarController else {
            return
        }
        tabBarController.setSelectedIndex(selectedIndex)
    }

    private func index(for rootIdentifier: String) -> Int {
        let coordinatorIdentifiers = rootCoordinators.map { $0.rootIdentifier }
        guard let indexToSelect = coordinatorIdentifiers.firstIndex(of: rootIdentifier) else {
            fatalError()
        }

        return indexToSelect
    }

}
