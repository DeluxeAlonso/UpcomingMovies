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
        backgroundColor = configuration.backgroundColor

        hudContentView.backgroundColor = configuration.hudColor

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
