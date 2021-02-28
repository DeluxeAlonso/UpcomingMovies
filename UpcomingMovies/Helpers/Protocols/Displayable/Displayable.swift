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

    func show(in view: UIView, animated: Bool, completion: ((Bool) -> Void)?)
    func hide(animated: Bool, completion: ((Bool) -> Void)?)

}

extension Displayable {

    func show(in view: UIView, animated: Bool, completion: ((Bool) -> Void)?) {
        view.addSubview(self)
        fillSuperview()
        alpha = 0
        isPresented = true
        superview?.sendSubviewToBack(self)
        show(animated: animated) { _ in }
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
