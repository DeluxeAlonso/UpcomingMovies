//
//  TransitioningAnimator.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/29/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class TransitioningAnimator: NSObject {

    private let duration: TimeInterval
    private let isPresenting: Bool
    private let originFrame: CGRect
    private let transitionView: UIView
    private let verticalSafeAreaOffset: CGFloat

    // MARK: - Initializers

    init(duration: TimeInterval = 0.3,
         isPresenting: Bool,
         originFrame: CGRect,
         transitionView: UIView,
         verticalSafeAreaOffset: CGFloat = 0.0) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.transitionView = transitionView
        self.verticalSafeAreaOffset = verticalSafeAreaOffset
        super.init()
    }

}

// MARK: - UIViewControllerAnimatedTransitioning

extension TransitioningAnimator: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView

        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to),
            let fromView = fromViewController.view,
            let toView = toViewController.view else {
                return
        }

        isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)

        let transitionableViewController = isPresenting ? toViewController : fromViewController
        let transitionableView: UIView = transitionableViewController.view

        guard let transitionable = transitionableViewController as? Transitionable else {
            assertionFailure("There is no transitionable view controller in the transition.")
            return
        }

        guard let transitionContainerView = transitionable.transitionContainerView,
            var transitionContainerViewFrame = transitionContainerView.absoluteFrame(relativeTo: transitionable.view) else { return }

        transitionContainerViewFrame.origin.x += verticalSafeAreaOffset

        transitionContainerView.alpha = 0.0
        transitionView.frame = isPresenting ? originFrame : transitionContainerViewFrame

        container.addSubview(transitionView)

        toView.frame = isPresenting ? CGRect(x: fromView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()

        UIView.animate(withDuration: duration, animations: {
            self.transitionView.frame = self.isPresenting ? transitionContainerViewFrame : self.originFrame
            transitionableView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width,
                                                                           y: 0, width: toView.frame.width,
                                                                           height: toView.frame.height)
            transitionableView.alpha = self.isPresenting ? 1 : 0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.transitionView.removeFromSuperview()
            transitionContainerView.alpha = 1
        })
    }

}
