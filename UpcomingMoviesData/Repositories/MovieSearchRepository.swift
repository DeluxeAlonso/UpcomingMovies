//
//  MovieSearchRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public final class MovieSearchRepository: MovieSearchUseCaseProtocol {
    
    private var localDataSource: MovieSearchLocalDataSourceProtocol
    
    public var didUpdateMovieSearch: (() -> Void)? {
        didSet {
            self.localDataSource.didUpdateMovieSearch = didUpdateMovieSearch
        }
    }
    
    init(localDataSource: MovieSearchLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    public func getMovieSearchs() -> [MovieSearch] {
        return localDataSource.getMovieSearchs()
    }
    
    public func save(with searchText: String) {
        localDataSource.save(with: searchText)
    }
    
}
