//
//  GradientView.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var startColor: UIColor = .black {
        didSet {
            updateColors()
        }
    }

    @IBInspectable var endColor: UIColor = .white {
        didSet {
            updateColors()
        }
    }

    @IBInspectable var startLocation: Double = 0.05 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable var endLocation: Double = 0.95 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable var horizontalMode: Bool = false {
        didSet {
            updatePoints()
        }
    }

    @IBInspectable var diagonalMode: Bool = false {
        didSet {
            updatePoints()
        }
    }

    override class var layerClass: AnyClass { return CAGradientLayer.self }

    private var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }

    // MARK: - Private

    private func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }

    private func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }

    private func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }

}
