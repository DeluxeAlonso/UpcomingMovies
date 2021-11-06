//
//  AppDelegate.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationHandler: NavigationHandlerProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = DIContainer.shared

        navigationHandler = DIContainer.shared.resolve()

        configureGlobalAppearanceIfNeeded()

        // We configure the remote data source with the API key and the read access token
        let baseConfiguration: BaseConfiguration = PropertyListHelper.decode()
        let remoteDataSource: RemoteDataSourceProtocol = DIContainer.shared.resolve()
        remoteDataSource.configure(with: baseConfiguration.keys.apiKey,
                                   readAccessToken: baseConfiguration.keys.readAccessToken)

        // We handle app launch if it was triggered by a shorcut item
        if let launchOptions = launchOptions,
            let shortcutItem = launchOptions[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            navigationHandler?.handleShortcutItem(shortcutItem, and: window)
        }

        window?.rootViewController = SplashBuilder.buildViewController()

        return true
    }

    func application(_ application: UIApplication,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        navigationHandler?.handleShortcutItem(shortcutItem, and: window)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        navigationHandler?.handleUrlOpeningNavigation(for: url, and: window)
        return true
    }

    /**
     Configures UINavigationBar an UITabBar appearance to have a similar behavior as pre-iOS15.

     In iOS 15, UIKit has extended the usage of the scrollEdgeAppearance,
     which by default produces a transparent background, to all navigation bars.
     The background is controlled by when your scroll view scrolls
     content behind the navigation bar.
     */
    private func configureGlobalAppearanceIfNeeded() {
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance

            let tabBarAppearance = UITabBarAppearance()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
    }

}
