//
//  LocalizedStrings.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/3/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

protocol Localizable {
    
    var tableName: String { get }
    var localized: String { get }
    
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
    
}

enum LocalizedStrings: String, Localizable {
    
    case upcomingMoviesTabBarTitle
    case upcomingMoviesTitle
    
    case searchMoviesTabBarTitle
    case searchMoviesTitle
    case recentSearches
    case emptySearchResults
    
    case recentlyVisitedSeearchSectionTitle
    case movieGenresSearchSectionTitle
    
    case favoritesTabBarTitle
    case favoritesTitle
    
    case accountTabBarTitle
    case accountTitle
    
    case favoritesCollectionOption
    case watchlistCollectionOption
    case customListGroupOption
    case includeAdults
    
    case signOut
    
    case emptyMovieResults
    case emptyVideoResults
    
    case movieDetailTitle
    case reviewsDetailOptions
    case trailersDetailOptions
    case creditsDetailOptions
    case similarsDetailOptions
    
    var tableName: String {
        return "Localizable"
    }
    
}
