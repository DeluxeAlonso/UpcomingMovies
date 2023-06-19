//
//  BaseCoordinatorV2.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

public enum RoutingMode {
    case push
    case present(presentingViewController: UIViewController)
    case embed(parentViewController: UIViewController, containerView: UIView?)
}

open class BaseCoordinatorV2: NSObject, Coordinator, UINavigationControllerDelegate {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var shouldBeAutomaticallyFinished: Bool = false

    private var viewController: UIViewController?

    private var routingMode: RoutingMode = .push

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()

        setupNavigationControllerDelegate()
    }

    open func build() -> UIViewController {
        fatalError("Build method should be implemented")
    }

    func start() {}

    open func start(routingMode: RoutingMode = .push) {
        let viewController = build()

        switch routingMode {
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        case .present(let presentingViewController):
            presentingViewController.present(navigationController, animated: true, completion: nil)
        case .embed(let parentViewController, let containerView):
            if let containerView {
                parentViewController.add(asChildViewController: viewController,
                                         containerView: containerView)
            } else {
                parentViewController.add(asChildViewController: viewController)
            }
            self.viewController = viewController
            shouldBeAutomaticallyFinished = true
        }

        self.routingMode = routingMode
        self.viewController = viewController
    }

    open func dismiss() {
        switch routingMode {
        case .push:
            navigationController.popViewController(animated: true)
        case .present:
            let presentedViewController = navigationController.topViewController
            presentedViewController?.dismiss(animated: true) { [weak self] in
                self?.unwrappedParentCoordinator.childDidFinishV2()
            }
        case .embed(let parentViewController, _):
            parentViewController.remove(asChildViewController: viewController)
            unwrappedParentCoordinator.childDidFinishV2()
        }
    }

    open var navigationControllerDelegate: UINavigationControllerDelegate? {
        self
    }

    open var shouldForceDelegateOverride: Bool = false

    open func setupNavigationControllerDelegate() {
        guard !shouldForceDelegateOverride && navigationController.delegate == nil else {
            return
        }
        navigationController.delegate = navigationControllerDelegate
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
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
        unwrappedParentCoordinator.childDidFinishV2()
    }

}
