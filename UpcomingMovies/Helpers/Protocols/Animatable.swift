//
//  Animatable.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

struct AnimatableSettings {

    var duration: TimeInterval = 0.5
    var delay: TimeInterval = 0.0
    var springDamping: CGFloat = 1.0
    var springVelocity: CGFloat = 0.0
    var options: UIView.AnimationOptions = [.allowUserInteraction]
    var transform: CGAffineTransform = .init(scaleX: 0.90, y: 0.90)

}

private struct AssociatedKeys {

    static var animationAvailable = "UM_animationAvialable"

}

protocol Animatable: AnyObject {

    var settings: AnimatableSettings { get }
    func lockAnimation()
    func unlockAnimation()
    func highlight(_ touched: Bool)
    func highlight(_ touched: Bool, completion: ((Bool) -> Void)?)

}

extension Animatable where Self: UIView {

    private var animationAvailable: Bool {
        get { return (objc_getAssociatedObject(self, &AssociatedKeys.animationAvailable) as? Bool) ?? true }
        set { objc_setAssociatedObject(self, &AssociatedKeys.animationAvailable, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }

    var settings: AnimatableSettings {
        return AnimatableSettings()
    }

    func lockAnimation() {
        animationAvailable = false
        layer.removeAllAnimations()
    }

    func unlockAnimation() {
        animationAvailable = true
    }

    func highlight(_ touched: Bool) {
        highlight(touched, completion: nil)
    }

    func highlight(_ touched: Bool, completion: ((Bool) -> Void)?) {
        guard animationAvailable else { return }

        UIView.animate(withDuration: settings.duration,
                       delay: settings.delay,
                       usingSpringWithDamping: settings.springDamping,
                       initialSpringVelocity: settings.springVelocity,
                       options: settings.options,
                       animations: {
                        self.transform = touched ? self.settings.transform : .identity
        }, completion: completion)
    }

}
