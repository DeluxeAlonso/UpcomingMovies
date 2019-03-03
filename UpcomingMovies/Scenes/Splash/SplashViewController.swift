//
//  SplashViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    private var viewModel: SplashViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupBindables()
        viewModel.getMovieGenres()
    }
    
    // MARK: - Private
    
    private func setupViewModel() {
        viewModel = SplashViewModel(managedObjectContext: managedObjectContext)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel.genresFetched = { [weak self] in
            self?.appDelegate?.initialTransition()
        }
    }

}
