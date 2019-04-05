//
//  ProfileOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/5/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

/**
 * Type can be Collection(referred to the user movie collections like favorites) or
 * Configuration which represents account configurable settings by the user.
 */
enum ProfileOptionType {
    case collection, configuration
}

enum ProfileOption {
    case favorites, watchlist
    
    var title: String? {
        switch self {
        case .favorites:
            return "Favorites"
        case .watchlist:
            return "Watchlist"
        }
    }
    
    var type: ProfileOptionType {
        switch self {
        case .favorites, .watchlist:
            return .collection
        }
    }
    
}
