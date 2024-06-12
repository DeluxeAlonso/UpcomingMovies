//
//  ListProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/06/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol ListProtocol {

    var id: String { get }
    var name: String { get }
    var description: String? { get }
    var backdropPath: String? { get }
    var averageRating: Double? { get }
    var runtime: Int? { get }
    var movieCount: Int { get }
    var movies: [MovieProtocol]? { get }
    var revenue: Double? { get }

}
