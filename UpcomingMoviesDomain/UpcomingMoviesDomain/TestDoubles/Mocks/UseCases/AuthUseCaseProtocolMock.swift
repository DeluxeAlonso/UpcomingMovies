//
//  AuthUseCaseProtocolMock.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 7/07/23.
//

import Foundation

public final class AuthUseCaseProtocolMock: AuthUseCaseProtocol {

    var getAuthURLResult: Result<URL, Error>?
    private(set) var getAuthURLCallCount = 0
    public func getAuthURL(completion: @escaping (Result<URL, Error>) -> Void) {
        if let getAuthURLResult = getAuthURLResult {
            completion(getAuthURLResult)
        }
        getAuthURLCallCount += 1
    }

    var signInUserResult: Result<User, Error>?
    private(set) var signInUserCallCount = 0
    public func signInUser(completion: @escaping (Result<User, Error>) -> Void) {
        if let signInUserResult = signInUserResult {
            completion(signInUserResult)
        }
        signInUserCallCount += 1
    }

    var signOutUserResult: Result<Bool, Error>?
    private(set) var signOutUserCallCount = 0
    public func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        if let signOutUserResult = signOutUserResult {
            completion(signOutUserResult)
        }
        signOutUserCallCount += 1
    }

    var currentUserIdResult: Int?
    private(set) var currentUserIdCallCount = 0
    public func currentUserId() -> Int? {
        currentUserIdCallCount += 1
        return currentUserIdResult
    }

}
