//
//  ErrorPlaceholderView.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

protocol ErrorAnimatable {
    func playAnimation()
    func stopAnimation()
}

protocol ErrorPlaceholderViewDelegate: class {
    
    func errorPlaceholderView(_ errorPlaceholderView: ErrorPlaceholderView, didRetry sender: UIButton)
    
}

class ErrorPlaceholderView: UIView, NibLoadable {
    
    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorDetailLabel: UILabel!
    @IBOutlet weak var retryButton: ShrinkingButton!
    
    private var animationDuration = 0.3
    
    var isPresented: Bool = false
    var retry: (() -> Void)?
    
    weak var delegate: ErrorPlaceholderViewDelegate?
    
    var detailText: String? {
        didSet {
            guard let detailText = detailText else { return }
            errorDetailLabel.text = detailText
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    // MARK: - Private
    
    fileprivate func setupUI() {
        alpha = 0.0
        setupErrorTitleLabel()
        setupErrorDetailLabel()
        setupRetryButton()
    }
    
    fileprivate func setupErrorTitleLabel() {
        errorTitleLabel.text = Constants.errorTitle
        errorTitleLabel.textColor = ColorPalette.darkGray
        errorTitleLabel.font = FontHelper.regular(withSize: 24.0)
    }
    
    fileprivate func setupErrorDetailLabel() {
        errorDetailLabel.text = Constants.errorDetail
        errorDetailLabel.textColor = ColorPalette.lightGray
        errorDetailLabel.font = FontHelper.light(withSize: 15.0)
    }
    
    fileprivate func setupRetryButton() {
        retryButton.setTitle(Constants.retryButtonTitle, for: .normal)
        retryButton.layer.cornerRadius = 5
        retryButton.backgroundColor = ColorPalette.lightBlueColor
        retryButton.setTitleColor(ColorPalette.whiteColor, for: .normal)
        retryButton.setTitleColor(ColorPalette.whiteColor.withAlphaComponent(0.5), for: .highlighted)
        retryButton.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
    }
    
    private func show(animated: Bool = true, completion: ((Bool) -> Swift.Void)? = nil) {
        self.superview?.bringSubviewToFront(self)
        if animated {
            UIView.animate(withDuration: self.animationDuration, animations: { self.alpha = 1 }, completion: completion)
        } else {
            self.alpha = 1
            completion?(true)
        }
    }
    
    // MARK: - Selectors
    
    @objc private func retryAction() {
        playAnimation()
        retry?()
    }
    
}

// MARK: - ErrorAnimatable

extension ErrorPlaceholderView: ErrorAnimatable {
    
    func playAnimation() {
        retryButton.startAnimation()
    }
    
    func stopAnimation() {
        retryButton.stopAnimation()
    }
    
}

// MARK: - ErrorDisplayable

extension ErrorPlaceholderView {
    
    static func show<T: ErrorPlaceholderView>(
        fromViewController viewController: UIViewController,
        animated: Bool = true,
        completion: ((Bool) -> Swift.Void)? = nil) -> T {
        
        guard let subview = loadFromNib() as? T else {
            fatalError("The subview is expected to be of type \(T.self)")
        }
        
        viewController.view.addSubview(subview)
        
        // Configure constraints if needed
        
        subview.alpha = 0
        subview.isPresented = true
        subview.superview?.sendSubviewToBack(subview)
        subview.show(animated: animated) { _ in
        }
        return subview
    }
    
    static func show<T: ErrorPlaceholderView>(
        fromView view: UIView,
        insets: UIEdgeInsets = UIEdgeInsets.zero,
        animated: Bool = true,
        completion: ((Bool) -> Swift.Void)? = nil) -> T {
        guard let subview = loadFromNib() as? T else {
            fatalError("The subview is expected to be of type \(T.self)")
        }
        
        view.addSubview(subview)
        
        // Configure constraints if needed
        
        subview.alpha = 0
        subview.isPresented = true
        subview.superview?.sendSubviewToBack(subview)
        subview.show(animated: animated) { _ in
        }
        return subview
    }
    
    func hide(animated: Bool = true, completion: ((Bool) -> Swift.Void)? = nil) {
        self.isPresented = false
        let closure: (Bool) -> Void = { (finished) in
            if finished {
                self.removeFromSuperview()
            }
        }
        if animated {
            UIView.animate(withDuration: self.animationDuration,
                           delay: 0.25,
                           animations: { self.alpha = 0 }, completion: { (finished) in
                            closure(finished)
                            completion?(finished)
            })
        } else {
            self.alpha = 0
            closure(true)
            completion?(true)
        }
    }
    
}

// MARK: - Constants

extension ErrorPlaceholderView {
    
    struct Constants {
        static let errorTitle = "¡Ups!"
        static let errorDetail = "Something went wrong."
        static let retryButtonTitle = "Retry"
    }
    
}
