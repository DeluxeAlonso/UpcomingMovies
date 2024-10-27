//
//  NavigationHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class NavigationHandler: NavigationHandlerProtocol {

    private let deepLinkHandler: DeepLinkHandlerProtocol
    private let rootCoordinators: [RootCoordinator] = MainTabBarBuilder.buildViewCoordinators()

    private var initialTransitionCompleted: Bool = false
    private var onInitialTransition: ((UIWindow?) -> Void)?

    // MARK: - Initializers

    init(deepLinkHandler: DeepLinkHandlerProtocol) {
        self.deepLinkHandler = deepLinkHandler
        self.deepLinkHandler.register(rootCoordinators: rootCoordinators)
    }

    // MARK: - NavigationHandlerProtocol

    func initialTransition(from window: UIWindow?) {
        guard let window = window else { return }
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [UIView.AnimationOptions.curveEaseOut,
                                    UIView.AnimationOptions.transitionCrossDissolve],
                          animations: {},
                          completion: { _ in
            let mainTabBarController = MainTabBarController(coordinators: self.rootCoordinators)
            window.rootViewController = mainTabBarController
            self.onInitialTransition?(window) ?? mainTabBarController.setSelectedIndex(0)
            self.initialTransitionCompleted = true
        })
    }

    func handleUrlOpeningNavigation(for url: URL?, and window: UIWindow?) {
        guard let url else { return }

        if url.scheme == AppExtension.scheme {
            self.onInitialTransition = { window in self.handleDeepLink(url, and: window) }
            if initialTransitionCompleted {
                onInitialTransition?(window)
            }
        }
    }

    private func handleDeepLink(_ url: URL, and window: UIWindow?) {
        deepLinkHandler.handleDeepLinkUrl(url, in: window)
    }

    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem, and window: UIWindow?) {
        guard let shorcut = AppShortcutItem(rawValue: shortcutItem.type) else { return }
        switch shorcut {
        case .searchMovies:
            changeTabBarToSelectedIndex(RootCoordinatorIdentifier.searchMovies, from: window)
        }
    }

    // MARK: - Private

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
