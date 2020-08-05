//
//  MovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol MovieCellViewModelProtocol {
    
    var name: String { get }
    var genreName: String? { get }
    var releaseDate: String? { get }
    var posterURL: URL? { get }
    var voteAverage: Double? { get }
    
}

final class MovieCellViewModel: MovieCellViewModelProtocol {
    
    let name: String
    let genreName: String?
    let releaseDate: String?
    let posterURL: URL?
    let voteAverage: Double?

    init(_ movie: Movie, genreHandler: GenreHandler = GenreHandler.shared) {
        self.name = movie.title
        if let genreId = movie.genreIds?.first {
            self.genreName = genreHandler.getGenreName(for: genreId)
        } else {
            self.genreName = "-"
        }
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        self.posterURL = movie.posterURL
    }
    
}
