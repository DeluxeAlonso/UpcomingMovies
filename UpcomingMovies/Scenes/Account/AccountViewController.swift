//
//  AccountViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

protocol AccountViewControllerProtocol: UIViewController, SignInViewControllerDelegate, ProfileViewControllerDelegate {
    
    var viewModel: AccountViewModel! { get set }
    
}

class AccountViewController: UIViewController, AccountViewControllerProtocol, Storyboarded, SegueHandler {
    
    private var accountViewFactory: AccountViewFactory!
    private var signInViewController: SignInViewController?
    private var profileViewController: ProfileTableViewController?
    
    var viewModel: AccountViewModel!
    weak var coordinator: AccountCoordinator?
    
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
        restoreNavigationBar(with: ColorPalette.navigationBarBackgroundColor)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        title = Constants.Title
        accountViewFactory = AccountViewFactory(self)
        
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
                strongSelf.signInViewController?.stopLoading()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .authPermission:
            guard let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.topViewController as? AuthPermissionViewController else {
                    fatalError()
            }
            _ = viewController.view
            viewController.delegate = self
            viewController.viewModel = viewModel.buildAuthPermissionViewModel()
        case .collectionList:
            guard let viewController = segue.destination as? SavedMoviesViewController else { fatalError() }
            guard let viewModel = sender as? SavedMoviesViewModel else { return }
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

extension AccountViewController {
    
    func signInViewController(_ signInViewController: SignInViewController, didTapSignInButton tapped: Bool) {
        signInViewController.startLoading()
        viewModel.getRequestToken()
    }
    
}

// MARK: - ProfileViewControllerDelegate

extension AccountViewController {
    
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
