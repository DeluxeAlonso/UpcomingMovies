//
//  MovieSearchRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public final class MovieSearchRepository: MovieSearchUseCaseProtocol {

    private let localDataSource: MovieSearchLocalDataSourceProtocol

    public var didUpdateMovieSearch: (() -> Void)? {
        didSet {
            localDataSource.didUpdateMovieSearch = didUpdateMovieSearch
        }
    }

    init(localDataSource: MovieSearchLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }

    public func getMovieSearches(completion: @escaping (Result<[MovieSearch], Error>) -> Void) {
        localDataSource.getMovieSearches(completion: completion)
    }

    public func save(with searchText: String, completion: @escaping (Result<Void, Error>) -> Void) {
        localDataSource.save(with: searchText, completion: completion)
    }

}
