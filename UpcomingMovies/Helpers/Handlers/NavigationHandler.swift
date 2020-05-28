//
//  NavigationHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class NavigationHandler {
    
    static let shared = NavigationHandler()
    
    private var currentSelectedIndex: Int = 0
    
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
    
    func handleUrlOpeningNavigation(for urlString: String, and window: UIWindow?) {
        if urlString.contains("extension") {
            changeTabBarToSelectedIndex(1, from: window)
        }
    }
    
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem, and window: UIWindow?) {
        guard let shorcut = AppShortcutItem(rawValue: shortcutItem.type) else { return }
        switch shorcut {
        case .searchMovies:
            changeTabBarToSelectedIndex(1, from: window)
        }
    }
    
    func changeTabBarToSelectedIndex(_ index: Int, from window: UIWindow?) {
        currentSelectedIndex = index
        guard let tabBarController = window?.rootViewController as? UITabBarController else {
            return
        }
        tabBarController.selectedIndex = currentSelectedIndex
    }
    
}
