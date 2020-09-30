//
//  ConnectionOptions+Extensions.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
extension UIScene.ConnectionOptions {
    
    func checkForURLOpening(for window: UIWindow?) {
        if let url = urlContexts.first?.url {
            let navigationHandler: NavigationHandlerProtocol = DIContainer.shared.resolve()
            navigationHandler.handleUrlOpeningNavigation(for: url.absoluteString, and: window)
        }
    }
    
    func checkForShortcutItem(for window: UIWindow?) {
        if let shortcutItem = shortcutItem {
            let navigationHandler: NavigationHandlerProtocol = DIContainer.shared.resolve()
            navigationHandler.handleShortcutItem(shortcutItem, and: window)
        }
    }
    
}
