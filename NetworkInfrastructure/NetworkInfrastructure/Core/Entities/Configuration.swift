//
//  Configuration.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

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

struct SortConfigurationResult {

    let movieSortKeys: [String]

}

struct Configuration {

    let imagesConfiguration: ImagesConfigurationResult
    let sortConfiguration: SortConfigurationResult

    var baseURLString: String {
        imagesConfiguration.result.baseURLString
    }

    var backdropSizes: [String] {
        imagesConfiguration.result.backdropSizes
    }

    var posterSizes: [String] {
        imagesConfiguration.result.posterSizes
    }

    var movieSortKeys: [String] {
        sortConfiguration.movieSortKeys
    }

}

extension Configuration: DomainConvertible {

    func asDomain() -> UpcomingMoviesDomain.Configuration {
        let imagesConfiguration = UpcomingMoviesDomain.ImagesConfiguration(baseURLString: baseURLString,
                                                                           backdropSizes: backdropSizes,
                                                                           posterSizes: posterSizes)
        let sortConfiguration = UpcomingMoviesDomain.SortConfiguration(movieSortKeys: movieSortKeys)

        return UpcomingMoviesDomain.Configuration(imagesConfiguration: imagesConfiguration,
                                                  sortConfiguration: sortConfiguration)
    }

}
