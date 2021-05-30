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
            .groups,
            .signOut
        ]
    }
    
    var collectionOptions: [ProfileCollectionOption] {
        return [.favorites, .watchlist]
    }

    var recommendedOptions: [ProfileCollectionOption] {
        return [.recommended]
    }
    
    var groupOptions: [ProfileGroupOption] {
        return [.customLists]
    }
    
    var configurationOptions: [ProfileConfigurationOption] {
        return []
    }
    
}
