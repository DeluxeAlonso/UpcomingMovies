//
//  AppDelegate.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard!
    
    private var currentTabBarSelectedIndex: MainTabBarController.Items = .upcomingMovies

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        return true
    }
    
    func application(_ application: UIApplication,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        guard let shorcut = AppShortcutItem(rawValue: shortcutItem.type) else { return }
        switch shorcut {
        case .searchMovies:
            currentTabBarSelectedIndex = .searchMovies
            guard let tabBarController = window?.rootViewController as? UITabBarController else {
                return
            }
            tabBarController.selectedIndex = currentTabBarSelectedIndex.rawValue
        }
    }

    // MARK: - Transitions
    
    func initialTransition() {
        guard let window = window,
            let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else {
            fatalError()
        }
        controller.setSelectedIndex(currentTabBarSelectedIndex.rawValue)
        
        self.window?.rootViewController = controller
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [UIView.AnimationOptions.curveEaseOut,
                                    UIView.AnimationOptions.transitionCrossDissolve],
                          animations: {},
                          completion: nil)
    }
    
}
