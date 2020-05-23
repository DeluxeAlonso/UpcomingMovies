//
//  Emptiable.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/7/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var emptyView: Placeholderable?
}

protocol Emptiable: class { }

extension Emptiable where Self: UIViewController {
    
    private(set) var emptyView: Placeholderable? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.emptyView) as? Placeholderable else {
                return nil
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.emptyView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func presentEmptyView(with message: String?) {
        let isPresented = emptyView?.isPresented ?? false
        if !isPresented {
            self.emptyView = EmptyPlaceholderView.show(fromViewController: self, animated: true, completion: nil)
        }
        emptyView?.frame = self.view.bounds
        emptyView?.detailText = message
    }
    
    func hideEmptyView() {
        emptyView?.hide(animated: true, completion: nil)
    }
    
}
