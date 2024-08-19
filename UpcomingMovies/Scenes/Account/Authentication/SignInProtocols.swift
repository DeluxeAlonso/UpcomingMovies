//
//  SignInProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol SignInViewModelProtocol {

    var startLoading: AnyBehaviorBindable<Bool> { get }
    var showAuthPermission: AnyPublishBindable<URL> { get }
    var didUpdateAuthenticationState: AnyBehaviorBindable<AuthenticationState?> { get }
    var didReceiveError: AnyPublishBindable<Void> { get }

    func startAuthorizationProcess()
    func signInUser()

    var signInButtonTitle: String? { get }

}

protocol SignInInteractorProtocol {

    func getAuthPermissionURL(completion: @escaping (Result<URL, Error>) -> Void)
    func signInUser(completion: @escaping (Result<User, Error>) -> Void)

}

protocol SignInCoordinatorProtocol: AnyObject {

    func showAuthPermission(for authPermissionURL: URL,
                            and authPermissionDelegate: AuthPermissionViewControllerDelegate)

}

protocol SignInViewControllerDelegate: UIViewController, AuthenticationStateDelegate {}
