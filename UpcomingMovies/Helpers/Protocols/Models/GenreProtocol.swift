//
//  GenreProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol GenreProtocol {

    var id: Int { get }
    var name: String { get }

}

struct GenreModel: GenreProtocol {

    let id: Int
    let name: String

    init(_ genre: Genre) {
        self.id = genre.id
        self.name = genre.name
    }

}
