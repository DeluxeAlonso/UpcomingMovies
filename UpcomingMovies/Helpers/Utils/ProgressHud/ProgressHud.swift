//
//  ProgressHud.swift
//  UpcomingMovies
//
//  Created by Alonso on 13/11/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

public enum AnimationType {
    case systemActivityIndicator
}

public extension ProgressHUD {

    class var animationType: AnimationType {
        get { shared.animationType }
        set { shared.animationType = newValue }
    }

    class var colorBackground: UIColor {
        get { shared.colorBackground }
        set { shared.colorBackground = newValue }
    }

    class var colorHUD: UIColor {
        get { shared.colorHUD }
        set { shared.colorHUD = newValue }
    }

    class var colorStatus: UIColor {
        get { shared.colorStatus }
        set { shared.colorStatus = newValue }
    }

    class var colorAnimation: UIColor {
        get { shared.colorAnimation }
        set { shared.colorAnimation = newValue }
    }

    class var fontStatus: UIFont {
        get { shared.fontStatus }
        set { shared.fontStatus = newValue }
    }

    class var imageSuccess: UIImage {
        get { shared.imageSuccess }
        set { shared.imageSuccess = newValue }
    }

    class var imageError: UIImage {
        get { shared.imageError }
        set { shared.imageError = newValue }
    }
}

public extension ProgressHUD {

    class func dismiss() {
        DispatchQueue.main.async {
            shared.hudHide()
        }
    }

    class func show(_ status: String? = nil, interaction: Bool = true) {
        DispatchQueue.main.async {
            shared.setup(status: status, hide: false, interaction: interaction)
        }
    }

    class func showSuccess(_ status: String? = nil, image: UIImage? = nil, interaction: Bool = true) {
        DispatchQueue.main.async {
            shared.setup(status: status, staticImage: image ?? shared.imageSuccess, hide: true, interaction: interaction)
        }
    }

    class func showError(_ status: String? = nil, image: UIImage? = nil, interaction: Bool = true) {
        DispatchQueue.main.async {
            shared.setup(status: status, staticImage: image ?? shared.imageError, hide: true, interaction: interaction)
        }
    }

}

public class ProgressHUD: UIView {

    private var containerView: UIView?

    private var hudContentView: UIView?
    private var labelStatus: UILabel?

    private var viewAnimation: UIView?
    private var staticImageView: UIImageView?

    private var timer: Timer?

    private var animationType = AnimationType.systemActivityIndicator

    private var colorBackground = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    private var colorHUD = UIColor.systemBlue
    private var colorStatus = UIColor.label
    private var colorAnimation = UIColor.lightGray

    private var fontStatus = UIFont.boldSystemFont(ofSize: 24)
    private var imageSuccess = UIImage.checkmark.withTintColor(UIColor.systemGreen, renderingMode: .alwaysOriginal)
    private var imageError = UIImage.remove.withTintColor(UIColor.systemRed, renderingMode: .alwaysOriginal)

    private let keyboardWillShow = UIResponder.keyboardWillShowNotification
    private let keyboardWillHide = UIResponder.keyboardWillHideNotification
    private let keyboardDidShow = UIResponder.keyboardDidShowNotification
    private let keyboardDidHide = UIResponder.keyboardDidHideNotification

    private let orientationDidChange = UIDevice.orientationDidChangeNotification

    static let shared: ProgressHUD = {
        let instance = ProgressHUD()
        return instance
    }()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    convenience private init() {
        self.init(frame: UIScreen.main.bounds)
        self.alpha = 0
    }

    required internal init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override private init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func setup(status: String? = nil, staticImage: UIImage? = nil, hide: Bool, interaction: Bool) {
        setupNotifications()
        setupBackground(interaction)
        setupToolbar()
        setupLabel(status)

        if (staticImage == nil) { setupAnimation() }
        if (staticImage != nil) { setupStaticImage(staticImage)}

        setupSize()
        setupPosition()

        hudShow()

        if (hide) {
            let text = labelStatus?.text ?? ""
            let delay = Double(text.count) * 0.03 + 1.25
            timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
                self.hudHide()
            }
        }
    }

    private func setupNotifications() {
        if (containerView == nil) {
            NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardWillHide, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardDidShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: keyboardDidHide, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(setupPosition(_:)), name: orientationDidChange, object: nil)
        }
    }

    private func setupBackground(_ interaction: Bool) {
        if (containerView == nil) {
            let mainWindow = UIApplication.shared.windows.first ?? UIWindow()
            containerView = UIView(frame: self.bounds)
            mainWindow.addSubview(containerView!)
        }

        containerView?.backgroundColor = interaction ? .clear : colorBackground
        containerView?.isUserInteractionEnabled = (interaction == false)
    }

    private func setupToolbar() {
        if (hudContentView == nil) {
            hudContentView = UIView(frame: CGRect.zero)
            hudContentView?.clipsToBounds = true
            hudContentView?.layer.cornerRadius = 10
            hudContentView?.layer.masksToBounds = true
            containerView?.addSubview(hudContentView!)
        }

        hudContentView?.backgroundColor = colorHUD
    }

    private func setupLabel(_ status: String?) {
        if (labelStatus == nil) {
            labelStatus = UILabel()
            labelStatus?.textAlignment = .center
            labelStatus?.baselineAdjustment = .alignCenters
            labelStatus?.numberOfLines = 0
            hudContentView?.addSubview(labelStatus!)
        }

        labelStatus?.text = (status != "") ? status : nil
        labelStatus?.font = fontStatus
        labelStatus?.textColor = colorStatus
        labelStatus?.isHidden = (status == nil) ? true : false
    }

    private func setupAnimation() {
        staticImageView?.removeFromSuperview()

        if (viewAnimation == nil) {
            viewAnimation = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        }

        if (viewAnimation?.superview == nil) {
            hudContentView?.addSubview(viewAnimation!)
        }

        viewAnimation?.subviews.forEach {
            $0.removeFromSuperview()
        }

        viewAnimation?.layer.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }

        if (animationType == .systemActivityIndicator) {
            animationSystemActivityIndicator(viewAnimation!)
        }
    }

    private func setupStaticImage(_ staticImage: UIImage?) {
        viewAnimation?.removeFromSuperview()

        if (staticImageView == nil) {
            staticImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        }

        if (staticImageView?.superview == nil) {
            hudContentView?.addSubview(staticImageView!)
        }

        staticImageView?.image = staticImage
        staticImageView?.contentMode = .scaleAspectFit
    }

    private func setupSize() {
        var width: CGFloat = 120
        var height: CGFloat = 120

        if let text = labelStatus?.text {
            let sizeMax = CGSize(width: 250, height: 250)
            let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: labelStatus?.font as Any]
            var rectLabel = text.boundingRect(with: sizeMax, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

            width = ceil(rectLabel.size.width) + 60
            height = ceil(rectLabel.size.height) + 120

            if (width < 120) { width = 120 }

            rectLabel.origin.x = (width - rectLabel.size.width) / 2
            rectLabel.origin.y = (height - rectLabel.size.height) / 2 + 45

            labelStatus?.frame = rectLabel
        }

        hudContentView?.bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let centerX = width/2
        var centerY = height/2

        if (labelStatus?.text != nil) { centerY = 55 }
        viewAnimation?.center = CGPoint(x: centerX, y: centerY)
        staticImageView?.center = CGPoint(x: centerX, y: centerY)
    }

    @objc private func setupPosition(_ notification: Notification? = nil) {

        var heightKeyboard: CGFloat = 0
        var animationDuration: TimeInterval = 0

        if let notification = notification {
            let frameKeyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? CGRect.zero
            animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0

            if (notification.name == keyboardWillShow) || (notification.name == keyboardDidShow) {
                heightKeyboard = frameKeyboard.size.height
            } else if (notification.name == keyboardWillHide) || (notification.name == keyboardDidHide) {
                heightKeyboard = 0
            }
        }

        let mainWindow = UIApplication.shared.windows.first ?? UIWindow()
        let screen = mainWindow.bounds
        let center = CGPoint(x: screen.size.width/2, y: (screen.size.height-heightKeyboard)/2)

        UIView.animate(withDuration: animationDuration, delay: 0, options: .allowUserInteraction, animations: {
            self.hudContentView?.center = center
            self.containerView?.frame = screen
        }, completion: nil)
    }

    private func hudShow() {
        timer?.invalidate()
        timer = nil

        if self.alpha != 1 {
            self.alpha = 1
            hudContentView?.alpha = 0
            hudContentView?.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)

            UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
                self.hudContentView?.transform = CGAffineTransform(scaleX: 1/1.4, y: 1/1.4)
                self.hudContentView?.alpha = 1
            }, completion: nil)
        }
    }

    private func hudHide() {
        if self.alpha == 1 {
            UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
                self.hudContentView?.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                self.hudContentView?.alpha = 0
            }, completion: { _ in
                self.hudDestroy()
                self.alpha = 0
            })
        }
    }

    private func hudDestroy() {
        staticImageView?.removeFromSuperview()
        staticImageView = nil

        viewAnimation?.removeFromSuperview()
        viewAnimation = nil

        labelStatus?.removeFromSuperview()
        labelStatus = nil

        hudContentView?.removeFromSuperview()
        hudContentView = nil

        containerView?.removeFromSuperview()
        containerView = nil

        timer?.invalidate()
        timer = nil
    }

    // MARK: - Animation

    private func animationSystemActivityIndicator(_ view: UIView) {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.frame = view.bounds
        spinner.color = colorAnimation
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        view.addSubview(spinner)
    }

}
