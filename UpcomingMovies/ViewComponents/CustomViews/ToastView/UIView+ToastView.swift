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
                   configuration: ToastConfiguration,
                   dismissDuration: TimeInterval,
                   completion: ((Bool) -> Void)?) {
        self.toastView = ToastView(configuration: configuration)
        self.toastView?.titleLabel.text = message

        guard let toastView = toastView else { return }

        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.alpha = 0

        addSubview(toastView)
        NSLayoutConstraint.activate([toastView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                     toastView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                                     toastView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)])
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            toastView.alpha = 1.0
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + dismissDuration) {
            self.hideToast()
        }
    }

    func hideToast() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.toastView?.alpha = 0.0
        }, completion: { _ in
            self.toastView?.removeFromSuperview()
        })
    }

}
