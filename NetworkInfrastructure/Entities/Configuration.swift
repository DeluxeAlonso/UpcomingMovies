//
//  Configuration.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct ImagesConfiguration: Decodable {
    let baseURLString: String
    let backdropSizes: [String]
    let posterSizes: [String]
    
    private enum CodingKeys: String, CodingKey {
        case baseURLString = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case posterSizes = "poster_sizes"
    }
}

struct ImagesConfigurationResult: Decodable {
    let result: ImagesConfiguration
    
    private enum CodingKeys: String, CodingKey {
        case result = "images"
    }
}

struct Configuration {
    let imagesConfiguration: ImagesConfigurationResult
    
    var baseURLString: String {
        return imagesConfiguration.result.baseURLString
    }
    
    var backdropSizes: [String] {
        return imagesConfiguration.result.backdropSizes
    }
    
    var posterSizes: [String] {
        return imagesConfiguration.result.posterSizes
    }
}

extension Configuration: DomainConvertible {
    
    func asDomain() -> UpcomingMoviesDomain.Configuration {
        let imagesConfiguration = UpcomingMoviesDomain.ImagesConfiguration(baseURLString: baseURLString,
                                                                           backdropSizes: backdropSizes,
                                                                           posterSizes: posterSizes)
        return UpcomingMoviesDomain.Configuration(imagesConfiguration: imagesConfiguration,
                                                  sortConfiguration: SortConfiguration(movieSortKeys: []))
    }
    
}
