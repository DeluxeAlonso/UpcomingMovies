//
//  UserRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public final class UserRepository: UserUseCaseProtocol {

    private let localDataSource: UserLocalDataSourceProtocol

    public var didUpdateUser: (() -> Void)? {
        didSet {
            localDataSource.didUpdateUser = didUpdateUser
        }
    }

    init(localDataSource: UserLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }

    public func find(with id: Int) -> User? {
        localDataSource.find(with: id)
    }

    public func saveUser(_ user: User) {
        localDataSource.saveUser(user)
    }

}
