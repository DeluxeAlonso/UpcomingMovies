//
//  HudContainerView.swift
//  UpcomingMovies
//
//  Created by Alonso on 17/11/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

class HudContainerView: UIView {

    private lazy var hudContentView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.clipsToBounds = true
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
        backgroundColor = configuration.backgroundColor

        hudContentView.backgroundColor = configuration.hudColor
        hudContentView.layer.cornerRadius = configuration.hudContentCornerRadius

        addSubview(hudContentView)
        hudContentView.centerInSuperview()
        hudContentView.constraintHeight(constant: configuration.hudContentPreferredHeight)
        hudContentView.constraintWidth(constant: configuration.hudContentPreferredWidth)

        let indicatorView = HudActivityIndicatorView(configuration: configuration)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        hudContentView.contentView.addSubview(indicatorView)
        indicatorView.fillSuperview()
    }

}

class HudActivityIndicatorView: UIView {

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
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
        activityIndicatorView.color = configuration.activityIndicatorColor
        activityIndicatorView.style = configuration.activityIndicatorStyle

        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
    }

}
