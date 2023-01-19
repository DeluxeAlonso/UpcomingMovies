//
//  MovieSearchLocalDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public protocol MovieSearchLocalDataSourceProtocol: AnyObject {

    var didUpdateMovieSearch: (() -> Void)? { get set }

    func getMovieSearches(completion: @escaping (Result<[MovieSearch], Error>) -> Void)
    func save(with searchText: String, completion: @escaping (Result<Void, Error>) -> Void)

}
