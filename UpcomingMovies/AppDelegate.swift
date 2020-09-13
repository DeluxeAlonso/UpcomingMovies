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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let launchOptions = launchOptions,
            let shortcutItem = launchOptions[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            NavigationHandler.shared.handleShortcutItem(shortcutItem, and: window)
        }
        
        _ = InjectionManager.shared
        
        return true
    }
    
    func application(_ application: UIApplication,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        NavigationHandler.shared.handleShortcutItem(shortcutItem, and: window)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        guard let urlString = url.scheme else { return false }
        NavigationHandler.shared.handleUrlOpeningNavigation(for: urlString, and: window)
        return true
    }
    
}
