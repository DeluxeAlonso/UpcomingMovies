//
//  GenreRemoteDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public protocol GenreRemoteDataSourceProtocol: AnyObject {

    func getAllGenres(completion: @escaping (Result<[Genre], Error>) -> Void)

}
