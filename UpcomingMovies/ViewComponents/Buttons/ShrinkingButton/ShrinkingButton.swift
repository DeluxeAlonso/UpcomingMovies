//
//  ShrinkingButton.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

@IBDesignable
final class ShrinkingButton: UIButton {

    @IBInspectable var spinnerColor: UIColor = UIColor.white {
        didSet {
            spiner.spinnerColor = spinnerColor
        }
    }

    @IBInspectable var disabledBackgroundColor: UIColor = UIColor.lightGray {
        didSet {
            setBackgroundImage(UIImage(color: disabledBackgroundColor), for: .disabled)
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
        layer.addSublayer(spiner)
        return spiner
    }()

    private var cachedTitle: String?
    private var cachedImage: UIImage?

    private let shrinkCurve: CAMediaTimingFunction = CAMediaTimingFunction(name: .linear)
    private let shrinkDuration: CFTimeInterval = 0.1

    private var isAnimating: Bool = false

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: - Lifecycle

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        spiner.updateFrame(frame)
    }

    // MARK: - Private

    private func setupUI() {
        clipsToBounds = true
        spiner.spinnerColor = spinnerColor
    }

    private func setOriginalState(completion: (() -> Void)?) {
        animateToOriginalWidth(completion: completion)
        spiner.stopAnimation()
        setTitle(self.cachedTitle, for: .normal)
        setImage(self.cachedImage, for: .normal)
        isUserInteractionEnabled = true
        layer.cornerRadius = self.cornerRadius
        isAnimating = false
    }

    private func animateToOriginalWidth(completion: (() -> Void)?) {
        let shrinkAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnimation.fromValue = (self.bounds.height)
        shrinkAnimation.toValue = (self.bounds.width)
        shrinkAnimation.duration = shrinkDuration
        shrinkAnimation.timingFunction = shrinkCurve
        shrinkAnimation.fillMode = .forwards
        shrinkAnimation.isRemovedOnCompletion = false

        CATransaction.setCompletionBlock { completion?() }
        layer.add(shrinkAnimation, forKey: shrinkAnimation.keyPath)

        CATransaction.commit()
    }

    private func shrink() {
        let shrinkAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnimation.fromValue = frame.width
        shrinkAnimation.toValue = frame.height
        shrinkAnimation.duration = shrinkDuration
        shrinkAnimation.timingFunction = shrinkCurve
        shrinkAnimation.fillMode = .forwards
        shrinkAnimation.isRemovedOnCompletion = false

        layer.add(shrinkAnimation, forKey: shrinkAnimation.keyPath)
    }

    // MARK: - Internal

    func startAnimation() {
        isAnimating = true
        isUserInteractionEnabled = false

        cachedTitle = title(for: .normal)
        cachedImage = image(for: .normal)

        setTitle("", for: .normal)
        setImage(nil, for: .normal)

        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.layer.cornerRadius = self.frame.height / 2
        }, completion: { _ in
            self.shrink()
            self.spiner.animation()
        })
    }

    func stopAnimation(revertAfterDelay delay: TimeInterval = 1.0, completion: (() -> Void)? = nil) {
        guard isAnimating else { return }

        // Delay should have a minimum value
        let delayToRevert = max(delay, 0.2)

        DispatchQueue.main.asyncAfter(deadline: .now() + delayToRevert) {
            self.setOriginalState { [weak self] in
                self?.layer.removeAllAnimations()
                completion?()
            }
        }
    }

}

private extension UIImage {

    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()

        guard let cgImage = image.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

}
