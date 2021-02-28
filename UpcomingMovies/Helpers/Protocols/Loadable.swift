//
//  LoaderDisplayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var isLoaderPresented: Bool = false
}

protocol Loadable: class {
    
    associatedtype ViewType: UIView
    
    var loaderView: ViewType! { get set }

}

extension Loadable where Self: UIViewController {
    
    private(set) var isPresented: Bool {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.isLoaderPresented) as? Bool else {
                return false
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.isLoaderPresented, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - FullScreen loader
    
    func showLoader() {
        guard !isPresented else { return }
        isPresented = true
        DispatchQueue.main.async {
            let containerView = UIView(frame: self.view.frame)
            
            if #available(iOS 13.0, *) {
                containerView.backgroundColor = .systemBackground
            } else {
                containerView.backgroundColor = .white
            }
            
            self.loaderView = ViewType()
            self.loaderView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.loaderView.center = containerView.center
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
        UIView.animate(withDuration: 0.5, animations: {
            containerView.alpha = 0
        }, completion: { _ in
            containerView.removeFromSuperview()
        })
    }
    
}
