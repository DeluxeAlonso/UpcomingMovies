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

    func show(with configuration: HudConfigurationProtocol, completion: ((Bool) -> Void)? = nil) {
        if hudContainerView != nil { hideHudContainerView() }
        hudContainerView = HudContainerView(configuration: configuration)

        guard let hudContainerView = hudContainerView else { return }
        hudContainerView.alpha = 0.0

        let mainWindow = UIApplication.shared.windows.first ?? UIWindow()
        mainWindow.addSubview(hudContainerView)

        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            hudContainerView.alpha = 1.0
        }, completion: { completed in
            completion?(completed)
        })
    }

    func hideHudContainerView() {
        self.hudContainerView?.alpha = 0.0
        self.hudContainerView?.removeFromSuperview()
        self.hudContainerView = nil
    }

}

class HudContainerView: UIView {

    private lazy var hudContentView: UIView = {
        let view = UIView()
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
    }

}

protocol HudConfigurationProtocol {

//    private var colorBackground = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
//    private var colorHUD = UIColor.systemBlue
//    private var colorStatus = UIColor.label
//    private var colorAnimation = UIColor.lightGray
//
//    private var fontStatus = UIFont.boldSystemFont(ofSize: 24)

    var backgroundColor: UIColor { get }
    var hudColor: UIColor { get }
    var activityIndicatorColor: UIColor { get }

    var textColor: UIColor { get }
    var textFont: UIFont { get }

}

class HudActivityIndicatorView: UIView {

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

class HudSuccessView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

class HudErrorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
