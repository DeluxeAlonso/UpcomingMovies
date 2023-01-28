//
//  Entities+GenreName.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/21/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol GenreNameable {

    var genreId: Int? { get }
    var genreName: String { get }

}

extension GenreNameable {

    var genreHandler: GenreHandlerProtocol {
        DIContainer.shared.resolve()
    }

    var genreName: String {
        guard let genreId = genreId,
              let genreName = genreHandler.getGenreName(for: genreId) else {
            return "-"
        }
        return genreName
    }

}

extension Movie: GenreNameable {

    var genreId: Int? {
        genreIds?.first
    }

}
