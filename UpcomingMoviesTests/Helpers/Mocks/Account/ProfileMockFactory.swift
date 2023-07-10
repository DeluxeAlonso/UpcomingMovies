//
//  ProfileMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/18/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class MockProfileInteractor: ProfileInteractorProtocol {

    var signOutUserResult: Result<Bool, Error>?
    private(set) var signOutUserCallCount = 0
    func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        if let signOutUserResult {
            completion(signOutUserResult)
        }
        signOutUserCallCount += 1
    }

    var getAccountDetailResult: Result<User, Error>?
    private(set) var getAccountDetailCallCount = 0
    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void) {
        if let getAccountDetailResult {
            completion(getAccountDetailResult)
        }
        getAccountDetailCallCount += 1
    }

}

final class MockProfileViewFactory: ProfileFactoryProtocol {

    var collectionSectionOptions: [ProfileOptionProtocol] = []
    var recommendedSectionOptions: [ProfileOptionProtocol] = []
    var customListsSectionOptions: [ProfileOptionProtocol] = []

    // MARK: - ProfileFactoryProtocol

    func profileOptions(for section: ProfileSection) -> [ProfileOptionProtocol] {
        switch section {
        case .accountInfo, .signOut:
            return []
        case .collections:
            return collectionSectionOptions
        case .recommended:
            return recommendedSectionOptions
        case .customLists:
            return customListsSectionOptions
        }
    }

    var sections: [ProfileSection] = []

}

final class MockProfileViewControllerDelegate: MockViewController, ProfileViewControllerDelegate {

    private(set) var didTapProfileOptionCallCount = 0
    func profileViewController(didTapProfileOption option: ProfileOptionProtocol) {
        didTapProfileOptionCallCount += 1
    }

    private(set) var didSignOutCallCount = 0
    func profileViewController(didSignOut signedOut: Bool) {
        didSignOutCallCount += 1
    }

}
