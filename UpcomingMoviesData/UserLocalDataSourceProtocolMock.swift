//
//  UserLocalDataSourceProtocolMock.swift
//  CollectionViewSlantedLayout
//
//  Created by Alonso on 8/06/22.
//

import Foundation
@testable import UpcomingMoviesData
@testable import UpcomingMoviesDomain

class UserLocalDataSourceProtocolMock: UserLocalDataSourceProtocol {

    var didUpdateUser: (() -> Void)?

    var findCalled = false
    var foundUser: User?
    func find(with id: Int) -> User? {
        findCalled = true
        return foundUser
    }

    var saveUserCalled = false
    func saveUser(_ user: User) {
        saveUserCalled = true
    }

}
