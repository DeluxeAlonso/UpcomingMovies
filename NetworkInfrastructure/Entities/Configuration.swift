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
}

struct Configuration: Decodable {
    let images: ImagesConfiguration
}

extension Configuration: DomainConvertible {
    
    func asDomain() -> UpcomingMoviesDomain.Configuration {
        let imagesConfiguration = UpcomingMoviesDomain.ImagesConfiguration(baseURLString: images.baseURLString,
                                                                           backdropSizes: images.backdropSizes,
                                                                           posterSizes: images.posterSizes)
        return UpcomingMoviesDomain.Configuration(imagesConfiguration: imagesConfiguration)
    }
    
}
