//
//  AppDelegate+Appearance.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/11/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

extension AppDelegate {

    /**
     Configures UINavigationBar an UITabBar appearance to have a similar behavior as pre-iOS15.

     In iOS 15, UIKit has extended the usage of the scrollEdgeAppearance,
     which by default produces a transparent background, to all navigation bars.
     The background is controlled by when your scroll view scrolls
     content behind the navigation bar.
     */
    func configureGlobalAppearanceIfNeeded() {
        let navigationBarAppearance = UINavigationBarAppearance()
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance

        let tabBarAppearance = UITabBarAppearance()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
    }

}
