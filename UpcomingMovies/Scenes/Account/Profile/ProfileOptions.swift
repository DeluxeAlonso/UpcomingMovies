//
//  ProfileOptions.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

/**
 * A profile option can be a Collection(referred to the user movie
 * collections like favorites) or a Configuration which represents
 * account configurable settings by the user.
 */
struct ProfileOptions {
    
    let collectionOptions: [ProfileCollectionOption]
    let configurationOptions: [ProfileConfigurationOption]
    
}

enum ProfileCollectionOption {
    
    case favorites, watchlist
    
    var title: String? {
        switch self {
        case .favorites:
            return "Favorites"
        case .watchlist:
            return "Watchlist"
        }
    }
    
}

enum ProfileConfigurationOption {
    
    case includeAdult
    
    var title: String? {
        switch self {
        case .includeAdult:
            return "Include adult movies"
        }
    }
    
}
