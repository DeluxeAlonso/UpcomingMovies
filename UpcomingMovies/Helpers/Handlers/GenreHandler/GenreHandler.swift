//
//  GenreHandler.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/22/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

final class GenreHandler: GenreHandlerProtocol {

    private var genres: [Genre] = []

    init() {}

    func setGenres(_ genres: [Genre]) {
        self.genres = genres
    }

    func getGenreName(for genreId: Int) -> String? {
        guard let genre = genres.filter({ $0.id == genreId }).first else { return nil }
        return genre.name
    }

}
