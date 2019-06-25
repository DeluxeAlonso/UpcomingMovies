//
//  UIView+Extensions.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/28/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     * Frame of the view relative to the app window.
     */
    var absoluteFrame: CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
    
    /**
     * Show a single shadow around the border of the view.
     */
    func setShadowBorder(shadowColor: CGColor = UIColor.black.cgColor, shadowRadious: CGFloat = 5) {
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadious
        self.layer.shadowOpacity = 0.5
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
    
    // MARK: - Overlay
    
    func addOverlay(with backgroundColor: UIColor = .black, and alpha: CGFloat = 0.35) {
        let overlayView = UIView()
        overlayView.backgroundColor = backgroundColor
        overlayView.alpha = alpha
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overlayView)
        overlayView.fillSuperview()
    }
    
}
