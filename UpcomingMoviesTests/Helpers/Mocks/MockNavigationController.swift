//
//  MockNavigationController.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UIKit

final class MockNavigationController: UINavigationController {

    var pushViewControllerCallCount = 0
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCallCount += 1
    }

    var presentCallCount = 0
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCallCount += 1
    }

    var popViewControllerCallCount = 0
    var popViewControllerResult: UIViewController?
    override func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCallCount += 1
        return popViewControllerResult
    }

    var topViewControllerResult: MockViewController?
    override var topViewController: UIViewController? {
        topViewControllerResult
    }

    var isBeingPresentedResult: Bool = false
    override var isBeingPresented: Bool {
        isBeingPresentedResult
    }

    var viewControllersResult: [UIViewController] = []
    override var viewControllers: [UIViewController] {
        get {
            viewControllersResult
        }
        set {
            super.viewControllers = newValue
        }
    }

    var transitionCoordinatorResult: UIViewControllerTransitionCoordinator?
    override var transitionCoordinator: UIViewControllerTransitionCoordinator? {
        transitionCoordinatorResult
    }

}

final class MockNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {}

final class MockViewControllerTransitionCoordinator: NSObject, UIViewControllerTransitionCoordinator {

    func animate(alongsideTransition animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?,
                 completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        true
    }

    func animateAlongsideTransition(in view: UIView?, animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?,
                                    completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        true
    }

    func notifyWhenInteractionEnds(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) {}

    func notifyWhenInteractionChanges(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) {}

    var isAnimated: Bool = false

    var presentationStyle: UIModalPresentationStyle = .automatic

    var initiallyInteractive: Bool = false

    var isInterruptible: Bool = false

    var isInteractive: Bool = false

    var isCancelled: Bool = false

    var transitionDuration: TimeInterval = 1

    var percentComplete: CGFloat = 1.0

    var completionVelocity: CGFloat = 1.0

    var completionCurve: UIView.AnimationCurve = .easeIn

    private(set) var viewControllerForKeyCallCount = 0
    var viewControllerForKeyResult = MockViewController()
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        viewControllerForKeyCallCount += 1
        return viewControllerForKeyResult
    }

    private(set) var viewForKeyCallCount = 0
    var viewForKeyResult = UIView()
    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        viewForKeyCallCount += 1
        return viewForKeyResult
    }

    var containerView: UIView = UIView()

    var targetTransform: CGAffineTransform = .identity

}
