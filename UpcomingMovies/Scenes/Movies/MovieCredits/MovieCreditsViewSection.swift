//
//  MovieCreditsViewSection.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

class MovieCreditsCollapsibleSection: Equatable {
    let type: MovieCreditsViewSection
    var opened: Bool
}

enum MovieCreditsViewSection {
    case cast, crew

    var title: String {
        switch self {
        case .cast:
            return LocalizedStrings.cast()
        case .crew:
            return LocalizedStrings.crew()
        }
    }

}
