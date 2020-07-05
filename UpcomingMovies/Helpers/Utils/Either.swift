//
//  Either.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/4/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

enum Either<A, B> {
    
    case left(A)
    case right(B)
    
}
