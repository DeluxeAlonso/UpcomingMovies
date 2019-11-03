//
//  GenreRemoteDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import Domain

protocol GenreRemoteDataSourceProtocol {
    
    func getAllGenres(completion: (Result<Genre, Error>) -> Void)
    
}
