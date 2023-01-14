//
//  AuthRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class AuthRepository: AuthUseCaseProtocol {

    private let remoteDataSource: AuthRemoteDataSourceProtocol

    init(remoteDataSource: AuthRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func getAuthURL(completion: @escaping (Result<URL, Error>) -> Void) {
        remoteDataSource.getAuthURL(completion: completion)
    }

    func signInUser(completion: @escaping (Result<User, Error>) -> Void) {
        remoteDataSource.signInUser(completion: completion)
    }

    func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.signOutUser(completion: completion)
    }

    func currentUserId() -> Int? {
        remoteDataSource.currentUserId()
    }

}
