//
//  MovieDetailFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class MovieDetailFactory: MovieDetailFactoryProtocol {

    var options: [MovieDetailOption] {
        return [.reviews,
                .trailers,
                .credits,
                .similarMovies]
    }
    
}
