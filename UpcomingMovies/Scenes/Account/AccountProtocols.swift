//
//  AccountProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

protocol AccountViewModelProtocol {

    var showAuthPermission: AnyPublishBindable<URL> { get }
    var didReceiveError: AnyPublishBindable<Void> { get }

    var title: String? { get }
    var navigationItemTitle: String? { get }

    func isUserSignedIn() -> Bool
    func currentUser() -> UserProtocol?

}

protocol AccountInteractorProtocol {

    func currentUser() -> UserProtocol?

}

protocol AccountCoordinatorProtocol: AnyObject {

    func embedSignInViewController(on parentViewController: SignInViewControllerDelegate)
    func embedProfileViewController(on parentViewController: ProfileViewControllerDelegate, for user: UserProtocol)

    func removeSignInViewController(from parentViewController: UIViewController)
    func removeProfileViewController(from parentViewController: UIViewController)

    func showProfileOption(_ profileOption: ProfileOptionProtocol)

}
