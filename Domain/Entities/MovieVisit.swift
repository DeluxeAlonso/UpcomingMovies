//
//  MovieVisit.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public struct MovieVisit: Decodable {
    
    public let id: Int
    public let title: String
    public let posterPath: String
    public let createdAt: Date?
    
}
