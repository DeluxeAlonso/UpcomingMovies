//
//  UpcomingMoviesNavigationDelegate.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class UpcomingMoviesNavigationDelegate: NSObject, UINavigationControllerDelegate {
    
    private var transitionInteractor: TransitioningInteractor?
    private var verticalSafeAreaOffset: CGFloat
    private var selectedFrame: CGRect?
    private var imageToTransition: UIImage?
    
    weak var parentCoordinator: Coordinator?
    
    // MARK: - Initializers
    
    init(verticalSafeAreaOffset: CGFloat = .zero) {
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
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller.
        //If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let buyViewController = fromViewController as? MovieDetailViewController,
            let coordinator = buyViewController.coordinator {
            // We're popping a buy view controller; end its coordinator
            parentCoordinator?.childDidFinish(coordinator)
        }
    }
    
}
