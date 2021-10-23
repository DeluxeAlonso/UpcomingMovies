//
//  SpinerLayer.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class SpinerLayer: CAShapeLayer {

    var spinnerColor = UIColor.white {
        didSet {
            strokeColor = spinnerColor.cgColor
        }
    }

    // MARK: - Initializers

    init(frame: CGRect) {
        super.init()

        updateFrame(frame)

        fillColor = nil
        strokeColor = spinnerColor.cgColor
        lineWidth = 1

        strokeEnd = 0.4
        isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func updatePath(with frame: CGRect, and radius: CGFloat) {
        let center = CGPoint(x: frame.height / 2, y: bounds.center.y)
        let startAngle = 0 - Double.pi/2
        let endAngle = Double.pi * 2 - Double.pi/2
        let clockwise: Bool = true
        path = UIBezierPath(arcCenter: center,
                                 radius: radius,
                                 startAngle: CGFloat(startAngle),
                                 endAngle: CGFloat(endAngle), clockwise: clockwise).cgPath
    }

    // MARK: - Internal

    func animation() {
        isHidden = false
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0
        rotate.toValue = Double.pi * 2
        rotate.duration = 0.4
        rotate.timingFunction = CAMediaTimingFunction(name: .linear)

        rotate.repeatCount = HUGE
        rotate.fillMode = .forwards
        rotate.isRemovedOnCompletion = false
        add(rotate, forKey: rotate.keyPath)

    }

    func updateFrame(_ frame: CGRect) {
        let radius: CGFloat = (frame.height / 2) * 0.5
        self.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height)
        updatePath(with: self.frame, and: radius)
    }

    func stopAnimation() {
        isHidden = true
        removeAllAnimations()
    }

}
