//
//  ScaleAnimator.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class ScaleAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.8
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (() -> Void)?
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else {
                return
        }
        let scaleView = presenting ? toView : fromView
        
        let initialFrame = presenting ? originFrame : scaleView.frame
        let finalFrame = presenting ? scaleView.frame : originFrame
        
        let scaleX = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let scaleY = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
        if presenting {
            scaleView.transform = scaleTransform
            scaleView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            scaleView.clipsToBounds = true
        }
        
        scaleView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(scaleView)
        
        let dampingRatio: CGFloat = presenting ? 0.5 : 0.8
        let velocity: CGFloat = 0.2
        
        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            usingSpringWithDamping: dampingRatio,
            initialSpringVelocity: velocity,
            animations: {
                scaleView.transform = self.presenting ? .identity : CGAffineTransform(scaleX: 0.001, y: 0.001)
                scaleView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
            if !self.presenting { self.dismissCompletion?() }
            transitionContext.completeTransition(true)
        })
    }
    
}
