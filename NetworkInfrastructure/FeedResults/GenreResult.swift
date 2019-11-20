//
//  GenreResult.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct GenreResult: Decodable {
    
    let genres: [Genre]

}
