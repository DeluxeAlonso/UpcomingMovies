//
//  MovieDetailTransitioningAnimator.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/29/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailTransitioningAnimator: NSObject {
    
    private var duration: TimeInterval = 0.0
    private var isPresenting: Bool
    private var originFrame: CGRect
    private var image: UIImage?
    
    // MARK: - Initializers
    
    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect, image: UIImage?) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.image = image
        super.init()
    }

}

// MARK: - UIViewControllerAnimatedTransitioning

extension MovieDetailTransitioningAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
                return
        }
        
        let fromView: UIView = fromViewController.view
        let toView: UIView = toViewController.view
        
        isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailViewController = isPresenting ? toViewController : fromViewController
        let detailView: UIView = detailViewController.view
        
        guard detailViewController is MovieDetailViewController else { return }
        
        guard let posterContainerView = detailView.viewWithTag(Constants.CustomAnimatorTag),
           let posterContainerViewFrame = posterContainerView.globalFrame else { return }
        posterContainerView.alpha = 0.0
        
        let transitionImageView = UIImageView(frame: isPresenting ? originFrame : posterContainerViewFrame)
        transitionImageView.image = image
        
        container.addSubview(transitionImageView)
        
        toView.frame = isPresenting ? CGRect(x: fromView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            transitionImageView.frame = self.isPresenting ? posterContainerViewFrame : self.originFrame
            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width,
                                                                           y: 0, width: toView.frame.width,
                                                                           height: toView.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionImageView.removeFromSuperview()
            posterContainerView.alpha = 1
        })
    }
    
}

// MARK: - Constants

extension MovieDetailTransitioningAnimator {
    
    struct Constants {
        static let CustomAnimatorTag: Int = 100
    }
    
}
