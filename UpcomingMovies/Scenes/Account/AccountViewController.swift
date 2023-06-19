//
//  AccountViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class AccountViewController: UIViewController, Storyboarded {

    private var signInViewController: SignInViewController?
    private var profileViewController: ProfileViewController?

    static var storyboardName: String = "Account"

    var viewModel: AccountViewModelProtocol?
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
        setDefaultAppearanceNavigationBar(with: ColorPalette.navigationBarBackgroundColor)
    }

    // MARK: - Private

    private func setupUI() {
        title = LocalizedStrings.accountTabBarTitle()
        setupContainerView()
        setupNavigationBar()
    }

    private func setupContainerView() {
        guard let viewModel else { return }
        viewModel.isUserSignedIn() ? showProfileView() : showSignInView()
    }

    private func setupNavigationBar() {
        navigationItem.title = LocalizedStrings.accountTitle()
    }

    private func showSignInView(withAnimatedNavigationBar animated: Bool = false) {
        coordinator?.embedSignInViewController(on: self)
        coordinator?.removeProfileViewController(from: self)
    }

    private func showProfileView(withAnimatedNavigationBar animated: Bool = false) {
        guard let viewModel = viewModel, let user = viewModel.currentUser() else { return }
        coordinator?.embedProfileViewController(on: self, for: user)
        coordinator?.removeSignInViewController(from: self)
    }

    // MARK: - Reactive Behavior

    private func setupBindables() {
        viewModel?.showAuthPermission.bind({ [weak self] authPermissionURL in
            guard let self = self else { return }
            self.coordinator?.showAuthPermission(for: authPermissionURL, and: self)
        }, on: .main)

        viewModel?.didUpdateAuthenticationState.bindAndFire({ [weak self] authState in
            guard let self = self, let authState else { return }
            switch authState {
            case .justSignedIn: self.showProfileView(withAnimatedNavigationBar: true)
            case .justSignedOut: self.showSignInView(withAnimatedNavigationBar: true)
            case .currentlySignedIn: self.showProfileView()
            case .currentlySignedOut: self.showSignInView()
            }
        }, on: .main)

        viewModel?.didReceiveError.bind({ [weak self] in
            guard let self = self else { return }
            self.signInViewController?.stopLoading()
        }, on: .main)
    }

}

// MARK: - SignInViewControllerDelegate

extension AccountViewController: SignInViewControllerDelegate {

    func signInViewController(_ signInViewController: SignInViewController, didTapSignInButton tapped: Bool) {
        // TODO: - Remove this temporal work around. Sign in logic should be placed in sign in scene.
        self.signInViewController = signInViewController
        signInViewController.startLoading()
        viewModel?.startAuthorizationProcess()
    }

}

// MARK: - ProfileViewControllerDelegate

extension AccountViewController: ProfileViewControllerDelegate {

    func profileViewController(didTapProfileOption option: ProfileOptionProtocol) {
        coordinator?.showProfileOption(option)
    }

    func profileViewController(didSignOut signedOut: Bool) {
        viewModel?.signOutCurrentUser()
        showSignInView(withAnimatedNavigationBar: true)
    }

}

// MARK: - AuthPermissionViewControllerDelegate

extension AccountViewController: AuthPermissionViewControllerDelegate {

    func authPermissionViewController(_ authPermissionViewController: AuthPermissionViewController,
                                      didReceiveAuthorization authorized: Bool) {
        if authorized { viewModel?.signInUser() }
    }

}
