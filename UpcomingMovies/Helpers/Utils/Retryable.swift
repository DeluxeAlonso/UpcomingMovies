//
//  Retryable.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

protocol Retryable: class {
    
    var errorView: ErrorPlaceholderView? { get set }
    
    func showErrorView(withErrorMessage errorMessage: String?)
    
}

extension Retryable where Self: UIViewController {
    
    var isErrorViewPresented: Bool {
        return errorView?.isPresented ?? false
    }
    
    func presentFullScreenErrorView(withErrorMessage errorMessage: String?) {
        let isPresented = errorView?.isPresented ?? false
        if isPresented {
            errorView?.stopAnimation()
        } else {
            errorView = ErrorPlaceholderView.show(fromViewController: self,
                                                  animated: true,
                                                  completion: nil)
        }
        errorView?.frame = self.view.bounds
        errorView?.detailText = errorMessage
    }
    
    func hideErrorView() {
        errorView?.hide()
    }
    
}
