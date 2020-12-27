//
//  NavigationHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol NavigationHandlerProtocol {
    
    func initialTransition(from window: UIWindow?)
    
    func handleUrlOpeningNavigation(for url: URL?, and window: UIWindow?)
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem, and window: UIWindow?)
    
}

final class NavigationHandler: NavigationHandlerProtocol {
    
    private var currentSelectedIndex: Int = 0
    
    private func changeTabBarToSelectedIndex(_ index: Int, from window: UIWindow?) {
        currentSelectedIndex = index
        guard let tabBarController = window?.rootViewController as? UITabBarController else {
            return
        }
        tabBarController.selectedIndex = currentSelectedIndex
    }
    
    func initialTransition(from window: UIWindow?) {
        guard let window = window else { return }
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [UIView.AnimationOptions.curveEaseOut,
                                    UIView.AnimationOptions.transitionCrossDissolve],
                          animations: {},
                          completion: { _ in
                            let mainTabBarController = MainTabBarController()
                            mainTabBarController.setSelectedIndex(self.currentSelectedIndex)
                            window.rootViewController = mainTabBarController
        })
    }
    
    func handleUrlOpeningNavigation(for url: URL?, and window: UIWindow?) {
        guard let url = url, let urlHost = url.host else { return }

        if url.scheme == "extension" {
            guard let host = AppExtensionHost(rawValue: urlHost) else { return }
            switch host {
            case .upcomingMovies:
                changeTabBarToSelectedIndex(0, from: window)
            case .searchMovies:
                changeTabBarToSelectedIndex(1, from: window)
            }
        }
    }
    
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem, and window: UIWindow?) {
        guard let shorcut = AppShortcutItem(rawValue: shortcutItem.type) else { return }
        switch shorcut {
        case .searchMovies:
            changeTabBarToSelectedIndex(1, from: window)
        }
    }
    
}
