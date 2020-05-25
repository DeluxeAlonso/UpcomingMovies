//
//  Configuration.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 5/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

public struct Configuration {
    public let imagesConfiguration: ImagesConfiguration
    
    public init(imagesConfiguration: ImagesConfiguration) {
        self.imagesConfiguration = imagesConfiguration
    }
}
