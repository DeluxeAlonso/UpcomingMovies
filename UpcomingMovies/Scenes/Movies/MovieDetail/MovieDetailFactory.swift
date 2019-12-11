//
//  MovieDetailFactory.swift
//  UpcomingMovies
//
//  Created by Alonso on 12/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

class MovieDetailFactory {
    
    class func getOptions() -> [MovieDetailOption] {
        return [ReviewsMovieDetailOption(),
                TrailersMovieDetailOption(),
                CreditsMovieDetailOption(),
                SimilarsMovieDetailOption()]
    }
    
}
