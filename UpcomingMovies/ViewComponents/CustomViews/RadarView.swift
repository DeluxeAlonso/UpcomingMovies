//
//  RadarView.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class RadarView: UIView {

    // MARK: - Properties
    
    struct Colors {
        static let start = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        static let end = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0.5)
    }
    
    private let circleLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: Setup
    
    private func setupUI() {
        backgroundColor = Colors.start
        layer.addSublayer(circleLayer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(startLoading),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        startLoading()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / CGFloat(2.0)
        circleLayer.frame = bounds
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        let bezierPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2.0)
        circleLayer.path = bezierPath.cgPath
    }
    
    @objc func startLoading() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 3
        
        let fillColorAnimation = CABasicAnimation(keyPath: "fillColor")
        fillColorAnimation.fromValue = Colors.start.cgColor
        fillColorAnimation.toValue = Colors.end.cgColor
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation, fillColorAnimation, opacityAnimation]
        animationGroup.duration = 1.0
        animationGroup.repeatCount = .infinity
        
        circleLayer.add(animationGroup, forKey: "RadarView")
    }
    
}
