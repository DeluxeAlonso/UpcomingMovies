//
//  Retryable.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var errorView: Placeholderable?
}

protocol Retryable: class { }

extension Retryable where Self: UIViewController {
    
    private(set) var errorView: Placeholderable? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.errorView) as? Placeholderable else {
                return nil
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.errorView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func presentErrorView(with errorMessage: String?, errorHandler: @escaping () -> Void) {
        let isPresented = errorView?.isPresented ?? false
        if isPresented {
           //self.errorView.stopAnimation()
        } else {
            self.errorView = ErrorPlaceholderView.show(fromViewController: self, animated: true, completion: nil)
        }
        errorView?.retry = errorHandler
        errorView?.frame = self.view.bounds
        errorView?.detailText = errorMessage
    }
    
    func hideErrorView() {
        errorView?.hide(animated: true, completion: nil)
    }
    
}
