//
//  ScaleTransitioningDelegate.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

final class ScaleTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    private let viewToScale: UIView
    private let scaleAnimator: ScaleAnimatedTransitioning

    init?(viewToScale: UIView?) {
        guard let viewToScale = viewToScale else { return nil }
        self.viewToScale = viewToScale
        self.scaleAnimator = ScaleAnimator(transitionDuration: 0.8)
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let viewToScaleSuperview = viewToScale.superview else { return nil }

        let superviewFrame = viewToScaleSuperview.convert(viewToScale.frame, to: nil)
        scaleAnimator.originFrame = CGRect(x: superviewFrame.origin.x + 20,
                                             y: superviewFrame.origin.y + 20,
                                             width: superviewFrame.size.width - 40,
                                             height: superviewFrame.size.height - 40)

        scaleAnimator.isPresenting = true

        return scaleAnimator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        scaleAnimator.isPresenting = false
        return scaleAnimator
    }

}
