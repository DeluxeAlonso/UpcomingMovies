//
//  ScaleAnimator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class ScaleAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var isPresenting = true
    var originFrame = CGRect.zero

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to),
            let fromView = fromViewController.view,
            let toView = toViewController.view else {
                return
        }

        isPresenting ? containerView.addSubview(toView) : containerView.insertSubview(toView, belowSubview: fromView)

        let scaleView = isPresenting ? toView : fromView

        let initialFrame = isPresenting ? originFrame : scaleView.frame
        let finalFrame = isPresenting ? scaleView.frame : originFrame

        let scaleX = isPresenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width

        let scaleY = isPresenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height

        let scaleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)

        if isPresenting {
            scaleView.transform = scaleTransform
            scaleView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            scaleView.clipsToBounds = true
        }

        scaleView.layer.masksToBounds = true

        toView.frame = isPresenting ? toView.frame : fromView.frame

        let dampingRatio: CGFloat = isPresenting ? 0.5 : 0.9
        let duration: TimeInterval = isPresenting ? 0.8 : 0.5
        let velocity: CGFloat = 0.2

        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            usingSpringWithDamping: dampingRatio,
            initialSpringVelocity: velocity,
            animations: {
                scaleView.transform = self.isPresenting ? .identity : CGAffineTransform(scaleX: 0.001, y: 0.001)
                scaleView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
            transitionContext.completeTransition(true)

        })
    }

}
