//
//  MovieDetailFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

final class MovieDetailFactory: MovieDetailFactoryProtocol {

    var options: [MovieDetailOption] {
        [.reviews,
         .trailers,
         .credits,
         .similarMovies]
    }

}
