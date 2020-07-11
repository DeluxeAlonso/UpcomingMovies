//
//  AccountViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, AccountViewControllerProtocol, Storyboarded {
    
    private var signInViewController: SignInViewController?
    private var profileViewController: ProfileTableViewController?
    
    static var storyboardName: String = "Account"
    
    var viewModel: AccountViewModelProtocol!
    weak var coordinator: AccountCoordinatorProtocol?
    
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
        restoreNavigationBar(with: ColorPalette.navigationBarBackgroundColor)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = LocalizedStrings.accountTabBarTitle.localized
        setupContainerView()
        setupNavigationBar()
    }
    
    private func setupContainerView() {
        viewModel.isUserSignedIn() ? showProfileView() : showSignInView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = LocalizedStrings.accountTitle.localized
    }
    
    private func showSignInView(withAnimatedNavigationBar animated: Bool = false) {
        signInViewController = coordinator?.embedSignInViewController(on: self)
        coordinator?.removeChildViewController(&profileViewController, from: self)
    }
    
    private func showProfileView(withAnimatedNavigationBar animated: Bool = false) {
        guard let viewModel = viewModel else { return }
        profileViewController = coordinator?.embedProfileViewController(on: self,
                                                                        for: viewModel.currentUserAccount(),
                                                                        and: viewModel.profileOptions())
        
        coordinator?.removeChildViewController(&signInViewController, from: self)
    }
    
    private func didSignIn() {
        showProfileView(withAnimatedNavigationBar: true)
    }
    
    private func didSignOut() {
        showSignInView(withAnimatedNavigationBar: true)
    }
    
    // MARK: - Reactive Behaviour
    
    private func setupBindables() {
        viewModel.showAuthPermission.bind { [weak self] authPermissionURL in
            guard let strongSelf = self else { return }
            strongSelf.coordinator?.showAuthPermission(for: authPermissionURL,
                                                       and: strongSelf)
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
                strongSelf.signInViewController?.stopLoading()
            }
        }
    }
    
}

// MARK: - SignInViewControllerDelegate

extension AccountViewController {
    
    func signInViewController(_ signInViewController: SignInViewController, didTapSignInButton tapped: Bool) {
        signInViewController.startLoading()
        viewModel.getRequestToken()
    }
    
}

// MARK: - ProfileViewControllerDelegate

extension AccountViewController {
    
    func profileViewController(didTapCollection collection: ProfileCollectionOption) {
        coordinator?.showSavedMovies(for: collection)
    }
    
    func profileViewController(didTapGroup group: ProfileGroupOption) {
        coordinator?.showCustomLists(for: group)
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
