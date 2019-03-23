//
//  AccountViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, SegueHandler {
    
    private lazy var loginViewController: UIViewController = {
        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        viewController.delegate = self
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var profileViewController: UIViewController = {
        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private var viewModel = AccountViewModel()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupContainerView()
        setupNavigationBar()
    }
    
    private func setupContainerView() {
        navigationController?.navigationBar.isHidden = true
        add(asChildViewController: loginViewController)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.NavigationItemTitle
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)

        view.addSubview(viewController.view)

        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func didSignIn() {
        remove(asChildViewController: loginViewController)
        add(asChildViewController: profileViewController)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel.showAuthPermission = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.performSegue(withIdentifier: SegueIdentifier.authPermission.rawValue, sender: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .authPermission:
            guard let navController = segue.destination as? UINavigationController,
                let viewController = navController.topViewController as? AuthPermissionViewController else {
                    return
            }
            _ = viewController.view
            viewController.viewModel = viewModel.buildAuthPermissionViewModel()
        }
    }
    
}

// MARK: - LoginViewControllerDelegate

extension AccountViewController: LoginViewControllerDelegate {
    
    func loginViewController(_ loginViewController: LoginViewController, didTapLoginButton tapped: Bool) {
        viewModel.getRequestToken()
        //didSignIn()
    }
    
}

// MARK: - Segue Identifiers

extension AccountViewController {
    
    enum SegueIdentifier: String {
        case authPermission = "AuthPermissionSegue"
    }
    
}

// MARK: - Constants

extension AccountViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("accountTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("accountTitle", comment: "")
        
    }
    
}
