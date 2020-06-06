//
//  AccountViewFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/6/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class AccountViewFactory {
    
    weak var accountViewProtocol: AccountViewControllerProtocol?
    
    // MARK: - Initializers
    
    init(_ accountViewProtocol: AccountViewControllerProtocol) {
        self.accountViewProtocol = accountViewProtocol
    }
    
    // MARK: - Public
    
    func makeSignInViewController() -> SignInViewController {
        let viewController = SignInViewController.instantiate()
        viewController.delegate = accountViewProtocol
        return viewController
    }
    
    func makeProfileViewController() -> ProfileTableViewController {
        let viewController = ProfileTableViewController.instantiate()
        viewController.delegate = accountViewProtocol
        viewController.viewModel = accountViewProtocol?.viewModel.buildProfileViewModel()
        return viewController
    }
    
}
