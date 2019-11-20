//
//  CreditResult.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/13/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct CreditResult: Decodable {

    let id: Int
    let cast: [Cast]
    let crew: [Crew]
    
}
