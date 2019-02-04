//
//  AppDelegate.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard!
    
    private var currentTabBarSelectedIndex: Int = 0

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
            currentTabBarSelectedIndex = 1
            guard let tabBarController = window?.rootViewController as? UITabBarController else {
                return
            }
            tabBarController.selectedIndex = currentTabBarSelectedIndex
        }
    }
    
    // MARK: - Core Data Handler
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UpcomingMovies")
        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError() }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()

    // MARK: - Transitions
    
    func initialTransition() {
        let initialViewController = window?.rootViewController
        let initialView = initialViewController?.view
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else {
            fatalError()
        }
        controller.selectedIndex = currentTabBarSelectedIndex
        let controllerView = controller.view
        UIView.transition(from: initialView!,
                          to: controllerView!,
                          duration: 0.5,
                          options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.transitionCrossDissolve],
                          completion: { _ in
                            self.window?.rootViewController = controller
        })
        UIView.commitAnimations()
    }

}
