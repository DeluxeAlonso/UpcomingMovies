//
//  AccountMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/14/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class MockAccountInteractor: AccountInteractorProtocol {

    var permissionURLResult: Result<URL, Error>?
    func getAuthPermissionURL(completion: @escaping (Result<URL, Error>) -> Void) {
        if let permissionURLResult {
            completion(permissionURLResult)
        }
    }

    var signInUserResult: Result<User, Error>?
    func signInUser(completion: @escaping (Result<User, Error>) -> Void) {
        if let signInUserResult {
            completion(signInUserResult)
        }
    }

    var signOutUserResult: Result<Bool, Error>?
    func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        if let signOutUserResult {
            completion(signOutUserResult)
        }
    }

    var currentUserResult: User?
    func currentUser() -> User? {
        currentUserResult
    }

    func signOutUser() {}

}
