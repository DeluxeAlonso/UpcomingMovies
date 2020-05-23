//
//  Displayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/22/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol Displayable: UIView {
    var isPresented: Bool { get set }
    
    static func show(fromViewController viewController: UIViewController,
                     animated: Bool, completion: ((Bool) -> Void)?) -> Self
    
    func hide(animated: Bool, completion: ((Bool) -> Void)?)
}

extension Displayable where Self: NibLoadable {
    static func show(fromViewController viewController: UIViewController,
                     animated: Bool, completion: ((Bool) -> Void)?) -> Self {
        
        let subview = loadFromNib()
        viewController.view.addSubview(subview)
        subview.alpha = 0
        subview.isPresented = true
        subview.superview?.sendSubviewToBack(subview)
        subview.show(animated: animated) { _ in }
        return subview
    }
    
    fileprivate func show(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        self.superview?.bringSubviewToFront(self)
        if animated {
            UIView.animate(withDuration: 0.3, animations: { self.alpha = 1 }, completion: completion)
        } else {
            self.alpha = 1
            completion?(true)
        }
    }
    
    func hide(animated: Bool = true, completion: ((Bool) -> Swift.Void)? = nil) {
        self.isPresented = false
        let closure: (Bool) -> Void = { (finished) in
            if finished {
                self.removeFromSuperview()
            }
        }
        if animated {
            UIView.animate(withDuration: 0.3,
                           delay: 0.25,
                           animations: { self.alpha = 0 }, completion: { (finished) in
                            closure(finished)
                            completion?(finished)
            })
        } else {
            self.alpha = 0
            closure(true)
            completion?(true)
        }
    }
}
