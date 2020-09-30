//
//  AppDelegate.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationHandler: NavigationHandlerProtocol?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let container = DIContainer.shared
        navigationHandler = container.resolve()
        
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
        guard let urlString = url.scheme else { return false }
        navigationHandler?.handleUrlOpeningNavigation(for: urlString, and: window)
        return true
    }
    
}
