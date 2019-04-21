//
//  UpcomingMoviesNavigationManager.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class UpcomingMoviesNavigationManager: NSObject, UINavigationControllerDelegate {
    
    private var transitionInteractor: TransitioningInteractor?
    
    private var verticalSafeAreaOffset: CGFloat
    private var selectedFrame: CGRect?
    private var imageToTransition: UIImage?
    
    // MARK: - Initializers
    
    init(verticalSafeAreaOffset: CGFloat) {
        self.verticalSafeAreaOffset = verticalSafeAreaOffset
    }
    
    // MARK: - Public
    
    func configure(selectedFrame: CGRect?, with imageToTransition: UIImage?) {
        self.selectedFrame = selectedFrame
        self.imageToTransition = imageToTransition
    }
    
    func updateOffset(_ verticalSafeAreaOffset: CGFloat) {
        self.verticalSafeAreaOffset = verticalSafeAreaOffset
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = selectedFrame else { return nil }
        let transitionView = UIImageView(image: imageToTransition)
        transitionView.contentMode = .scaleAspectFit
        switch operation {
        case .push:
            transitionInteractor = TransitioningInteractor(attachTo: toVC)
            return TransitioningAnimator(isPresenting: true,
                                         originFrame: frame,
                                         transitionView: transitionView,
                                         verticalSafeAreaOffset: verticalSafeAreaOffset)
        case .pop, .none:
            return TransitioningAnimator(isPresenting: false,
                                         originFrame: frame,
                                         transitionView: transitionView)
        @unknown default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            guard let transitionInteractor = transitionInteractor else { return nil }
            return transitionInteractor.transitionInProgress ? transitionInteractor : nil
    }
    
}
