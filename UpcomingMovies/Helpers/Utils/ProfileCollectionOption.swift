//
//  ProfileCollectionOption.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

/**
 * A profile option can be a Collection(referred to the user movie
 * collections like favorites), a Group(referred to the
 * option that redirects to a group of collections and not to a plain movie list)
 * or a Configuration which represents account configurable settings by the user.
 */
public struct ProfileOptions {

    public let collectionOptions: [ProfileCollectionOption]
    public let groupOptions: [ProfileGroupOption]
    public let configurationOptions: [ProfileConfigurationOption]

    public init(collectionOptions: [ProfileCollectionOption],
                groupOptions: [ProfileGroupOption],
                configurationOptions: [ProfileConfigurationOption]) {
        self.collectionOptions = collectionOptions
        self.groupOptions = groupOptions
        self.configurationOptions = configurationOptions
    }

}

public protocol ProfileOptionProtocol {

    var title: String? { get }

}

public enum ProfileCollectionOption: ProfileOptionProtocol {

    case favorites, watchlist

    public var title: String? {
        switch self {
        case .favorites:
            return NSLocalizedString("favoritesCollectionOption", comment: "")
        case .watchlist:
            return NSLocalizedString("watchlistCollectionOption", comment: "")
        }
    }

}

public enum ProfileGroupOption: ProfileOptionProtocol {

    case customLists

    public var title: String? {
        switch self {
        case .customLists:
            return NSLocalizedString("customListGroupOption", comment: "")
        }
    }

}

public enum ProfileConfigurationOption: ProfileOptionProtocol {

    case includeAdult

    public var title: String? {
        switch self {
        case .includeAdult:
            return NSLocalizedString("includeAdults", comment: "")
        }
    }

}
