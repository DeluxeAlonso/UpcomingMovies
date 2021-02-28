//
//  LoaderDisplayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

private struct AssociatedKeys {
    static var loadableView: UIView?
}

protocol Loadable: class {

    func showLoader()
    func hideLoader()

}

extension Loadable where Self: UIViewController {
    
    private (set) var loadableView: UIView? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.loadableView) as? UIView else {
                return nil
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.loadableView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - FullScreen loader
    
    func showLoader() {
        guard loadableView == nil else { return }
        DispatchQueue.main.async {
            self.loadableView = RadarView()
            self.loadableView?.frame = self.view.frame
            
            self.view.addSubview(self.loadableView!)
        }
    }
    
    // MARK: - Hiding loader
    
    func hideLoader() {
        UIView.animate(withDuration: 0.5, animations: {
            self.loadableView?.alpha = 0
        }, completion: { _ in
            self.loadableView?.removeFromSuperview()
            self.loadableView = nil
        })
    }
    
}
