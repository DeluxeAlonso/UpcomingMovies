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
    
    public func getMovieVisits() -> [MovieVisit] {
        return localDataSource.getMovieVisits()
    }
    
    public func save(with id: Int, title: String, posterPath: String?) {
        localDataSource.save(with: id, title: title, posterPath: posterPath)
    }
    
    public func hasMovieVisits() -> Bool {
        return localDataSource.hasMovieVisits()
    }

}
