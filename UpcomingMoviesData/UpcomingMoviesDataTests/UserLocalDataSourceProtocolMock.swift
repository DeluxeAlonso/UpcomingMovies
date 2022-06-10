//
//  UserLocalDataSourceProtocolMock.swift
//  CollectionViewSlantedLayout
//
//  Created by Alonso on 8/06/22.
//

import Foundation
@testable import UpcomingMoviesData
@testable import UpcomingMoviesDomain

final class UserLocalDataSourceProtocolMock: UserLocalDataSourceProtocol {

    var didUpdateUser: (() -> Void)?

    var findCalled = false
    var findCallCount = 0
    var foundUser: User?
    func find(with id: Int) -> User? {
        findCalled = true
        findCallCount += 1
        return foundUser
    }

    var saveUserCalled = false
    var saveUserCallCount = 0
    func saveUser(_ user: User) {
        saveUserCalled = true
        saveUserCallCount += 1
    }

}
