//
//  ShrinkingButton.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ShrinkingButton: UIButton, UIViewControllerTransitioningDelegate, CAAnimationDelegate {
    
    @IBInspectable var spinnerColor: UIColor = UIColor.white {
        didSet {
            spiner.spinnerColor = spinnerColor
        }
    }
    
    @IBInspectable var disabledBackgroundColor: UIColor = UIColor.lightGray {
        didSet {
            self.setBackgroundImage(UIImage(color: disabledBackgroundColor), for: .disabled)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    private lazy var spiner: SpinerLayer = {
        let spiner = SpinerLayer(frame: self.frame)
        self.layer.addSublayer(spiner)
        return spiner
    }()
    
    private var cachedTitle: String?
    private var cachedImage: UIImage?
    
    private let shrinkCurve: CAMediaTimingFunction = CAMediaTimingFunction(name: .linear)
    private let shrinkDuration: CFTimeInterval = 0.1
    
    var isAnimating: Bool = false
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.spiner.setToFrame(self.frame)
    }
    
    private func setup() {
        self.clipsToBounds  = true
        spiner.spinnerColor = spinnerColor
    }
    
    func startAnimation() {
        self.isAnimating = true
        self.isUserInteractionEnabled = false
        
        self.cachedTitle = title(for: .normal)
        self.cachedImage = image(for: .normal)
        
        self.setTitle("", for: .normal)
        self.setImage(nil, for: .normal)
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.layer.cornerRadius = self.frame.height / 2
        }, completion: { _ -> Void in
            self.shrink()
            self.spiner.animation()
        })
    }
    
    func stopAnimation(revertAfterDelay delay: TimeInterval = 1.0, completion: (() -> Void)? = nil) {
        guard isAnimating else { return }
        
        let delayToRevert = max(delay, 0.2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayToRevert) {
            self.setOriginalState { [weak self] in
                self?.layer.removeAllAnimations()
                completion?()
            }
        }
    }
    
    private func setOriginalState(completion: (() -> Void)?) {
        self.animateToOriginalWidth(completion: completion)
        self.spiner.stopAnimation()
        self.setTitle(self.cachedTitle, for: .normal)
        self.setImage(self.cachedImage, for: .normal)
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = self.cornerRadius
        self.isAnimating = false
    }
    
    private func animateToOriginalWidth(completion: (() -> Void)?) {
        let shrinkAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnimation.fromValue = (self.bounds.height)
        shrinkAnimation.toValue = (self.bounds.width)
        shrinkAnimation.duration = shrinkDuration
        shrinkAnimation.timingFunction = shrinkCurve
        shrinkAnimation.fillMode = .forwards
        shrinkAnimation.isRemovedOnCompletion = false
        
        CATransaction.setCompletionBlock {
            completion?()
        }
        self.layer.add(shrinkAnimation, forKey: shrinkAnimation.keyPath)
        
        CATransaction.commit()
    }
    
    private func shrink() {
        let shrinkAnim = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnim.fromValue = frame.width
        shrinkAnim.toValue = frame.height
        shrinkAnim.duration = shrinkDuration
        shrinkAnim.timingFunction = shrinkCurve
        shrinkAnim.fillMode = .forwards
        shrinkAnim.isRemovedOnCompletion = false
        
        layer.add(shrinkAnim, forKey: shrinkAnim.keyPath)
    }
    
}

fileprivate extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image!.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
}
