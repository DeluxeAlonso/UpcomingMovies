//
//  MovieVisitRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public final class MovieVisitRepository: MovieVisitUseCaseProtocol {

    private var localDataSource: MovieVisitLocalDataSourceProtocol

    public var didUpdateMovieVisit: (() -> Void)? {
        didSet {
            self.localDataSource.didUpdateMovieVisit = didUpdateMovieVisit
        }
    }

    init(localDataSource: MovieVisitLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }

    public func getMovieVisits(completion: @escaping (Result<[MovieVisit], Error>) -> Void) {
        localDataSource.getMovieVisits(completion: { result in
            let movieVisits = try? result.get()
            completion(.success(movieVisits ?? []))
        })
    }

    public func save(with id: Int, title: String, posterPath: String?,
                     completion: @escaping (Result<Void, Error>) -> Void) {
        localDataSource.save(with: id, title: title, posterPath: posterPath, completion: completion)
    }

}
