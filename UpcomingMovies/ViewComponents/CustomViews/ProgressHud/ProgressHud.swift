//
//  ProgressHud.swift
//  UpcomingMovies
//
//  Created by Alonso on 13/11/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

import UIKit

class ProgressHud {

    enum Mode {
        case activityIndicator
        case activityIndicatorWithText(text: String)
    }

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

        UIView.animate(withDuration: configuration.presentationAnimationDuration,
                       delay: 0.0,
                       options: [.curveEaseOut], animations: {
            hudContainerView.alpha = 1.0
        }, completion: { completed in
            completion?(completed)
        })
    }

    func dismiss(with animationDuration: TimeInterval = 0.0) {
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.curveEaseOut], animations: {
            self.hudContainerView?.alpha = 0.0
        }, completion: { _ in
            self.hudContainerView?.removeFromSuperview()
            self.hudContainerView = nil
        })
    }

}
