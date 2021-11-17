//
//  ProgressHud.swift
//  UpcomingMovies
//
//  Created by Alonso on 13/11/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

class ProgressHud {

    static let shared = ProgressHud()

    private var hudContainerView: HudContainerView?

    init() {}

    func show(with configuration: HudConfigurationProtocol = DefaultHudConfiguration.shared,
              completion: ((Bool) -> Void)? = nil) {
        // If hud is already being shown we dismiss it.
        if hudContainerView != nil { dismiss() }

        hudContainerView = HudContainerView(configuration: configuration)
        guard let hudContainerView = hudContainerView else { return }
        hudContainerView.alpha = 0.0

        let mainWindow = UIApplication.shared.windows.first ?? UIWindow()
        mainWindow.addSubview(hudContainerView)

        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
            hudContainerView.alpha = 1.0
        }, completion: { completed in
            completion?(completed)
        })
    }

    func dismiss() {
        self.hudContainerView?.alpha = 0.0
        self.hudContainerView?.removeFromSuperview()
        self.hudContainerView = nil
    }

    func dismiss(with animationDuration: TimeInterval) {
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.curveEaseOut], animations: {
            self.hudContainerView?.alpha = 0.0
        }, completion: { _ in
            self.hudContainerView?.removeFromSuperview()
            self.hudContainerView = nil
        })
    }

}

class HudContainerView: UIView {

    private lazy var hudContentView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let configuration: HudConfigurationProtocol

    init(configuration: HudConfigurationProtocol) {
        self.configuration = configuration
        super.init(frame: UIScreen.main.bounds)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        hudContentView.backgroundColor = configuration.backgroundColor

        addSubview(hudContentView)
        hudContentView.centerInSuperview()
        hudContentView.constraintHeight(constant: 120)
        hudContentView.constraintWidth(constant: 120)

        let indicatorView = HudActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        hudContentView.contentView.addSubview(indicatorView)
        indicatorView.fillSuperview()
    }

}

class HudActivityIndicatorView: UIView {

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
