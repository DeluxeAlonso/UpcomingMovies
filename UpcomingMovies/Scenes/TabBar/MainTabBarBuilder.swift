//
//  MainTabBarBuilder.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/1/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import Domain

class MainTabBarBuilder {
    
    class func buildViewControllers(with useCaseProvider: UseCaseProviderProtocol) -> [UIViewController] {
        
        let upcomingMoviesVC = UpcomingMoviesViewController.instantiate()
        upcomingMoviesVC.viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider)
        
        let searchMoviesVC = SearchMoviesViewController.instantiate()
        searchMoviesVC.viewModel = SearchMoviesViewModel(useCaseProvider: useCaseProvider)
        
        let accountVC = AccountViewController.instantiate()
        accountVC.viewModel = AccountViewModel(useCaseProvider: useCaseProvider)
        
        return [
            createNavigationController(upcomingMoviesVC, title: "Upcoming movies", image: #imageLiteral(resourceName: "Movies")),
            createNavigationController(searchMoviesVC, title: "Search movies", image: #imageLiteral(resourceName: "Search")),
            createNavigationController(accountVC, title: "Account", image: #imageLiteral(resourceName: "Account"))
        ]
    }
    
    class func createNavigationController(_ viewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        //viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        //navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
    
}
