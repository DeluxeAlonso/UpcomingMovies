//
//  Result.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    
    case success(T)
    case failure(U)
    
}
