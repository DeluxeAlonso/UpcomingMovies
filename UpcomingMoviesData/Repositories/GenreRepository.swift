//
//  GenreRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public final class GenreRepository: GenreUseCaseProtocol {
    
    private var localDataSource: GenreLocalDataSourceProtocol
    private var remoteDataSource: GenreRemoteDataSourceProtocol?
    
    init(localDataSource: GenreLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    public var didUpdateGenre: (() -> Void)? {
        didSet {
            self.localDataSource.didUpdateGenre = didUpdateGenre
        }
    }
    
    public func find(with id: Int) -> Genre? {
        return localDataSource.find(with: id)
    }
    
    public func findAll() -> [Genre] {
        return localDataSource.findAll()
    }
    
    public func saveGenres(_ genres: [Genre]) {
        localDataSource.saveGenres(genres)
    }
    
    public func fetchAll(completion: Result<Genre, Error>) {
        
    }
    
}
