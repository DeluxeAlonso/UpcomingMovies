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

    private(set) var shouldBeAutomaticallyFinished: Bool = false

    private var viewController: UIViewController?
    private var coordinatorMode: CoordinatorMode = .push

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()

        setupNavigationControllerDelegate()
    }

    func start() {
        fatalError("Start method should be implemented")
    }

    func build() -> UIViewController {
        fatalError("Build method should be implemented")
    }

    func start(coordinatorMode: CoordinatorMode = .push) {
        let viewController = build()

        switch coordinatorMode {
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        case .present(let presentingViewController, let configuration):
            navigationController.pushViewController(viewController, animated: false)
            navigationController.modalPresentationStyle = configuration?.modalPresentationStyle ?? .automatic
            navigationController.transitioningDelegate = configuration?.transitioningDelegate
            presentingViewController.present(navigationController, animated: true, completion: nil)
        case .embed(let parentViewController, let containerView):
            guard parentCoordinator != nil else {
                assertionFailure("When starting on embed mode, parent coordinator is needed to perform appropiate deallocation.")
                return
            }
            if let containerView {
                parentViewController.add(asChildViewController: viewController,
                                         containerView: containerView)
            } else {
                parentViewController.add(asChildViewController: viewController)
            }
            self.viewController = viewController
            shouldBeAutomaticallyFinished = true
        }

        self.coordinatorMode = coordinatorMode
        self.viewController = viewController
    }

    func dismiss() {
        dismiss(completion: nil)
    }

    func dismiss(completion: (() -> Void)? = nil) {
        switch coordinatorMode {
        case .push:
            navigationController.popViewController(animated: true)
            completion?()
        case .present:
            let presentedViewController = navigationController.topViewController
            presentedViewController?.dismiss(animated: true) { [weak self] in
                self?.unwrappedParentCoordinator.childDidFinish()
                completion?()
            }
        case .embed(let parentViewController, _):
            parentViewController.remove(asChildViewController: viewController)
            unwrappedParentCoordinator.childDidFinish(self)
            completion?()
        }
    }

    var navigationControllerDelegate: UINavigationControllerDelegate? {
        self
    }

    var shouldForceDelegateOverride: Bool = false

    func setupNavigationControllerDelegate() {
        guard shouldForceDelegateOverride || navigationController.delegate == nil else {
            return
        }
        navigationController.delegate = navigationControllerDelegate
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
