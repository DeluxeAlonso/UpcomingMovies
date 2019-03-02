//
//  SplashViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CoreData

class SplashViewController: UIViewController {
    
    private var viewModel: SplashViewModel!

    private var managedObjectContext: NSManagedObjectContext {
        return PersistenceManager.shared.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SplashViewModel(managedObjectContext: managedObjectContext)
        setupBindables()
        viewModel.getMovieGenres()
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel.genresFetched = { [weak self] in
            self?.appDelegate?.initialTransition()
        }
    }

}
