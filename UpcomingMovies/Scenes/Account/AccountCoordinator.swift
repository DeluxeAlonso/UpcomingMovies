//
//  AccountCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/20/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class AccountCoordinator: Coordinator, AccountCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = AccountViewController.instantiate()
        
        let useCaseProvider = InjectionFactory.useCaseProvider()
        let interactor = AccountInteractor(useCaseProvider: useCaseProvider,
                                           authHandler: AuthenticationHandler.shared)
        let viewModel = AccountViewModel(interactor: interactor)
        
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
                                    for user: User?) -> ProfileTableViewController {
        navigationController.setNavigationBarHidden(false, animated: true)
        
        let viewController = ProfileTableViewController.instantiate()
        
        let interactor = ProfileInteractor(useCaseProvider: InjectionFactory.useCaseProvider())
        let factory = ProfileViewFactory()
        let viewModel = ProfileViewModel(userAccount: user,
                                         interactor: interactor,
                                         factory: factory)
        
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
    
    func showCustomLists(for groupOption: ProfileGroupOption) {
        let coordinator = CustomListsCoordinator(navigationController: navigationController)
        
        coordinator.groupOption = groupOption
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func showAuthPermission(for authPermissionURL: URL?,
                            and authPermissionDelegate: AuthPermissionViewControllerDelegate) {
        let navigationController = UINavigationController()
        let coordinator = AuthPermissionCoordinator(navigationController: navigationController)

        coordinator.authPermissionURL = authPermissionURL
        coordinator.authPermissionDelegate = authPermissionDelegate
        coordinator.presentingViewController = self.navigationController.topViewController
        coordinator.parentCoordinator = unwrappedParentCoordinator
        
        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
