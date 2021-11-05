//
//  Displayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/19/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol Placeholderable: UIView {
    var isPresented: Bool { get set }
    var animationDuration: Double { get set }
    var retry: (() -> Void)? { get set }

    func show(animated: Bool, completion: ((Bool) -> Void)?)
    func hide(animated: Bool, completion: ((Bool) -> Void)?)
}

extension Placeholderable {

    func show(animated: Bool = true, completion: ((Bool) -> Swift.Void)? = nil) {
        self.superview?.bringSubviewToFront(self)
        if animated {
            UIView.animate(withDuration: self.animationDuration, animations: { self.alpha = 1 }, completion: completion)
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
            UIView.animate(withDuration: self.animationDuration,
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
