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
    case recomendedMoviesOption
    case includeAdults
    
    case signOutConfirmationTitle
    case signOut
    
    case emptyMovieResults
    case emptyVideoResults
    case emptyCreditReults
    
    case movieDetailTitle
    case movieDetailShareText
    case reviewsDetailOptions
    case trailersDetailOptions
    case creditsDetailOptions
    case similarsDetailOptions
    
    case movieCreditAccessibility
    
    case addToFavoritesHint
    case removeFromFavoritesHint
    case addToFavoritesSuccess
    case removeFromFavoritesSuccess
    
    case expandMovieCellsHint
    case collapseMovieCellsHint
    
    case topRatedMoviesTitle
    case popularMoviesTitle
    case similarMoviesTitle

    case cast
    case crew

    case ratingHint

    case cancel

    case shareMovieActionSheetItemTitle
    
    var tableName: String {
        return "Localizable"
    }

    func callAsFunction() -> String {
        return self.localized
    }
    
}
