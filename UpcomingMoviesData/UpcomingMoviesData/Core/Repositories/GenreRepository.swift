//
//  GenreRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public final class GenreRepository: GenreUseCaseProtocol {

    private let localDataSource: GenreLocalDataSourceProtocol
    private let remoteDataSource: GenreRemoteDataSourceProtocol

    init(localDataSource: GenreLocalDataSourceProtocol,
         remoteDataSource: GenreRemoteDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    public var didUpdateGenre: (() -> Void)? {
        didSet {
            localDataSource.didUpdateGenre = didUpdateGenre
        }
    }

    public func find(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void) {
        completion(.success(localDataSource.find(with: id)))
    }

    public func fetchAll(completion: @escaping (Result<[Genre], Error>) -> Void, forceRefresh: Bool) {
        let localGenres = localDataSource.findAll()
        let shouldReturnRemoteResult = localGenres.isEmpty || forceRefresh

        if !shouldReturnRemoteResult { completion(.success(localGenres)) }

        remoteDataSource.getAllGenres(completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let remoteGenres):
                self.localDataSource.saveGenres( remoteGenres)
                if shouldReturnRemoteResult { completion(.success(remoteGenres)) }
            case .failure(let error):
                if shouldReturnRemoteResult { completion(.failure(error)) }
            }
        })
    }

}
