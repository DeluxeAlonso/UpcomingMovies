//
//  MainTabBarBuilder.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/1/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class MainTabBarBuilder {
    
    class func buildViewCoordinators() -> [Coordinator] {

        let upcomingMoviesNavigationController = createNavigationController(title: "Upcoming", image: #imageLiteral(resourceName: "Movies"))
        let upcomingMoviesCoordinator = UpcomingMoviesCoordinator(navigationController: upcomingMoviesNavigationController)
        upcomingMoviesCoordinator.start()
        
        let searchMoviesNavigationController = createNavigationController(title: "Search", image: #imageLiteral(resourceName: "Search"))
        let searchMoviesCoordinator = SearchMoviesCoordinator(navigationController: searchMoviesNavigationController)
        searchMoviesCoordinator.start()
        
        let accountNavigationController = createNavigationController(title: "Account", image: #imageLiteral(resourceName: "Account"))
        let accountCoordinator = AccountCoordinator(navigationController: accountNavigationController)
        accountCoordinator.start()
        
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
