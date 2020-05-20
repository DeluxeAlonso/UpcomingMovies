//
//  Displayable.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/19/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol Displayable {
    associatedtype DisplayView
    
    var isPresented: Bool { get set }
    var animationDuration: Double { get set }
    var alpha: CGFloat { get set }
    
    func show(_ displayView: DisplayView,
              from viewController: UIViewController,
              animated: Bool,
              completion: ((Bool) -> Void)?)
}

class AnyDisplayable<DisplayView: UIView>: Displayable {
    
    var isPresented: Bool = false
    var animationDuration: Double = 0.2
    var alpha: CGFloat = 1.0
    
    var displayView: DisplayView!
    
    func show(_ displayView: DisplayView,
              from viewController: UIViewController,
              animated: Bool,
              completion: ((Bool) -> Void)?) {
        
    }
    
    func hide(animated: Bool = true, completion: ((Bool) -> Swift.Void)? = nil) {
        self.isPresented = false
        let closure: (Bool) -> Void = { (finished) in
            if finished {
                self.displayView.removeFromSuperview()
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


