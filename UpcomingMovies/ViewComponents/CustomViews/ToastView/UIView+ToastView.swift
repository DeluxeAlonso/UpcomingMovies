//
//  UIView+ToastView.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/04/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

extension UIView {

    private struct AssociatedToastKeys {
        static var toastView: ToastView?
    }

    private(set) var toastView: ToastView? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedToastKeys.toastView) as? ToastView else {
                return nil
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedToastKeys.toastView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func showToast(withMessage message: String,
                   defaultConfiguration: ToastDefaultConfiguration,
                   completion: ((Bool) -> Void)? = nil) {
        showToast(withMessage: message,
                  configuration: defaultConfiguration.configuration,
                  completion: completion)
    }

    func showToast(withMessage message: String,
                   configuration: ToastConfigurationProtocol,
                   completion: ((Bool) -> Void)? = nil) {
        if toastView != nil { hideToast() }

        self.toastView = ToastView(configuration: configuration)
        self.toastView?.title = message

        guard let toastView = toastView else { return }
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.alpha = 0

        addSubview(toastView)
        NSLayoutConstraint.activate(
            [toastView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
             toastView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
             toastView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)])

        UIView.animate(withDuration: configuration.animationDuration, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            toastView.alpha = 1.0
        }, completion: { completed in
            completion?(completed)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + configuration.dismissDuration) {
            self.hideToast(withAnimationDuration: configuration.animationDuration)
        }
    }

    /// Hides the current presented toast view without animations.
    func hideToast() {
        self.toastView?.alpha = 0.0
        self.toastView?.removeFromSuperview()
        self.toastView = nil
    }

    func hideToast(withAnimationDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.toastView?.alpha = 0.0
        }, completion: { _ in
            self.toastView?.removeFromSuperview()
            self.toastView = nil
        })
    }

}
