//
//  SavedMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class SavedMoviesCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    var collectionOption: ProfileCollectionOption!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SavedMoviesViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let viewModel = SavedMoviesViewModel(useCaseProvider: useCaseProvider,
                                             collectionOption: collectionOption)
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }

}
