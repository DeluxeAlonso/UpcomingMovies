//
//  Entities+ImageConfiguration.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

extension Movie {
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        let urlString = ConfigurationHandler.shared.regularImageBaseURLString + posterPath
        return URL(string: urlString)
    }
    
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        let urlString = ConfigurationHandler.shared.backdropImageBaseURLString + backdropPath
        return URL(string: urlString)
    }

}

extension Cast {
    
    var profileURL: URL? {
        guard let photoPath = photoPath else { return nil }
        let urlString = ConfigurationHandler.shared.regularImageBaseURLString + photoPath
        return URL(string: urlString)
    }
    
}

extension Crew {
    
    var profileURL: URL? {
        guard let photoPath = photoPath else { return nil }
        let urlString = ConfigurationHandler.shared.regularImageBaseURLString + photoPath
        return URL(string: urlString)
    }
    
}

extension List {

    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        let urlString = ConfigurationHandler.shared.backdropImageBaseURLString + backdropPath
        return URL(string: urlString)
    }

}
