//
//  ProfileOptions.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

public protocol ProfileOptionProtocol {
    
    var title: String? { get }
    
}

/**
 * Referred to the user movie collections like favorites or watchlist.
 */
public enum ProfileCollectionOption: ProfileOptionProtocol {
    
    case favorites, watchlist
    
    public var title: String? {
        switch self {
        case .favorites:
            return LocalizedStrings.favoritesCollectionOption.localized
        case .watchlist:
            return LocalizedStrings.watchlistCollectionOption.localized
        }
    }
    
}

/**
 * Referred to an option that redirects to a group of movie lists and not to a plain movie list.
 */
public enum ProfileGroupOption: ProfileOptionProtocol {
    
    case customLists
    
    public var title: String? {
        switch self {
        case .customLists:
            return LocalizedStrings.customListGroupOption.localized
        }
    }
    
}

/**
 * Represents account configurable settings for the user.
 */
public enum ProfileConfigurationOption: ProfileOptionProtocol {
    
    case includeAdult
    
    public var title: String? {
        switch self {
        case .includeAdult:
            return LocalizedStrings.includeAdults.localized
        }
    }
    
}
