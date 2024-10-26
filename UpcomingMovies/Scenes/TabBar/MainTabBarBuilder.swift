//
//  MainTabBarBuilder.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/1/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

struct RootCoordinatorIdentifier {
    static let upcomingMovies = "upcoming"
    static let searchMovies = "search"
    static let account = "account"
}

final class MainTabBarBuilder {

    class func buildViewCoordinators() -> [RootCoordinator] {

        let upcomingMoviesNavigationController = createNavigationController(title: LocalizedStrings.upcomingMoviesTabBarTitle(), image: #imageLiteral(resourceName: "Movies"))
        let upcomingMoviesCoordinator = UpcomingMoviesCoordinator(navigationController: upcomingMoviesNavigationController,
                                                                  navigationDelegate: UpcomingMoviesNavigation())
        upcomingMoviesCoordinator.start(coordinatorMode: .push)

        let searchMoviesNavigationController = createNavigationController(title: LocalizedStrings.searchMoviesTabBarTitle(), image: #imageLiteral(resourceName: "Search"))
        let searchMoviesCoordinator = SearchMoviesCoordinator(navigationController: searchMoviesNavigationController)
        searchMoviesCoordinator.start(coordinatorMode: .push)

        let accountNavigationController = createNavigationController(title: LocalizedStrings.accountTabBarTitle(), image: #imageLiteral(resourceName: "Account"))
        let accountCoordinator = AccountCoordinator(navigationController: accountNavigationController)
        accountCoordinator.start(coordinatorMode: .push)

        return [
            upcomingMoviesCoordinator,
            searchMoviesCoordinator,
            accountCoordinator
        ]
    }

    class func createNavigationController(title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController()
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image

        return navController
    }

}
