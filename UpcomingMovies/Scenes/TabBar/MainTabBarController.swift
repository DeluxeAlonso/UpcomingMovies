//
//  MainTabBarController.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var currentSelectedItemIndex: Int!
    private var coordinators: [Coordinator]!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        coordinators = MainTabBarBuilder.buildViewCoordinators()
        viewControllers = coordinators.map { $0.navigationController }
    }
    
    // MARK: - Public
    
    func setSelectedIndex(_ index: Int) {
        selectedIndex = index
        currentSelectedItemIndex = selectedIndex
    }
    
}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let currentTabBarIndex = viewControllers?.firstIndex(of: viewController),
            currentTabBarIndex == selectedIndex,
            selectedIndex == currentSelectedItemIndex else {
                currentSelectedItemIndex = selectedIndex
                return
        }
        guard let navigationController = viewController as? UINavigationController,
            let tabBarScrollable = navigationController.topViewController as? TabBarScrollable else { return }
        tabBarScrollable.handleTabBarSelection()
    }
    
}
