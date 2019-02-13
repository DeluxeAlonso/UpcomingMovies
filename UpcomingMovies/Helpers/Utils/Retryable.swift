//
//  Retryable.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var errorView: ErrorPlaceholderView = ErrorPlaceholderView()
}

protocol Retryable: class {

}

extension Retryable where Self: UIViewController {
    
    private(set) var errorView: ErrorPlaceholderView {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.errorView) as? ErrorPlaceholderView else {
                return ErrorPlaceholderView()
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.errorView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var isErrorViewPresented: Bool {
        return errorView.isPresented
    }
    
    func presentFullScreenErrorView(withErrorMessage errorMessage: String?, errorHandler: @escaping () -> Void) {
        let isPresented = errorView.isPresented
        if isPresented {
            errorView.stopAnimation()
        } else {
            errorView = ErrorPlaceholderView.show(fromViewController: self,
                                                  animated: true,
                                                  completion: nil)
        }
        errorView.retry = errorHandler
        errorView.frame = self.view.bounds
        errorView.detailText = errorMessage
    }
    
    func hideErrorView() {
        errorView.hide()
    }
    
}
