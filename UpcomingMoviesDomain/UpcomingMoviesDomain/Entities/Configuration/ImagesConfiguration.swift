//
//  ImagesConfiguration.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

public struct ImagesConfiguration {

    public private(set) var baseURLString: String
    public private(set) var backdropSizes: [String]
    public private(set) var posterSizes: [String]

    public init(baseURLString: String, backdropSizes: [String], posterSizes: [String]) {
        self.baseURLString = baseURLString
        self.backdropSizes = backdropSizes
        self.posterSizes = posterSizes
    }

}
