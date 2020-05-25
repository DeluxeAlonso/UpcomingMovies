//
//  ImagesConfiguration.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

public struct ImagesConfiguration {
    public let baseURLString: String
    public let backdropSizes: [String]
    public let posterSizes: [String]
    
    public init(baseURLString: String, backdropSizes: [String], posterSizes: [String]) {
        self.baseURLString = baseURLString
        self.backdropSizes = backdropSizes
        self.posterSizes = posterSizes
    }
}
