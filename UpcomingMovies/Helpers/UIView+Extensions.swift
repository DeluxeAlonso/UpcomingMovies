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
    
}
