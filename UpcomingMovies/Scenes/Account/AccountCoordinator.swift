//
//  AccountCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/20/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class AccountCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = AccountViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let viewModel = AccountViewModel(useCaseProvider: useCaseProvider)
        
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    @discardableResult
    func embedSignInViewController(on parentViewController: AccountViewControllerProtocol) -> SignInViewController {
        navigationController.setNavigationBarHidden(true, animated: true)
        
        let viewController = SignInViewController.instantiate()
        viewController.delegate = parentViewController
        
        parentViewController.add(asChildViewController: viewController)
        
        return viewController
    }
    
    @discardableResult
    func embedProfileViewController(on parentViewController: AccountViewControllerProtocol,
                                    for user: User?,
                                    and profileOptions: ProfileOptions) -> ProfileTableViewController {
        navigationController.setNavigationBarHidden(false, animated: true)
        
        let viewController = ProfileTableViewController.instantiate()
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let viewModel = ProfileViewModel(useCaseProvider: useCaseProvider,
                                         userAccount: user,
                                         options: profileOptions)
        viewController.viewModel = viewModel
        viewController.delegate = parentViewController
        
        parentViewController.add(asChildViewController: viewController)
        
        return viewController
    }
    
    func removeChildViewController<T: UIViewController>(_ viewController: inout T?,
                                                        from parentViewController: UIViewController) {
        parentViewController.remove(asChildViewController: viewController)
        viewController = nil
    }
    
    func showSavedMovies(for collectionOption: ProfileCollectionOption) {
        let coordinator = SavedMoviesCoordinator(navigationController: navigationController)
        
        coordinator.collectionOption = collectionOption
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
