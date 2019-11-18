//
//  AccountViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

class AccountViewController: UIViewController, Storyboarded, SegueHandler {
    
    private lazy var signInViewController: SignInViewController = {
        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! SignInViewController
        viewController.delegate = self
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var profileViewController: ProfileTableViewController = {
        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileTableViewController") as! ProfileTableViewController
        viewController.delegate = self
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    var viewModel: AccountViewModel!
    
    static var storyboardName: String = "Account"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = view.tintColor
        restoreClearNavigationBar(with: ColorPalette.navigationBarBackgroundColor)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        setupContainerView()
        setupNavigationBar()
    }
    
    private func setupContainerView() {
        viewModel.isUserSignedIn() ? showProfileView() : showSignInView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.NavigationItemTitle
    }
    
    private func showSignInView(withAnimatedNavigationBar animated: Bool = false) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        remove(asChildViewController: profileViewController)
        add(asChildViewController: signInViewController)
    }
    
    private func showProfileView(withAnimatedNavigationBar animated: Bool = false) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        remove(asChildViewController: signInViewController)
        // Rebuild the profile view model to show an up to date profile.
        profileViewController.viewModel = viewModel.buildProfileViewModel()
        add(asChildViewController: profileViewController)
    }
    
    private func didSignIn() {
        showProfileView(withAnimatedNavigationBar: true)
        signInViewController.stopLoading()
    }
    
    private func didSignOut() {
        showSignInView(withAnimatedNavigationBar: true)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel.showAuthPermission = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.performSegue(withIdentifier: .authPermission)
        }
        viewModel.didSignIn = { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.didSignIn()
            }
        }
        viewModel.didReceiveError = { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.signInViewController.stopLoading()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .authPermission:
            guard let navController = segue.destination as? UINavigationController,
                let viewController = navController.topViewController as? AuthPermissionViewController else {
                    fatalError()
            }
            _ = viewController.view
            viewController.delegate = self
            viewController.viewModel = viewModel.buildAuthPermissionViewModel()
        case .collectionList:
            guard let viewController = segue.destination as? CollectionListViewController else { fatalError() }
            guard let viewModel = sender as? CollectionListViewModel else { return }
            _ = viewController.view
            viewController.viewModel = viewModel
        case.customLists:
            guard let viewController = segue.destination as? CustomListsViewController else { fatalError() }
            guard let viewModel = sender as? CustomListsViewModel else { return }
            _ = viewController.view
            viewController.viewModel = viewModel
        }
    }
    
}

// MARK: - SignInViewControllerDelegate

extension AccountViewController: SignInViewControllerDelegate {
    
    func signInViewController(_ signInViewController: SignInViewController, didTapSignInButton tapped: Bool) {
        signInViewController.startLoading()
        viewModel.getRequestToken()
    }
    
}

// MARK: - ProfileViewControllerDelegate

extension AccountViewController: ProfileViewControllerDelegate {
    
    func profileViewController(didTapCollection collection: ProfileCollectionOption) {
        let segueIdentifier = SegueIdentifier.collectionList.rawValue
        performSegue(withIdentifier: segueIdentifier,
                     sender: viewModel.buildCollectionListViewModel(collection))
    }
    
    func profileViewController(didTapGroup group: ProfileGroupOption) {
        performSegue(withIdentifier: SegueIdentifier.customLists.rawValue,
                     sender: viewModel.buildCrearedListsViewModel(group))
    }
    
    func profileViewController(didTapSignOutButton tapped: Bool) {
        viewModel.signOutCurrentUser()
        didSignOut()
    }
    
}

// MARK: - AuthPermissionViewControllerDelegate

extension AccountViewController: AuthPermissionViewControllerDelegate {
    
    func authPermissionViewController(_ authPermissionViewController: AuthPermissionViewController,
                                      didSignedIn signedIn: Bool) {
        if signedIn { viewModel.getAccessToken() }
    }
    
}

// MARK: - Segue Identifiers

extension AccountViewController {
    
    enum SegueIdentifier: String {
        case authPermission = "AuthPermissionSegue"
        case collectionList = "CollectionListSegue"
        case customLists = "CustomListsSegue"
    }
    
}

// MARK: - Constants

extension AccountViewController {
    
    struct Constants {
        
        static let Title = NSLocalizedString("accountTabBarTitle", comment: "")
        static let NavigationItemTitle = NSLocalizedString("accountTitle", comment: "")
        
    }
    
}
