//
//  SplashViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController, Storyboarded {

    static var storyboardName: String = "Main"

    var viewModel: SplashViewModelProtocol?
    var navigationHandler: NavigationHandlerProtocol?

    // MARK: - Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // We can only get the window and scene of this view controller
        // only after it has been added to the window hierarchy
        setupBindables()
        viewModel?.startInitialDownloads()
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        viewModel?.initialDownloadsEnded.bind({ [weak self] in
            guard let self = self else { return }
            self.navigationHandler?.initialTransition(from: self.view.window)
        }, on: .main)
    }

}
