//
//  ScaleTransitioningDelegate.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class ScaleTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    private let scaleTransition = ScaleAnimator()
    private let viewToScale: UIView

    init?(viewToScale: UIView?) {
        guard let viewToScale = viewToScale else { return nil }
        self.viewToScale = viewToScale
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let viewToScaleSuperview = viewToScale.superview else { return nil }

        let superviewFrame = viewToScaleSuperview.convert(viewToScale.frame, to: nil)
        scaleTransition.originFrame = CGRect(x: superviewFrame.origin.x + 20,
                                        y: superviewFrame.origin.y + 20,
                                        width: superviewFrame.size.width - 40,
                                        height: superviewFrame.size.height - 40)

        scaleTransition.isPresenting = true

        return scaleTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        scaleTransition.isPresenting = false
        return scaleTransition
    }

}
