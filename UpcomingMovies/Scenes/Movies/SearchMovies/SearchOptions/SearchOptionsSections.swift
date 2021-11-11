//
//  SearchOptionsSections.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

enum SearchOptionsSection {
    case recentlyVisited, defaultSearches, genres

    var title: String? {
        switch self {
        case .recentlyVisited:
            return LocalizedStrings.recentlyVisitedSeearchSectionTitle()
        case .defaultSearches:
            return nil
        case .genres:
            return LocalizedStrings.movieGenresSearchSectionTitle()
        }
    }

}
