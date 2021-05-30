//
//  ProfileFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/18/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

final class ProfileFactory: ProfileFactoryProtocol {
    
    var sections: [ProfileSection] {
        return [
            .accountInfo,
            .collections,
            .recommended,
            .customLists,
            .signOut
        ]
    }

    func profileOptions(for section: ProfileSection) -> [ProfileOptionProtocol] {
        switch section {
        case .accountInfo, .signOut:
            return []
        case .collections:
            return [ProfileOption.favorites, ProfileOption.watchlist]
        case .recommended:
            return [ProfileOption.recommended]
        case .customLists:
            return [ProfileOption.customLists]
        }
    }
    
//    var collectionOptions: [ProfileCollectionOption] {
//        return [.favorites, .watchlist]
//    }
//
//    var recommendedOptions: [ProfileCollectionOption] {
//        return [.recommended]
//    }
//    
//    var groupOptions: [ProfileGroupOption] {
//        return [.customLists]
//    }
//    
//    var configurationOptions: [ProfileConfigurationOption] {
//        return []
//    }
    
}
