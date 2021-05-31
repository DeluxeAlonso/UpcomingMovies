//
//  ProfileMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/18/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

class MockProfileInteractor: ProfileInteractorProtocol {
    
    var getAccountDetailResult: Result<User, Error>?
    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void) {
        completion(getAccountDetailResult!)
    }
    
}

class MockProfileViewFactory: ProfileFactoryProtocol {

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
