//
//  VoteAverageView.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

@IBDesignable
class VoteAverageView: UIView {
    
    private lazy var voteAverageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontHelper.light(withSize: 12.0)
        return label
    }()
    
    // MARK: - Configurable properties
    
    private let backgroundLayer = CAShapeLayer()
    @IBInspectable var backgroundLayerColor: UIColor = .gray {
        didSet {
            updateShapeLayerColors()
        }
    }
    
    private let loadedLayer = CAShapeLayer()
    @IBInspectable var loadedLayerColor: UIColor = .black {
        didSet {
            updateShapeLayerColors()
        }
    }
    
    @IBInspectable var layerLineWidth: CGFloat = 5.0 {
        didSet {
            setupShapeLayers()
        }
    }
    
    @IBInspectable var layerStartAngle: CGFloat = 45.0 {
        didSet {
            setupShapeLayerPath(loadedLayer)
        }
    }
    
    var voteValue: Double? {
        didSet {
            updateVoteValue()
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShapeLayerPath(backgroundLayer)
        setupShapeLayerPath(loadedLayer)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        setupLabels()
        setupShapeLayers()
    }
    
    private func setupLabels() {
        addSubview(voteAverageLabel)
        voteAverageLabel.centerInSuperview()
    }
    
    private func setupShapeLayers() {
        backgroundLayer.lineWidth = layerLineWidth
        backgroundLayer.fillColor = nil
        backgroundLayer.strokeEnd = 1.0
        backgroundLayer.strokeColor = backgroundLayerColor.cgColor
        layer.addSublayer(backgroundLayer)
        
        loadedLayer.lineWidth = layerLineWidth
        loadedLayer.fillColor = nil
        loadedLayer.strokeEnd = 0
        loadedLayer.strokeColor = loadedLayerColor.cgColor
        layer.addSublayer(loadedLayer)
        
        updateVoteValue()
    }
    
    private func setupShapeLayerPath(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = bounds
        let startAngle = degreesToRadians(layerStartAngle)
        let endAngle = degreesToRadians(layerStartAngle) + 2 * .pi
        let center = voteAverageLabel.center
        let radius = bounds.width * 0.35
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true).cgPath
        shapeLayer.path = path
    }
    
    private func updateShapeLayerColors() {
        backgroundLayer.strokeColor = backgroundLayerColor.cgColor
        loadedLayer.strokeColor = loadedLayerColor.cgColor
    }
    
    private func updateVoteValue() {
        guard let voteValue = voteValue, voteValue > 0.0 else {
            voteAverageLabel.text = "-"
            loadedLayer.strokeEnd = 0.0
            return
        }
        voteAverageLabel.text = String(voteValue)
        let toValue = voteValue / 10.0
        loadedLayer.strokeEnd = CGFloat(toValue)
    }
    
}
