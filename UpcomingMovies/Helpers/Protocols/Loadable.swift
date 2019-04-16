//
//  LoaderDisplayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var isPresented: Bool = false
}

protocol Loadable: class {
    
    associatedtype ViewType: UIView
    
    var loaderView: ViewType! { get set }

}

extension Loadable where Self: UIViewController {
    
    private(set) var isPresented: Bool {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.isPresented) as? Bool else {
                return false
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.isPresented, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - FullScreen loader
    
    func showLoader(with backgroundColor: UIColor = .white) {
        guard !isPresented else { return }
        isPresented = true
        DispatchQueue.main.async {
            let containerView = UIView(frame: self.view.frame)
            containerView.backgroundColor = backgroundColor
            
            self.loaderView = ViewType()
            self.loaderView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.loaderView.center = self.view.center
            containerView.addSubview(self.loaderView)
            
            self.view.addSubview(containerView)
        }
    }
    
    // MARK: - Hiding loader
    
    func hideLoader() {
        guard isPresented, let containerView = loaderView?.superview else {
                return
        }
        isPresented = false
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
        }
    }
    
}
