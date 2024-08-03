//
//  SceneDelegate.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationHandler: NavigationHandlerProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        navigationHandler = DIContainer.shared.resolve()

        handleConnectionOptions(connectionOptions)

        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)

        window?.rootViewController = SplashBuilder.buildViewController()
        window?.makeKeyAndVisible()
    }

    func windowScene(_ windowScene: UIWindowScene,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        navigationHandler?.handleShortcutItem(shortcutItem, and: window)
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        navigationHandler?.handleUrlOpeningNavigation(for: url, and: window)
    }

    private func handleConnectionOptions(_ options: UIScene.ConnectionOptions) {
        if let url = options.urlContexts.first?.url {
            navigationHandler?.handleUrlOpeningNavigation(for: url, and: window)
        } else if let shortcutItem = options.shortcutItem {
            navigationHandler?.handleShortcutItem(shortcutItem, and: window)
        }
    }

}
