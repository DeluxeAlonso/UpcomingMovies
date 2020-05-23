//
//  Retryable.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var retryView: Placeholderable?
}

protocol Retryable: class { }

extension Retryable where Self: UIViewController {
    
    private(set) var retryView: Placeholderable? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.retryView) as? Placeholderable else {
                return nil
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.retryView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func presentRetryView(with errorMessage: String?, errorHandler: @escaping () -> Void) {
        let isPresented = retryView?.isPresented ?? false
        if isPresented {
           //self.errorView.stopAnimation()
        } else {
            self.retryView = ErrorPlaceholderView.show(fromViewController: self, animated: true, completion: nil)
        }
        retryView?.retry = errorHandler
        retryView?.frame = self.view.bounds
        retryView?.detailText = errorMessage
    }
    
    func hideRetryView() {
        retryView?.hide(animated: true, completion: nil)
    }
    
}
