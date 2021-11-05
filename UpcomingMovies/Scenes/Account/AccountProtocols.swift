//
//  AccountProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol AccountViewModelProtocol {

    var showAuthPermission: Bindable<URL?> { get }
    var didSignIn: (() -> Void)? { get set }
    var didReceiveError: (() -> Void)? { get set }

    func startAuthorizationProcess()
    func signInUser()
    func signOutCurrentUser()

    func isUserSignedIn() -> Bool
    func currentUser() -> User?

}

protocol AccountInteractorProtocol {

    func getAuthPermissionURL(completion: @escaping (Result<URL, Error>) -> Void)
    func signInUser(completion: @escaping (Result<User, Error>) -> Void)
    func signOutUser()
    func currentUser() -> User?

}

protocol AccountCoordinatorProtocol: AnyObject {

    func embedSignInViewController(on parentViewController: SignInViewControllerDelegate) -> SignInViewController
    func embedProfileViewController(on parentViewController: ProfileViewControllerDelegate,
                                    for user: User?) -> ProfileViewController

    func removeChildViewController<T: UIViewController>(_ viewController: inout T?,
                                                        from parentViewController: UIViewController)

    func showAuthPermission(for authPermissionURL: URL?,
                            and authPermissionDelegate: AuthPermissionViewControllerDelegate)

    func showProfileOption(_ profileOption: ProfileOptionProtocol)

}
