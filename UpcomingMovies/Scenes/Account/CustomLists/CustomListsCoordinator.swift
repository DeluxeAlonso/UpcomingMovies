//
//  CustomListsCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class CustomListsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    var groupOption: ProfileGroupOption!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = CustomListsViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let viewModel = CustomListsViewModel(useCaseProvider: useCaseProvider, groupOption: groupOption)
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
