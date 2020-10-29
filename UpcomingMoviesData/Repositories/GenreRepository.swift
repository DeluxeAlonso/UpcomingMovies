//
//  GenreRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public final class GenreRepository: GenreUseCaseProtocol {
    
    private var localDataSource: GenreLocalDataSourceProtocol
    private var remoteDataSource: GenreRemoteDataSourceProtocol
    
    init(localDataSource: GenreLocalDataSourceProtocol,
         remoteDataSource: GenreRemoteDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    public var didUpdateGenre: (() -> Void)? {
        didSet {
            self.localDataSource.didUpdateGenre = didUpdateGenre
        }
    }

    public func find(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void) {
        return completion(.success(localDataSource.find(with: id)))
    }
    
    public func fetchAll(completion: @escaping (Result<[Genre], Error>) -> Void) {
        let localGenres = localDataSource.findAll()
        if !localGenres.isEmpty { completion(.success(localGenres)) }
        
        remoteDataSource.getAllGenres(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let remoteGenres):
                strongSelf.localDataSource.saveGenres(remoteGenres)
                if localGenres.isEmpty { completion(.success(remoteGenres)) }
            case .failure:
                break
            }
        })
    }
    
}
