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
 * collections like favorites), a Group(referred to the
 * option that redirects to a group of collections and not to a plain movie list)
 * or a Configuration which represents account configurable settings by the user.
 */
struct ProfileOptions {
    
    let collectionOptions: [ProfileCollectionOption]
    let groupOptions: [ProfileGroupOption]
    let configurationOptions: [ProfileConfigurationOption]
    
}

protocol ProfileOption {
    
    var title: String? { get }
    
}

enum ProfileCollectionOption: ProfileOption {
    
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

enum ProfileGroupOption: ProfileOption {
    
    case createdLists
    
    var title: String? {
        switch self {
        case .createdLists:
            return "Created Lists"
        }
    }
    
}

enum ProfileConfigurationOption: ProfileOption {
    
    case includeAdult
    
    var title: String? {
        switch self {
        case .includeAdult:
            return "Include adult movies"
        }
    }
    
}
