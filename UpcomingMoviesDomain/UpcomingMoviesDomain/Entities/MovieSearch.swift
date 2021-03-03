//
//  MovieSearch.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

public struct MovieSearch {
    
    public let searchText: String
    public let createdAt: Date
    
    public init(searchText: String, createdAt: Date) {
        self.searchText = searchText
        self.createdAt = createdAt
    }
    
}
