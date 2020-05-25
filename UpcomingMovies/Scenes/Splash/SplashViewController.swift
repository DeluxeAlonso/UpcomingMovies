//
//  SplashViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    private var viewModel = SplashViewModel()

    // MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // We can only get the window and scene of this view controller
        // only after it has been added to the window hierarchy
        setupBindables()
        viewModel.startInitialDownloads()
    }

    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel.initialDownloadsEnded = { [weak self] in
            guard let strongSelf = self else { return }
            NavigationHandler.initialTransition(from: strongSelf.view.window)
        }
    }

}
