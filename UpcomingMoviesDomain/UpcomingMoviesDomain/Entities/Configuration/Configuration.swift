//
//  Configuration.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

public struct Configuration {

    public private(set) var imagesConfiguration: ImagesConfiguration
    public private(set) var sortConfiguration: SortConfiguration

    public init(imagesConfiguration: ImagesConfiguration, sortConfiguration: SortConfiguration) {
        self.imagesConfiguration = imagesConfiguration
        self.sortConfiguration = sortConfiguration
    }

}
