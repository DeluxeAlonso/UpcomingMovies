//
//  NavigationHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class NavigationHandler {
    
    class func initialTransition(from window: UIWindow?) {
        guard let window = window else { return }
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [UIView.AnimationOptions.curveEaseOut,
                                    UIView.AnimationOptions.transitionCrossDissolve],
                          animations: {},
                          completion: { _ in
                            window.rootViewController = MainTabBarController()
        })
    }
    
    class func handleUrlOpeningNavigation(for urlString: String, and window: UIWindow?) {
        if urlString.contains("extension") {
            changeTabBarToSelectedIndex(1, from: window)
        }
    }
    
    class func changeTabBarToSelectedIndex(_ index: Int, from window: UIWindow?) {
        guard let tabBarController = window?.rootViewController as? UITabBarController else {
            return
        }
        tabBarController.selectedIndex = index
    }
    
}
