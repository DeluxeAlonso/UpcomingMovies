//
//  MovieCreditsFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

final class MovieCreditsFactory: MovieCreditsFactoryProtocol {

    private var castSection = MovieCreditsCollapsibleSection(type: .cast, opened: true)
    private var crewSection = MovieCreditsCollapsibleSection(type: .crew, opened: false)

    var sections: [MovieCreditsCollapsibleSection] {
        [castSection, crewSection].filter { $0.enabled }
    }

    func updateSection(type: MovieCreditsViewSection, enabled: Bool) {
        switch type {
        case .cast:
            castSection.enabled = enabled
        case .crew:
            crewSection.enabled = enabled
        }
    }

    func updateSection(type: MovieCreditsViewSection, opened: Bool) {
        switch type {
        case .cast:
            castSection.opened = opened
        case .crew:
            crewSection.opened = opened
        }
    }
}
