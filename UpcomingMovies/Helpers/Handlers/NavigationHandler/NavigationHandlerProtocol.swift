//
//  NavigationHandlerProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 15/03/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

protocol NavigationHandlerProtocol {

    func initialTransition(from window: UIWindow?)

    func handleUrlOpeningNavigation(for url: URL?, and window: UIWindow?)
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem, and window: UIWindow?)

}
