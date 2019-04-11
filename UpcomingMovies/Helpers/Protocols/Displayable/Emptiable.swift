//
//  Emptiable.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/7/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var emptyView: EmptyPlaceholderView = EmptyPlaceholderView()
}

protocol Emptiable: class { }

extension Emptiable where Self: UIViewController {
    
    private(set) var emptyView: EmptyPlaceholderView {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.emptyView) as? EmptyPlaceholderView else {
                return EmptyPlaceholderView()
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.emptyView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func presentFullScreenEmptyView(with message: String?) {
        let isPresented = emptyView.isPresented
        if !isPresented {
            emptyView = EmptyPlaceholderView.show(fromViewController: self,
                                                  animated: true,
                                                  completion: nil)
        }
        emptyView.frame = self.view.bounds
        emptyView.messageText = message
    }
    
    func hideEmptyView() {
        emptyView.hide()
    }
    
}
