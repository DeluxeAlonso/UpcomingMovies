//
//  MovieCreditCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

protocol MovieCreditCellViewModelProtocol {

    var name: String { get }
    var role: String { get }
    var profileURL: URL? { get }
    var accessibilityText: String { get }

}

final class MovieCreditCellViewModel: MovieCreditCellViewModelProtocol {

    let name: String
    let role: String
    let profileURL: URL?
    let accessibilityText: String

    init(cast: CastProtocol) {
        name = cast.name
        role = cast.character
        profileURL = cast.profileURL

        accessibilityText = String(format: LocalizedStrings.movieCreditAccessibility(), name, role)
    }

    init(crew: CrewProtocol) {
        name = crew.name
        role = crew.job
        profileURL = crew.profileURL

        accessibilityText = String(format: LocalizedStrings.movieCreditAccessibility(), name, role)
    }

}
