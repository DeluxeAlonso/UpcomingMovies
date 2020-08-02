//
//  MovieDetailViewFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

final class MovieDetailViewFactory: MovieDetailViewFactoryProtocol {

    var options: [MovieDetailOption] {
        return [ReviewsMovieDetailOption(),
                TrailersMovieDetailOption(),
                CreditsMovieDetailOption(),
                SimilarsMovieDetailOption()]
    }
    
}
