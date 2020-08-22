//
//  SortConfiguration.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 8/22/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

public struct SortConfiguration {
    
    private let movieSortKeys: [String]
    
    public init(movieSortKeys: [String]) {
        self.movieSortKeys = movieSortKeys
    }
    
}
