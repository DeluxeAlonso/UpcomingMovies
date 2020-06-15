//
//  MainTabBarBuilder.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/1/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class MainTabBarBuilder {
    
    class func buildViewControllers(with useCaseProvider: UseCaseProviderProtocol) -> [UIViewController] {
        let upcomingMoviesVC = UpcomingMoviesViewController.instantiate()
        let contentHandler = UpcomingMoviesContentHandler(movieUseCase: useCaseProvider.movieUseCase())
        upcomingMoviesVC.viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider,
                                                             contentHandler: contentHandler)
        
        let searchMoviesVC = SearchMoviesViewController.instantiate()
        searchMoviesVC.viewModel = SearchMoviesViewModel(useCaseProvider: useCaseProvider)
        
        let accountVC = AccountViewController.instantiate()
        accountVC.viewModel = AccountViewModel(useCaseProvider: useCaseProvider)
        
        let upcomingMoviesCoordinator = UpcomingMoviesCoordinator(navigationController: UINavigationController())
        upcomingMoviesCoordinator.start()
        return [
            //createNavigationController(upcomingMoviesVC, title: "Upcoming", image: #imageLiteral(resourceName: "Movies")),
            upcomingMoviesCoordinator.navigationController,
            createNavigationController(searchMoviesVC, title: "Search", image: #imageLiteral(resourceName: "Search")),
            createNavigationController(accountVC, title: "Account", image: #imageLiteral(resourceName: "Account"))
        ]
    }
    
    class func createNavigationController(_ viewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
    
}
