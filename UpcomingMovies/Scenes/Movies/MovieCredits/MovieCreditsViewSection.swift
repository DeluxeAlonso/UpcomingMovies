//
//  MovieCreditsViewSection.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

final class MovieCreditsCollapsibleSection {

    let type: MovieCreditsViewSection
    var opened: Bool
    var enabled: Bool

    init(type: MovieCreditsViewSection,
         opened: Bool,
         enabled: Bool = true) {
        self.type = type
        self.opened = opened
        self.enabled = enabled
    }

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
