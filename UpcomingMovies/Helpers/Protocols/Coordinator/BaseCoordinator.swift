//
//  BaseCoordinator.swift
//  UpcomingMovies
//
//  Created by Alonso on 17/12/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import UIKit

class BaseCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        fatalError("Start method should be implemented")
    }

    func setNavigationControllerDelegate(_ delegate: UINavigationControllerDelegate, shouldForce: Bool = false) {
        guard !shouldForce && navigationController.delegate == nil else {
            return
        }
        navigationController.delegate = delegate
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // We only intend to cover push/pop scenarios here. Present/dismissal handling should be done manually.
        let isBeingPresented = navigationController.isBeingPresented
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !isBeingPresented else {
            return
        }
        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        unwrappedParentCoordinator.childDidFinish()
    }

}
