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

    var showAuthPermission: AnyPublishBindable<URL> { get }
    var didReceiveError: AnyPublishBindable<Void> { get }

    func isUserSignedIn() -> Bool
    func currentUser() -> User?

}

protocol AccountInteractorProtocol {

    func currentUser() -> User?

}

protocol AccountCoordinatorProtocol: AnyObject {

    func embedSignInViewController(on parentViewController: SignInViewControllerDelegate)
    func embedProfileViewController(on parentViewController: ProfileViewControllerDelegate, for user: User)

    func removeSignInViewController(from parentViewController: UIViewController)
    func removeProfileViewController(from parentViewController: UIViewController)

    func showProfileOption(_ profileOption: ProfileOptionProtocol)

}
