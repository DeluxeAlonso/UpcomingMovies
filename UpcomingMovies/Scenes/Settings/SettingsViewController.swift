//
//  SettingsViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = Constants.NavigationItemTitle
    }
    
}

// MARK: - Constants

extension SettingsViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("settingsTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("settingsTitle", comment: "")
        
    }
    
}
