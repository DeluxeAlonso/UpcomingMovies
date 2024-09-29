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
        var sectionToUpdate = sections.first(where: { $0.type == type })
        sectionToUpdate?.enabled = enabled
    }

    func updateSection(type: MovieCreditsViewSection, opened: Bool) {
        var sectionToUpdate = sections.first(where: { $0.type == type })
        sectionToUpdate?.enabled = enabled
    }
}
