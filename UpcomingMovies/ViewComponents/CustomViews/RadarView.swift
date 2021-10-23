//
//  RadarView.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class RadarView: UIView, LoadingView {

    // MARK: - Properties

    struct Colors {
        static let start = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        static let end = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0.5)
    }

    lazy var layerContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var isPresented: Bool = false

    private let circleLayer = CAShapeLayer()

    // MARK: - Initializers

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.willEnterForegroundNotification,
                                                  object: nil)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        layerContainerView.layer.cornerRadius = layerContainerView.bounds.height / CGFloat(2.0)
        circleLayer.frame = layerContainerView.bounds
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        let bezierPath = UIBezierPath(roundedRect: layerContainerView.bounds, cornerRadius: layerContainerView.bounds.height / 2.0)
        circleLayer.path = bezierPath.cgPath
    }

    // MARK: - Private

    private func setupUI() {
        backgroundColor = ColorPalette.defaultBackgroundColor

        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        setupLayerContainerView()
    }

    private func setupLayerContainerView() {
        addSubview(layerContainerView)
        layerContainerView.centerInSuperview(size: .init(width: 80, height: 80))

        layerContainerView.backgroundColor = Colors.start
        layerContainerView.layer.addSublayer(circleLayer)
    }

    // MARK: - LoadingView

    func startLoading() {
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

    func stopLoading() {
        circleLayer.removeAllAnimations()
    }

    // MARK: - Selectors

    @objc func willEnterForeground() {
        startLoading()
    }

}
