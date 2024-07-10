//
//  MovieSearchProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol MovieSearchProtocol {

    var id: String { get }
    var searchText: String { get }
    var createdAt: Date { get }
}

struct MovieSearchModel: MovieSearchProtocol {

    let id: String
    let searchText: String
    let createdAt: Date

    init(_ movieSearch: MovieSearch) {
        self.id = movieSearch.id
        self.searchText = movieSearch.searchText
        self.createdAt = movieSearch.createdAt
    }

}
