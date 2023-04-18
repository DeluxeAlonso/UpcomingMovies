//
//  UserLocalDataSourceProtocolMock.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 8/06/22.
//

@testable import UpcomingMoviesDomain

final class UserLocalDataSourceProtocolMock: UserLocalDataSourceProtocol {

    var didUpdateUser: (() -> Void)?

    private(set) var findCallCount = 0
    var foundUser: User?
    func find(with id: Int) -> User? {
        findCallCount += 1
        return foundUser
    }

    private(set) var saveUserCallCount = 0
    func saveUser(_ user: User) {
        saveUserCallCount += 1
    }

}
