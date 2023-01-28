//
//  ProfileOptions.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

public protocol ProfileOptionProtocol {

    var title: String? { get }
    var identifier: String { get }

}

public enum ProfileOption: String, ProfileOptionProtocol {

    case favorites, watchlist, recommended, customLists, includeAdult

    public var title: String? {
        switch self {
        case .favorites:
            return LocalizedStrings.favoritesCollectionOption()
        case .watchlist:
            return LocalizedStrings.watchlistCollectionOption()
        case .recommended:
            return LocalizedStrings.recomendedMoviesOption()
        case .customLists:
            return LocalizedStrings.customListGroupOption()
        case .includeAdult:
            return LocalizedStrings.includeAdults()
        }
    }

    public var identifier: String {
        self.rawValue
    }

}
