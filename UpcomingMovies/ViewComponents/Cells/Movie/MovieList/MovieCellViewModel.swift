//
//  MovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import Domain

final class MovieCellViewModel {
    
    var name: String?
    var genre: String? = "-"
    var releaseDate: String?
    var posterURL: URL?
    var voteAverage: Double?

    init(_ movie: Movie, genreUseCase: GenreUseCaseProtocol) {
        name = movie.title
        
        if let genreId = movie.genreIds?.first {
            genre = genreUseCase.find(with: genreId)?.name ?? "-"
        }
        
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        posterURL = movie.posterURL
    }
    
}
