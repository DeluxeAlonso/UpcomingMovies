//
//  CustomListsCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

final class CustomListsCoordinator: Coordinator, CustomListsCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = CustomListsViewController.instantiate()
        
        let interactor = CustomListsInteractor(useCaseProvider: InjectionFactory.useCaseProvider())
        let viewModel = CustomListsViewModel(interactor: interactor)
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showListDetail(for customList: List) {
        let coordinator = CustomListDetailCoordinator(navigationController: navigationController)
        
        coordinator.customList = customList
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
